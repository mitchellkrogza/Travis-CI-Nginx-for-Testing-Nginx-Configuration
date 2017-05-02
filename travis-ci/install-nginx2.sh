#!/bin/bash
# Travis CI Bash Script for Installing Nginx on Travis CI and Testing Configurations
# https://github.com/mitchellkrogza

#set -e
set -x
#set -v

#DIR=$(realpath $(dirname "$0"))
#USER=$(whoami)
#PHP_VERSION=$(phpenv version-name)
#ROOT=$(realpath "$DIR/..")
#PORT=9000
#SERVER="/tmp/php.sock"

#function tpl {
#    sed \
#        -e "s|{DIR}|$DIR|g" \
#        -e "s|{USER}|$USER|g" \
#        -e "s|{PHP_VERSION}|$PHP_VERSION|g" \
#        -e "s|{ROOT}|$ROOT|g" \
#        -e "s|{PORT}|$PORT|g" \
#        -e "s|{SERVER}|$SERVER|g" \
#        < $1 > $2
#}

# Make some working directories.
#mkdir "$DIR/nginx"
#mkdir "$DIR/nginx/sites-enabled"
#mkdir "$DIR/var"

# Configure the PHP handler.
#if [ "$PHP_VERSION" = 'hhvm' ] || [ "$PHP_VERSION" = 'hhvm-nightly' ]
#then
#    HHVM_CONF="$DIR/nginx/hhvm.ini"

#    tpl "$DIR/hhvm.tpl" "$HHVM_CONF"

#    cat "$HHVM_CONF"

#    hhvm \
#        --mode=daemon \
#        --config="$HHVM_CONF"
#else
#    PHP_FPM_BIN="$HOME/.phpenv/versions/$PHP_VERSION/sbin/php-fpm"
#    PHP_FPM_CONF="$DIR/nginx/php-fpm.conf"

    # Build the php-fpm.conf.
#    tpl "$DIR/php-fpm.tpl" "$PHP_FPM_CONF"

    # Start php-fpm
#    "$PHP_FPM_BIN" --fpm-config "$PHP_FPM_CONF"
#fi

# Build the default nginx config files.
#tpl "$DIR/nginx.tpl" "$DIR/nginx/nginx.conf"
#tpl "$DIR/fastcgi.tpl" "$DIR/nginx/fastcgi.conf"
#tpl "$DIR/defaultsite.tpl" "$DIR/nginx/sites-enabled/defaultsite.conf"

# Start nginx.
#nginx -c "$DIR/nginx/nginx.conf"
echo $TRAVIS_BUILD_DIR
sudo rm /etc/nginx/sites-available/default
sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/install-ngxblocker -O /usr/sbin/install-ngxblocker
sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/setup-ngxblocker -O /usr/sbin/setup-ngxblocker
sudo wget https://raw.githubusercontent.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker/master/update-ngxblocker -O /usr/sbin/update-ngxblocker
sudo chmod +x /usr/sbin/install-ngxblocker
sudo chmod +x /usr/sbin/setup-ngxblocker
sudo chmod +x /usr/sbin/update-ngxblocker
cd /usr/sbin
sudo ./install-ngxblocker -x
sudo cp $TRAVIS_BUILD_DIR/travis-ci/default.vhost /etc/nginx/sites-available/default.vhost
sudo ln -s /etc/nginx/sites-available/default.vhost /etc/nginx/sites-enabled/default.vhost
cd /usr/sbin
sudo ./setup-ngxblocker -x
sudo nginx -c /etc/nginx/nginx.conf
sudo service nginx reload
#sudo nginx -t &> /dev/stdout
#cat /etc/nginx/nginx.conf
#sudo nginx -V
#sudo netstat -peanut
sudo cp $TRAVIS_BUILD_DIR/www/index.php /var/www/html/index.php
cd /usr/sbin
sudo ./update-ngxblocker
sudo service nginx reload
sudo chmod +x $TRAVIS_BUILD_DIR/travis-ci/modify-globalblacklist.sh
#sudo export GIT_TAG=v1.0.$TRAVIS_BUILD_NUMBER
sudo $TRAVIS_BUILD_DIR/travis-ci/modify-globalblacklist.sh
#cat $TRAVIS_BUILD_DIR/globalblacklist.conf
#sudo sed --version
#sudo apt-cache policy dash