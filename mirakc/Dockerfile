FROM mirakc/mirakc:alpine

LABEL maintainer="collelog <collelog@gmail.com>"

RUN apk add --no-cache tzdata && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && echo "Asia/Tokyo" > /etc/timezone
