
FROM node:20-bookworm-slim

WORKDIR /app

# Install available updates for existing packages without a full distribution upgrade.
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Use the npm version tested for this project.
RUN npm install -g npm@11.18.0

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3001
EXPOSE 3002
EXPOSE 3003

CMD ["node", "server.js"]

