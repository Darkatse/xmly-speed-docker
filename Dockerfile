FROM python:3.7-alpine
MAINTAINER Darkatse <x.yngtze.river@gmail.com>

WORKDIR /

COPY sync.sh /sync.sh
RUN bash /sync.sh
CMD crontab -l && cron -f