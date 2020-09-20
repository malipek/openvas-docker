#!/bin/bash
chown redis:redis /etc/redis/redis-openvas.conf
sudo -u redis redis-server /etc/redis/redis-openvas.conf
