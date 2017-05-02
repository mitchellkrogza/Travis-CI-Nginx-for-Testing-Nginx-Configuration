#!/bin/bash
YEAR=$(date +"%Y")
MONTH=$(date +"%m")
sudo git remote -v
sudo git remote rm origin
sudo git config --global user.email "${GIT_EMAIL}"
sudo git config --global user.name "${GIT_NAME}"
sudo git config --global push.default simple
export GIT_TAG=v1.0.$TRAVIS_BUILD_NUMBER
#msg="Tag Generated from TravisCI for build $TRAVIS_BUILD_NUMBER"
#echo "$msg" >> $TRAVIS_BUILD_DIR/build.txt
#git add $TRAVIS_BUILD_DIR/build.txt
sudo $TRAVIS_BUILD_DIR/travis-ci/modify-globalblacklist.sh
sudo git add $TRAVIS_BUILD_DIR/globalblacklist.conf
sudo git commit -m "Build $GIT_TAG"
