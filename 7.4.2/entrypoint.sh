#!/bin/sh

chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/
exec runuser -u elasticsearch "$@"
