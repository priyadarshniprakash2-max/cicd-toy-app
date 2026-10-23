# Stage 1: Install application dependencies
FROM node:22-trixie-slim AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci --omit=dev

COPY . .

# Stage 2: Minimal, non-root runtime
FROM gcr.io/distroless/nodejs22-debian13:nonroot

WORKDIR /app

ENV NODE_ENV=production

COPY --from=builder --chown=nonroot:nonroot /app /app

EXPOSE 3001

CMD ["server.js"]
