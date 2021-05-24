#!/bin/bash

wget -O /tmp/os-deploy.zip https://github.com/protokeks/os-deploy/archive/refs/heads/main.zip
unzip /tmp/os-deploy.zip -d /tmp/os-deploy/
sudo bash /tmp/os-deploy/os-deploy-main/deploy.sh
