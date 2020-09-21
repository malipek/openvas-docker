FROM redis
ADD ./redis-openvas.conf /etc/redis/
ADD ./redis-run.sh /usr/local/bin/
CMD ["/usr/local/bin/redis-run.sh"]
