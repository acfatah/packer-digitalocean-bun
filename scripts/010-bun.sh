#!/bin/bash

apt-get -y update
apt-get -y install unzip

# Download the bun installation script and execute it
curl -fsSL https://bun.sh/install -o bun_setup.sh
sudo -E bash bun_setup.sh
rm bun_setup.sh
source ~/.bashrc

bun -v
sudo systemctl enable bun-app
sudo systemctl start bun-app
