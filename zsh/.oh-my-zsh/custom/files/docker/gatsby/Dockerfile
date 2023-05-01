FROM node:13

RUN yarn global add gatsby-cli \
    && gatsby telemetry --disable

WORKDIR /usr/app/

VOLUME /usr/app

EXPOSE 8000

CMD tail -f /dev/null
