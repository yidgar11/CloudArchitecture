# Stage 1: Build
FROM node:16 AS builder
LABEL authors="yidgar"
WORKDIR /app
COPY package.json ./
RUN npm install
COPY server.js ./
RUN npm run build

# Stage 2: Runtime
FROM node:16-alpine
WORKDIR /app
RUN apk add curl
COPY --from=builder /app/dist /app
CMD ["node", "server.js"]