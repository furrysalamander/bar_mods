FROM python:3.12-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY src/ ./src/
COPY bot/ ./bot/
COPY advanced_modding_report.md .
COPY .github/copilot-instructions.md ./copilot-instructions.md

# Mods and output dirs will be mounted as volumes
COPY mods/ ./mods/
RUN mkdir -p output

ENTRYPOINT ["python", "-m", "bot.main"]
