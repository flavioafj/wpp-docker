FROM node:lts-alpine3.18 as builder
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
WORKDIR /home/node


RUN npm i --save @wppconnect-team/wppconnect 

COPY package*.json .
COPY functions.js .
COPY index.js .
COPY regex.js .

FROM node:lts-alpine3.18
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

RUN apk add chromium
COPY --from=builder /home/node/ .

CMD [ "npm", "start", "wppconnect" ]
