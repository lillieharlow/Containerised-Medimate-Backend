# syntax=docker/dockerfile:1

FROM node:20-alpine AS base
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
EXPOSE 5000

# ---------- DEV ----------
FROM base AS dev
ENV NODE_ENV=development
ENV PORT=5000
CMD ["npm", "run", "dev"]

# ---------- TEST ----------
FROM base AS test
ENV NODE_ENV=test
CMD ["npm", "test"]

# ---------- PRODUCTION ----------
FROM base AS production
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser
ENV NODE_ENV=production
ENV PORT=5000
CMD ["npm", "start"]