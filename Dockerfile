FROM debian

# see https://wiki.volkszaehler.org/software/middleware/installation#manuelle_installation

RUN apt-get update && apt-get install -y \
git-core php-cli php-mysql php-apcu mariadb-client php-xml php-mbstring ca-certificates wget zip curl \
&& rm -rf /var/lib/apt/lists/*

RUN git clone git://github.com/volkszaehler/volkszaehler.org.git ~/volkszaehler.org && \
mkdir /var/www && \
ln -sf ~/volkszaehler.org /var/www/volkszaehler.org && \
chown -R www-data /var/www/volkszaehler.org

RUN cd /tmp && \
curl -sS https://getcomposer.org/installer | php && \
mv composer.phar /usr/local/bin/composer && \
chmod +x /usr/local/bin/composer

RUN cd /var/www/volkszaehler.org/ && composer install

ENV db_host db_port db_user db_pass

COPY vz/startit.sh /startit.sh
RUN chmod a+x /startit.sh
CMD ["/startit.sh"]
