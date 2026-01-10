FROM node:20-bookworm-slim

RUN apt-get update && apt-get install -y openssl && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY backend/package*.json ./
COPY backend/prisma ./prisma/

RUN npm install

COPY backend/ .
RUN npm run build

EXPOSE 8080

CMD ["sh", "-c", "npx prisma db push --accept-data-loss && npm run start:prod"]
