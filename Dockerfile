FROM node:alpine as builder
WORKDIR /app
COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json
RUN npm install -q --no-color --no-progress
COPY src /app/src/
COPY tsconfig.json /app/tsconfig.json
RUN npm run build

FROM node:alpine
WORKDIR /app
LABEL maintainer="Jason Raimondi <jason.raimondi@eventfarm.com>"
COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json
RUN npm install -q --no-color --no-progress --production
COPY --from=builder /app/dist/ /app/dist/
EXPOSE 3000
