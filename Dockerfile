
FROM node:22-bookworm-slim

WORKDIR /app

# Install OS security updates without manually upgrading
# packages during the Docker build.
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Keep the npm version required by this project.
RUN npm install -g npm@11.18.0

# Install application dependencies.
COPY package*.json ./
RUN npm ci

# Copy application source.
COPY . .

EXPOSE 3001
EXPOSE 3002
EXPOSE 3003

CMD ["node", "server.js"]
