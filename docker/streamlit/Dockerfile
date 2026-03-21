FROM python:3.12-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY src/ ./src/
COPY .streamlit/ ./.streamlit/

# These will be mounted as volumes in production, but copy defaults for standalone build
COPY mods/ ./mods/
COPY collections.json ./collections.json

RUN mkdir -p output

EXPOSE 8501

ENTRYPOINT ["streamlit", "run", "src/manager.py", \
    "--server.port=8501", \
    "--server.address=0.0.0.0", \
    "--server.headless=true"]
