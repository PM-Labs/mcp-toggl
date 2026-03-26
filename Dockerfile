FROM node:22-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY server.js ./

FROM node:22-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install --omit=dev
COPY --from=builder /app/server.js ./
ENV PORT=8080
EXPOSE 8080
CMD ["node", "server.js"]
