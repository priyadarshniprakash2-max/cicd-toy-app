
FROM node:20-bookworm-slim

WORKDIR /app

# Install no OS upgrades during the build.
# Pulling the latest available base image is handled by docker build --pull.
RUN apt-get update \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Keep the npm version required by this project.
RUN npm install -g npm@11.18.0

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3001
EXPOSE 3002
EXPOSE 3003

CMD ["node", "server.js"]
