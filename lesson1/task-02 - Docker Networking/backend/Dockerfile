FROM node:18-alpine

WORKDIR /app

COPY app.js .

RUN npm install express mongoose --save

CMD ["node", "app.js"]
