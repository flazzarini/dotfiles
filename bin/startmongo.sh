#!/bin/bash

datapath="/mnt/storage/data/mongo/"
mongod="/opt/mongodb/bin/mongod"

$mongod --dbpath $datapath
