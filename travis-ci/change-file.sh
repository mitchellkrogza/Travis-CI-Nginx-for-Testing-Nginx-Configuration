#!/bin/bash
YEAR=$(date +"%Y")
MONTH=$(date +"%m")
cd $TRAVIS_BUILD_DIR

#Remove Remotes Added by TravisCI
#git remote rm origin

#Add Remote with Secure Key
#git remote add origin https://${GH_TOKEN}@github.com/${TRAVIS_REPO_SLUG}.git

local remote=origin
if [[ $GH_TOKEN ]]; then
	remote=https://$GH_TOKEN@github.com/$TRAVIS_REPO_SLUG
fi

#List Remotes ONLY DURING testing - do not do this on live repo / possible key leak
#git remote -v

# Set Git Variables
git config --global user.email "${GIT_EMAIL}"
git config --global user.name "${GIT_NAME}"
git config --global push.default simple

# Make sure we have master branch checked out in Git
git checkout master

# Modify our file and make sure Travis is owner
sudo $TRAVIS_BUILD_DIR/travis-ci/modify-globalblacklist.sh
sudo chown travis:travis $TRAVIS_BUILD_DIR/globalblacklist.conf

# Add the modified file to the and commit it
git add $TRAVIS_BUILD_DIR/globalblacklist.conf
git commit -am "V3.$YEAR.$MONTH.$TRAVIS_BUILD_NUMBER [ci skip]"

# Travis now moves to the before_deploy: section of .travis.yml