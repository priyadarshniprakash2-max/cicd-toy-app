
FROM node:22-bookworm-slim

WORKDIR /app

# Refresh package metadata without upgrading Debian packages in-place.
RUN apt-get update \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Keep the project's npm version.
RUN npm install -g npm@11.18.0

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3001
EXPOSE 3002
EXPOSE 3003

CMD ["node", "server.js"]
