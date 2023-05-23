#!/bin/bash


DBURI="mongodb://${MONGO_INITDB_ROOT_USERNAME}:${MONGO_INITDB_ROOT_PASSWORD}@localhost:27017/catalogs?authSource=admin"
#mongoimport --uri mongodb://root:password@localhost:27017/catalogs?authSource=admin --jsonArray --collection schema schema.json
cd /mongo-dump
for f in *.json;do
    COLLECTION_NAME=${f%.json}
    mongoimport --uri ${DBURI} --jsonArray --collection ${COLLECTION_NAME} --drop --file ${COLLECTION_NAME}.json
done