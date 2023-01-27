FROM node:10
ENV DBHOST=inventory-db.c8eukzq9vuvd.ap-southeast-2.rds.amazonaws.com
ENV DBUSER=postgres
ENV DBPASS=qRnvuUg8x6QDvFWXacdg
ENV DBNAME=inventory
WORKDIR /app
COPY package.json .
RUN npm install 
COPY . .
EXPOSE 8080
RUN mkdir -p /app/uploads
CMD ["npm", "run", "start:production"]