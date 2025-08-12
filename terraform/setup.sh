#!/bin/bash

cd /home/ubuntu/app
sudo docker compose up -d

(crontab -l 2>/dev/null; echo '* * * * * curl http://localhost:5000/latency') | crontab -u ubuntu -
