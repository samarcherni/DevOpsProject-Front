FROM node:16

WORKDIR /app

COPY package.json .
RUN npm install

COPY . .
RUN npm run build --prod

FROM nginx:latest

COPY dist /usr/share/nginx/html

EXPOSE 4208

CMD ["nginx", "-g", "daemon off;"]
