FROM node:14 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build --prod
FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /app/dist/crudtuto-Front /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
