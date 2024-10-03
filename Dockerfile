FROM node:22-bookworm-slim
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends python3 python3-pip python3-venv wget unzip git
RUN mkdir /solution

WORKDIR /solution
# Nodejs solution
RUN wget https://github.com/VonLatvala/caruna-influxdb/archive/1337dc5895e0886b6a91813f6e669a2ad8fe1926.zip -O solution.zip && unzip solution.zip && rm solution.zip && mv */*.* . && rm -rf ./*/ && npm i
# Python
RUN python3 -m venv .venv && . ./.venv/bin/activate && pip3 install -r requirements.txt
RUN apt-get remove -y --autoremove wget unzip python3-pip git && rm -rf /usr/local/lib/node_modules/npm

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT /docker-entrypoint.sh
