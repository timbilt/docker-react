FROM node:16.20.2-alpine3.18 as builder

USER node

RUN mkdir -p /home/node/app

WORKDIR /home/node/app

COPY --chown=node:node package.json .

RUN yarn install

COPY --chown=node:node . .

RUN yarn build

FROM nginx

EXPOSE 80

COPY --from=builder /home/node/app/build /usr/share/nginx/html