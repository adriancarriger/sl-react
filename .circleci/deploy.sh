#!/bin/sh

set -e

# Run from parent directory
cd "$( dirname "$0" )" && cd ..

if [[ ! -d ~/.netlify ]]; then
  mkdir ~/.netlify
fi

echo "{\"access_token\":\"$NETLIFY_CLI_TOKEN\"}" > ~/.netlify/config

if [[ $CIRCLE_BRANCH == "develop" ]]; then
  REACT_APP_SERVER_URI="$SERVER_URI_BASE/staging" yarn run build
  yarn run deploy -e staging
fi

if [[ $CIRCLE_BRANCH == "master" ]]; then
  REACT_APP_SERVER_URI="$SERVER_URI_BASE/production" yarn run build
  yarn run deploy
fi
