#!/bin/bash
BASEDIR=$(dirname "$0")
cd "$BASEDIR/.."
bundle install
npm install
cd drew-web-client
npm install
cd ../drew-server
bundle install
cd ..

