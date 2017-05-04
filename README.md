[![Build Status](https://travis-ci.org/mitchellkrogza/Travis-CI-Nginx-for-Testing-Nginx-Configuration.svg?branch=master)](https://travis-ci.org/mitchellkrogza/Travis-CI-Nginx-for-Testing-Nginx-Configuration)
# Template for Travis CI Testing of Nginx Configuration Files
## Written by Mitchell Krog - https://github.com/mitchellkrogza

This is a basic template for getting Travis CI's container based infrastructure to install a stable version of Nginx including Nginx-Extras and to test any scenario of Nginx.conf files and customization scripts you have written. 

I actually use this a test playground for my Nginx Bad Bot Blocker - https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker so it's always changing but it will give you the basics of how to properly install Nginx on Travis. 

You certainly will not need all the scripts and extra things I run as part of this repo but a lot of it will come in very useful to you if you study what I have done here. This repository will certainly teach you the right and wrong ways of not only installing Nginx but also testing Nginx extra configurations like my Bad Bot Blocker and also correctly doing changes and commits to files during the Travis build and pushing that build back to your repository with a Version Tag / Release Number and the the commit of the modified file. 

This comes from hundreds of hours of testing especially getting TravisCI to commit a file within a build, push it back to the live repo and not trigger another build in the process which throws TravisCI into an endless loop continually building and building until you actually fix the looping. 

It all came down to a special little [ci-skip] tag added into the commit message. 

My method's used here also make TravisCI do only one build and one build only, a lot of people seem to struggle with this logic as I see a lot of repo's having duplicate builds, one for master and then a subsequent build (without a push) which is a build using the Tag/Release. It's not needed and causes version numbering to always skip a number in the process and places unnecessary workloads onto the TravisCI build system. My way ensures your builds increment by 1 always, so if you last build number was 341, your next build tag will end with 342 and not 343.

## The purpose of this repository?

Travis CI is a great system for checking and testing your build's Commits, Pull Requests and Merges. Travis runs everything inside a Docker container so it's a fully contained system that you can run build tests on your GIT repository and you can't break anything outside of it.

This repository contains a simple layout for installing nginx into Travis, then loading your config files and running and number of bash commands to test your scripts.

If you pulled all your hair out already trying to get this all to work with Travis CI then you have landed in the right repository.

Travis CI does not come with Nginx pre-installed so the install needs to be scripted to tell Travis CI what to do. This script takes care of installing the latest stable build of nginx including nginx-extras from the repository ppa:nginx/stable.

If you don't even know what the heck Travis CI is read here - https://travis-ci.org/

## How the installation works

All of the installation files are located in the [/travis-ci](./travis-ci) directory. 

You can see inside the .travis.yml in what sequence the scripts are triggered and how things like execute permissions are set on shell scripts before running them. 

You can also see if you look inside the various shell scripts how certain things like modifying files, commiting them and pushing the changes back to the live repo including pushing release tags back to the live repo. 

Having a good sequence of how your run events inside .travis.yml is essential to understand, certain things just need to happen in certain section like before_install, install, before_deploy and then deploy. Good ordering of events with is essential TravisCI.

## How to Use This

Look through all configuration files of this repo starting with the structure of .travis.yml and then look at the shell scripts in the travis-ci folder that get run by .travis.yml. Once you get your head around it it will all make sense to you thereafter on how to play nicely with TravisCI and have TravisCI in turn play nicely with you and get it to do exactly what you want it to do. It will also teach you how to avoid throwing TravisCI into a loop where it continually keeps building and building due to not committing properly, very easy to do as I had it happen on one repository of mine which lead to TravisCI running builds all night long and I only noticed it the next morning :grinning: 

## Enjoy and hope this helps you. 

### If this helped you why not [buy me a beer](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=BKF9XT6WHATLG):beer: