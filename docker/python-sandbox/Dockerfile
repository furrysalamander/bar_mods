# Lightweight Python sandbox for the BAR mod bot.
# Spun up on-demand by ContainerManager — NOT a long-running service.
FROM python:3.12-slim

# Install common data/analysis libraries
RUN pip install --no-cache-dir \
    numpy \
    pandas \
    matplotlib \
    tabulate

# Non-root user for security (UID 1000 matches the chown in ContainerManager)
RUN groupadd -g 1000 sandbox && useradd -u 1000 -g sandbox -d /workspace sandbox

# Working directory — session volume will be mounted here
WORKDIR /workspace
RUN chown sandbox:sandbox /workspace

USER sandbox
