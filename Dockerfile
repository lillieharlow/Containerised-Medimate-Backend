# syntax=docker/dockerfile:1

FROM node:20-alpine AS base
WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .

EXPOSE 5000

FROM base AS dev
ENV NODE_ENV=development
ENV PORT=5000

CMD ["npm", "run", "dev"]