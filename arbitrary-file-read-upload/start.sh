#!/bin/bash
sudo chmod -R 777 $(pwd)/docker-nginx-stable/htdocs/;
sudo docker build --tag=test-nginx docker-nginx-stable/. ;
sudo docker build --tag=test docker-php-fpm-5.2/. ;
sudo docker run --rm -d --name nullbyte -v $(pwd)/docker-nginx-stable/htdocs:/var/www/default/htdocs test;

sudo docker run -d --rm --name devilbox-nginx-stable \
  -v $(pwd)/docker-nginx-stable/htdocs:/var/www/default/htdocs \
  -e PHP_FPM_ENABLE=1 \
  -e PHP_FPM_SERVER_ADDR=nullbyte \
  -p 8080:80 \
  --link nullbyte \
  test-nginx
