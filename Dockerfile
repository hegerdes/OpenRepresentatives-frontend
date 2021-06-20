FROM node:14-buster-slim

WORKDIR /app/frontend
COPY . /app/frontend

RUN npm install && npm run generate

EXPOSE 3000
ENTRYPOINT [ "npm", "start" ]