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
sudo chmod +x $TRAVIS_BUILD_DIR/install-ngxblocker
sudo $TRAVIS_BUILD_DIR/install-ngxblocker -x
ls -la /etc/nginx/conf.d
ls -la /etc/nginx/bots.d
ls -la /etc/nginx/sites-available
#sudo cp $TRAVIS_BUILD_DIR/travis-ci/defaultsite.tpl /etc/nginx/site-available/