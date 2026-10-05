# Stage 1: install production dependencies
FROM node:20-bookworm-slim AS dependencies

WORKDIR /app

COPY package*.json ./

RUN npm ci --omit=dev

# Stage 2: production image
FROM node:20-bookworm-slim

WORKDIR /app

# Create a dedicated non-root user
RUN groupadd --system appgroup && \
    useradd --system --gid appgroup appuser

# Copy only what the application needs
COPY --from=dependencies /app/node_modules ./node_modules
COPY package*.json ./
COPY server.js ./
COPY public ./public
COPY env ./env

# Run as non-root user
USER appuser

EXPOSE 3001 3002 3003

CMD ["node", "server.js"]
