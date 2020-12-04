#!/bin/bash

#ENV db_host db_port db_user db_pass db_admin_user db_admin_pass

cd /var/www/volkszaehler.org/etc
cp config.dist.yaml config.yaml
sed -i \
-e "s/host: localhost/host: ${db_host}/" \
-e "s/# port: 3306/port: ${db_port}/" \
-e "1,/admin:/s/user: vz/user: ${db_user}/" \
-e "1,/admin:/s/password: demo/password: ${db_pass}/" \
-e "/admin:/,\$s/user: vz_admin/user: ${db_admin_user}/" \
-e "/admin:/,\$s/password: admin_demo/password: ${db_admin_pass}/" \
config.yaml


cd  /var/www/volkszaehler.org/htdocs
sed -i s,api,., js/options.js

cd /var/www/volkszaehler.org
/usr/bin/php /var/www/volkszaehler.org/vendor/bin/ppm start -c /var/www/volkszaehler.org/etc/middleware.json --cgi-path=/usr/bin/php
