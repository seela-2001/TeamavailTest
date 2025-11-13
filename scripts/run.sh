#!/bin/bash
set -e

PROJECT_DIR='/home/sohila/Documents/TeamavailTest/TeamavailTest'

cd $PROJECT_DIR

if docker compose version > /dev/null 2>&1;then
   docker compose up -d --build
else
   docker-compose up -d --build
fi

echo "The project is starting ....open: https://localhost:3000"