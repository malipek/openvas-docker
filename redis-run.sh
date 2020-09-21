#!/bin/bash
chmod 2777 /run/redis-openvas
chown redis:redis /etc/redis/redis-openvas.conf /run/redis-openvas
redis-server /etc/redis/redis-openvas.conf
