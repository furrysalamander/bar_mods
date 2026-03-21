# Minimal sandbox container for opencode
# Place the opencode binary at docker/opencode/opencode before building.
FROM alpine:3.20

# The musl binary still links libstdc++ and libgcc dynamically
RUN apk add --no-cache libstdc++ libgcc ripgrep

# Create non-root user
RUN addgroup -g 1000 opencode && \
    adduser -u 1000 -G opencode -D -h /home/opencode opencode

# Create all directories the process needs to write to
# (the container runs with read_only rootfs, so these must be pre-created
#  and backed by volumes or tmpfs)
RUN mkdir -p /workspace/mods \
             /workspace/output \
             /home/opencode/.config/opencode \
             /home/opencode/.local/share/opencode \
             /home/opencode/.local/state \
             /home/opencode/.cache \
             /home/opencode/.bun && \
    chown -R opencode:opencode /workspace /home/opencode

# Copy the statically compiled opencode binary
COPY opencode /usr/local/bin/opencode
RUN chmod +x /usr/local/bin/opencode

# Copy opencode project config and agent instructions
COPY opencode.json /workspace/opencode.json
COPY AGENTS.md /workspace/AGENTS.md
COPY healthcheck.sh /usr/local/bin/healthcheck.sh
RUN chmod +x /usr/local/bin/healthcheck.sh && \
    chown opencode:opencode /workspace/opencode.json /workspace/AGENTS.md

USER opencode
WORKDIR /workspace

EXPOSE 4096

ENTRYPOINT ["opencode", "serve", "--hostname", "0.0.0.0", "--port", "4096"]
