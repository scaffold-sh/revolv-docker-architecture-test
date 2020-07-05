# Builder image

FROM node:12.13.0-alpine AS builder

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY package*.json ./
RUN npm install

# Bundle app source
COPY . .

RUN npm run container:build
RUN npm run container:clean:build-for-prod


# Production image

FROM node:12.13.0-alpine

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY package*.json ./
RUN npm ci --only=production

# Bundle app source
COPY --from=builder /usr/src/app/dist dist

RUN chmod +x ./dist/bin/predeploy.sh

EXPOSE 8080

CMD [ "npm", "run", "container:start:prod" ]