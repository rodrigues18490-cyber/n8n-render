FROM n8nio/n8n:latest

USER root

RUN set -eux; \
  echo "=== OS RELEASE ==="; (cat /etc/os-release || true); \
  echo "=== WHOAMI / UID ==="; whoami; id; \
  echo "=== PACKAGE MANAGERS ==="; \
  (command -v apk && apk --version) || echo "apk not found"; \
  (command -v apt-get && apt-get --version | head -n 1) || echo "apt-get not found"; \
  echo "=== TRY INSTALL FFMPEG ==="; \
  if command -v apk >/dev/null 2>&1; then \
    apk update || true; \
    apk add --no-cache ffmpeg; \
  elif command -v apt-get >/dev/null 2>&1; then \
    apt-get update; \
    apt-get install -y ffmpeg; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*; \
  else \
    echo "No supported package manager found (apk/apt-get)"; \
    exit 1; \
  fi; \
  echo "=== FFMPEG VERSION ==="; \
  (ffmpeg -version || true)

USER node