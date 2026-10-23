
FROM node:20-bookworm-slim

WORKDIR /app

# Refresh package metadata and upgrade installed OS packages.
# Repair package metadata if needed before installing security updates.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates \
       dpkg \
       apt \
    && apt-get upgrade -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Keep the npm version used by this project.
RUN npm install -g npm@11.18.0

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3001
EXPOSE 3002
EXPOSE 3003

CMD ["node", "server.js"]
