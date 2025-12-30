FROM n8nio/n8n:latest

USER root

# Instala ffmpeg
RUN apk update && apk add --no-cache ffmpeg

# Volta para o usuário do n8n
USER node
