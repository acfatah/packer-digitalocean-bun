#!/bin/bash

(crontab -l 2>/dev/null; echo "1 2 * * * /etc/nginx/cloudflare-update-ips.sh") | crontab -
