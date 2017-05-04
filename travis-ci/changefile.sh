#!/bin/bash
YEAR=$(date +"%Y")
MONTH=$(date +"%m")
cd $TRAVIS_BUILD_DIR
#Remove Remotes Added by TravisCI
git remote rm origin
#Add Remote with Secure Key
git remote add origin https://${GH_TOKEN}@github.com/${TRAVIS_REPO_SLUG}.git
#List Remotes ONLY DURING testing - do not do this on live repo / possible key leak
#git remote -v
#ls -la $TRAVIS_BUILD_DIR
#ls -la $TRAVIS_BUILD_DIR/.git
#git fetch origin master
#git pull origin master
#ls -la $TRAVIS_BUILD_DIR/.git
#echo "Check permissions on git HEAD / get dir listing of travis build dir"
git config --global user.email "${GIT_EMAIL}"
git config --global user.name "${GIT_NAME}"
git config --global push.default simple
git checkout master
#export GIT_TAG=V2.$YEAR-$MONTH.$TRAVIS_BUILD_NUMBER
#msg="Tag Generated from TravisCI for build $TRAVIS_BUILD_NUMBER"
#echo "$msg" >> $TRAVIS_BUILD_DIR/build.txt
sudo $TRAVIS_BUILD_DIR/travis-ci/modify-globalblacklist.sh
sudo chown travis:travis $TRAVIS_BUILD_DIR/globalblacklist.conf
git add $TRAVIS_BUILD_DIR/globalblacklist.conf
git commit -am "V3.$YEAR.$MONTH.$TRAVIS_BUILD_NUMBER [ci skip]"
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
