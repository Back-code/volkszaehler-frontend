#!/bin/bash

#ENV db_host db_port db_user db_pass

cd /var/www/volkszaehler.org/etc
cp config.dist.yaml config.yaml
sed -i -e "s/host: 127.0.0.1/host: ${db_host}/" -e "s/# port: 3306/port: ${db_port}/" -e "s/user: vz/user: ${db_user}/" -e "s/password: demo/password: ${db_pass}/" config.yaml

cd  /var/www/volkszaehler.org/etc
sed -i s,htdocs,/var/www/volkszaehler.org/htdocs, middleware.json

cd  /var/www/volkszaehler.org/htdocs
sed -i s/api// js/options.js

cd /var/www/volkszaehler.org
/usr/bin/php /var/www/volkszaehler.org/vendor/bin/ppm start -c /var/www/volkszaehler.org/etc/middleware.json --cgi-path=/usr/bin/php
