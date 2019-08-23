#!/bin/sh

USER=$(pipenv run python -c "import json;print(json.load(open('.credentials.json'))['username'])")
PASSWORD=$(pipenv run python -c "import json;print(json.load(open('.credentials.json'))['password'])")
URL="https://api.soc.mcafee.com"
export NO_PROXY=$([[ $NO_PROXY ]] && echo "$NO_PROXY,")thehive,cortex,elasticsearch
export no_proxy=$([[ $no_proxy ]] && echo "$no_proxy,")thehive,cortex,elasticsearch

pipenv run mvision-edr-activity-feed --url ${URL} --username ${USER} --password ${PASSWORD} "$@"