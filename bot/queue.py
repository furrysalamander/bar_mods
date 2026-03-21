"""Simple async job queue for mod generation.

Enforces single-session processing: only one mod generation runs at a time.
Additional requests are queued and processed in order.
"""

from __future__ import annotations

import asyncio
import logging
from dataclasses import dataclass, field
from typing import Any, Callable, Coroutine

log = logging.getLogger(__name__)


@dataclass
class Job:
    """A queued mod-generation job."""
    id: str
    coro_factory: Callable[[], Coroutine[Any, Any, Any]]
    future: asyncio.Future = field(default_factory=lambda: asyncio.get_event_loop().create_future())
    position: int = 0


class ModQueue:
    """FIFO queue that processes one job at a time."""

    def __init__(self) -> None:
        self._queue: asyncio.Queue[Job] = asyncio.Queue()
        self._current: Job | None = None
        self._worker_task: asyncio.Task | None = None
        self._counter = 0

    @property
    def current_job(self) -> Job | None:
        return self._current

    @property
    def pending_count(self) -> int:
        return self._queue.qsize()

    def start(self) -> None:
        """Start the background worker. Call once after the event loop is running."""
        if self._worker_task is None or self._worker_task.done():
            self._worker_task = asyncio.create_task(self._worker())
            log.info("ModQueue worker started")

    async def stop(self) -> None:
        """Gracefully stop the worker."""
        if self._worker_task and not self._worker_task.done():
            self._worker_task.cancel()
            try:
                await self._worker_task
            except asyncio.CancelledError:
                pass
            log.info("ModQueue worker stopped")

    async def submit(self, coro_factory: Callable[[], Coroutine[Any, Any, Any]]) -> Job:
        """Submit a new job and return the Job handle.

        The caller can await ``job.future`` to get the result.
        ``coro_factory`` is a zero-arg callable that returns the coroutine to run
        (we defer creation so it runs in the worker context).
        """
        self._counter += 1
        job = Job(
            id=str(self._counter),
            coro_factory=coro_factory,
            future=asyncio.get_event_loop().create_future(),
            position=self._queue.qsize() + 1,
        )
        await self._queue.put(job)
        log.info("Job %s queued at position %d", job.id, job.position)
        return job

    async def _worker(self) -> None:
        """Process jobs one at a time, forever."""
        while True:
            job = await self._queue.get()
            self._current = job
            log.info("Processing job %s", job.id)
            try:
                result = await job.coro_factory()
                if not job.future.done():
                    job.future.set_result(result)
            except asyncio.CancelledError:
                if not job.future.done():
                    job.future.cancel()
                raise
            except Exception as exc:
                log.exception("Job %s failed", job.id)
                if not job.future.done():
                    job.future.set_exception(exc)
            finally:
                self._current = None
                self._queue.task_done()
