FROM node:18.14.2-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install 
COPY . .
EXPOSE 4200
CMD ["npm","start"]