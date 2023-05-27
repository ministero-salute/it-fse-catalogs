#!/bin/bash

cd /mongo-dump
for f in *.json;do
    COLLECTION_NAME=${f%.json}
    mongoimport --db "fse" --jsonArray --collection ${COLLECTION_NAME} --drop --file ${COLLECTION_NAME}.json
done