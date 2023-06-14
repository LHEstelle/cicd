------Dockerfile
FROM debian:10 AS nodejs-my-website
LABEL org.opencontainers.image.source https://github.com/alexispe/cesi-next-cicd
RUN apt-get update -yq \
&& apt-get install curl gnupg -yq \
&& curl -sL https://deb.nodesource.com/setup_18.x | bash \
&& apt-get install nodejs -yq \
&& apt-get clean -y
ADD . /app/
WORKDIR /app
RUN npm install
RUN npm run build
EXPOSE 3000
COPY docker/next/docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint
ENTRYPOINT ["docker-entrypoint"]
CMD npm run start

------docker-entrypoint.sh
#!/bin/sh
npm install
exec "$@"