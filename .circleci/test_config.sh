#!/usr/bin/env bash

COMMIT_HASH=`git rev-parse HEAD`

curl --user ${CIRCLE_TOKEN}: \
    --request POST \
    --form revision=$COMMIT_HASH\
    --form config=@config.yml \
    --form notify=false \
        https://circleci.com/api/v1.1/project/github/drew-app/drew-app/tree/master
