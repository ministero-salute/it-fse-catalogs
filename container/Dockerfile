FROM docker.io/mongo:latest
RUN mkdir /mongo-dump
COPY ../mongo-dump/*json /mongo-dump
COPY --chmod=0755 container/import_mongo_dumps.sh /docker-entrypoint-initdb.d
ENV MONGO_INITDB_ROOT_USERNAME=mongoadmin
ENV MONGO_INITDB_ROOT_PASSWORD=secret