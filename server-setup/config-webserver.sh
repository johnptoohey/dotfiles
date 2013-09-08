#!/bin/bash

set -e

if [ ! -d config ]; then
  echo "Can't find my config/ directory in the current directory!" 1>&2
  echo "Are you running me from the server-setup module's directory?" 1>&2
  exit 1
fi

sudo apt-get install -yy --no-install-recommends openjdk-7-jdk nginx monit

# install example webserver jar and service
sudo cp example-webserver.jar /usr/local/etc/
sudo ln -sf `pwd`/config/usr/local/etc/example-webserver /usr/local/etc/example-webserver

# link in monit files
sudo ln -sf `pwd`/config/etc/monit/conf.d/general /etc/monit/conf.d/general
sudo ln -sf `pwd`/config/etc/monit/conf.d/nginx /etc/monit/conf.d/nginx
sudo ln -sf `pwd`/config/etc/monit/conf.d/example-webserver /etc/monit/conf.d/example-webserver

# link in nginx config
sudo ln -sf `pwd`/config/etc/nginx/sites-available/example /etc/nginx/sites-available/example
sudo ln -sf /etc/nginx/sites-available/example /etc/nginx/sites-enabled/example

# tell monit to reload its config
sudo monit reload

# install webserver
./setup-local-postfix.sh
