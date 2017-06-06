FROM gliderlabs/alpine:edge

MAINTAINER Zach Brown <github@prozach.org>

RUN apk add --update less curl sngrep ngrep \
      asterisk asterisk-curl asterisk-sample-config \
&&  rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

# start asterisk so it creates missing folders and initializes astdb
RUN asterisk && sleep 5

ADD docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/asterisk", "-vvvdddf", "-T", "-U", "root", "-p"]
