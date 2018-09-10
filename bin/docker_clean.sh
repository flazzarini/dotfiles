#!/bin/bash
docker ps --filter "status=exited" | grep 'months ago' | xargs --no-run-if-empty docker rm
docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
docker volume rm $(docker volume ls -qf dangling=true)
