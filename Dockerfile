FROM alpine
MAINTAINER naou <monaou@gmail.com>

RUN apk --no-cache add postgresql
RUN mkdir /postgresql-data
ENV PGDATA=/postgresql-data

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh

CMD ["/entrypoint.sh"]

