          # Build stage
FROM node:16 AS builder

WORKDIR /app

COPY . .

RUN npm install

          # Final stage
FROM node:23-alpine3.20

WORKDIR /app

COPY --from=builder /app . 

EXPOSE 3000

CMD ["npm", "start"]

