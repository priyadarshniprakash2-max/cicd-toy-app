FROM node:20-bookworm

RUN npm install -g npm@11.18.0

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3001
EXPOSE 3002
EXPOSE 3003

CMD ["node", "server.js"]
