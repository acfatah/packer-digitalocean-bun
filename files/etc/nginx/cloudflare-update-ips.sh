#!/bin/bash

CONFIG_PATH="/etc/nginx/cloudflare-ip-filter.conf"

RULES=$(curl -ks "https://www.cloudflare.com/ips-v{4,6}" -w "\n" | sed "s/^/allow /g" | sed "s/\$/;/g" && printf "\ndeny all;")

LINES=$(wc -l <<< $RULES)

if [[ $LINES -gt 8 ]]; then
  echo "$RULES" > $CONFIG_PATH
  systemctl reload nginx
else
  # send a warn to admin, but dont change the config
  echo "$(date)| Unable to load cloudflare-ip-filter.conf" >>/var/log/cloudflare-update-ips.log
fi
