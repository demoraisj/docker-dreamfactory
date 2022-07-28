composer install

chown -R dreamfactory:dreamfactory /opt/dreamfactory*

service nginx start
service php7.4-fpm start

cp /source/FirebirdConnection.php vendor/dreamfactory/df-firebird/src/Database/FirebirdConnection.php

nginx -g 'daemon off;'
