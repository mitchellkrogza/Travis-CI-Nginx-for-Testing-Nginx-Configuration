#!/bin/bash
YEAR=$(date +"%Y")
MONTH=$(date +"%m")
cd $TRAVIS_BUILD_DIR
#sudo whoami
#sudo chown root:root -R $TRAVIS_BUILD_DIR
git remote -v
#echo "First check of remote"
git remote rm origin
#echo "Try removing remote"
git remote -v
#echo "Second check of remote"
git remote add origin https://${GH_TOKEN}@github.com/${TRAVIS_REPO_SLUG}.git
git remote -v
#echo "Third Check of Remote After Adding it"
#ls -la $TRAVIS_BUILD_DIR
#ls -la $TRAVIS_BUILD_DIR/.git
git fetch origin master
#git pull origin master
#ls -la $TRAVIS_BUILD_DIR/.git
#echo "Check permissions on git HEAD / get dir listing of travis build dir"
git config --global user.email "${GIT_EMAIL}"
git config --global user.name "${GIT_NAME}"
git config --global push.default simple
#export GIT_TAG=V2.$YEAR-$MONTH.$TRAVIS_BUILD_NUMBER
#msg="Tag Generated from TravisCI for build $TRAVIS_BUILD_NUMBER"
#echo "$msg" >> $TRAVIS_BUILD_DIR/build.txt
#sudo $TRAVIS_BUILD_DIR/travis-ci/modify-globalblacklist.sh
#sudo git add $TRAVIS_BUILD_DIR/globalblacklist.conf
#git add -A .
#git add $TRAVIS_BUILD_DIR/build.txt
#git commit -m "Update build version file with $TRAVIS_BUILD_NUMBER"

#YEAR=$(date +"%Y")
#MONTH=$(date +"%m")
#sudo git remote -v
#sudo git remote rm origin
#sudo git config --global user.email "${GIT_EMAIL}"
#sudo git config --global user.name "${GIT_NAME}"
#sudo git config --global push.default simple
#export GIT_TAG=v1.0.$TRAVIS_BUILD_NUMBER
#msg="Tag Generated from TravisCI for build $TRAVIS_BUILD_NUMBER"
#echo "$msg" >> $TRAVIS_BUILD_DIR/build.txt
#git add $TRAVIS_BUILD_DIR/build.txt
#sudo $TRAVIS_BUILD_DIR/travis-ci/modify-globalblacklist.sh
#sudo git add $TRAVIS_BUILD_DIR/globalblacklist.conf
#sudo git commit -m "Build $GIT_TAG"
