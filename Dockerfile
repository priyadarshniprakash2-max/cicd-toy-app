
FROM node:20-bookworm-slim

WORKDIR /app

# Update Debian packages to include available security fixes.

RUN apt-get update \
    && apt-get full-upgrade -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Update npm to the version tested for this project.
RUN npm install -g npm@11.18.0

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3001
EXPOSE 3002
EXPOSE 3003

CMD ["node", "server.js"]

