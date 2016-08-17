FROM mongo

RUN apt-get update
RUN apt-get -y --no-install-recommends install curl

COPY ./init.sh /docker-entrypoint.sh
COPY replica_set.js /

ENTRYPOINT ["/docker-entrypoint.sh"]
