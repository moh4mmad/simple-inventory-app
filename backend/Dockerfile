FROM node:10.24.1
ENV DBHOST=test-database.c8eukzq9vuvd.ap-southeast-2.rds.amazonaws.com
ENV DBUSER=postgres
ENV DBPASS=vlPlGWD5zcKGD0yhzb3T
ENV DBNAME=inventory
ENV NODE_ENV=production
WORKDIR /app
COPY package*.json ./
RUN npm install --force
COPY . .
EXPOSE 8080
RUN mkdir -p /app/uploads
CMD ["npm", "run", "start:production"]