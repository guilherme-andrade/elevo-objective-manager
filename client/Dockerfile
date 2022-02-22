FROM node:16.9.0-slim

RUN apt-get clean && apt-get update && apt-get -yq dist-upgrade \
    && apt-get install -qqy --no-install-recommends \
    build-essential \
    curl \
    git \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/* \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && truncate -s 0 /var/log/*log

WORKDIR /app
COPY . /app/
COPY package.json /app/

RUN yarn install

EXPOSE 3000

CMD ["yarn", "start"]
