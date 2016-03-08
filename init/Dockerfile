FROM alpine

COPY ./init.sh /docker-entrypoint.sh

RUN apk add --update curl bash && rm -rf /var/cache/apk/*

ENTRYPOINT ["/docker-entrypoint.sh"]
