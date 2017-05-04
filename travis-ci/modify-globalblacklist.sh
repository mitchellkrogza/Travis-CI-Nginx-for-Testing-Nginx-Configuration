#!/bin/bash
# Write Build Number into globalblacklist.conf 
# Created by: https://github.com/mitchellkrogza (mitchellkrog@gmail.com)
# Copyright: Mitchell Krog - https://github.com/mitchellkrogza

# Start time of script generation
start=$(date +%s.%N)
MY_GIT_TAG=v2.2017.07.$TRAVIS_BUILD_NUMBER

# Temporary database files we create
_inputdbA=/tmp/lastupdated.db
_inputdbB=/tmp/gentime.db

# Declare Nginx template and temp variables
_nginx=/home/travis/build/mitchellkrogza/Travis-CI-Nginx-for-Testing-Nginx-Configuration/globalblacklist.conf
_tmpnginxA=tmpnginxA
_tmpnginxB=tmpnginxB

# Start and End Strings to Search for to do inserts into template
_startmarker="### Version Information"
_endmarker="### Version Information END"
#_startgen="### Generated in"
#_endgen="### End Generated in"

# PRINT VERSION INFORMATION
# **********************************
LASTUPDATEIFS=$IFS
IFS=$'\n'
now="$(date)"
end=$(date +%s.%N)    
echo $_startmarker >> $_tmpnginxA
runtime=$(python -c "print(${end} - ${start})")
printf "### Version: "$MY_GIT_TAG"\n### Updated: "$now"\n### Generated In: "$runtime" seconds\n" >> $_tmpnginxA
echo $_endmarker  >> $_tmpnginxA
IFS=$LASTUPDATEIFS
mv $_tmpnginxA $_inputdbA
ed -s $_inputdbA<<\IN
1,/### Version Information/d
/### Version Information END/,$d
,d
.r /home/travis/build/mitchellkrogza/Travis-CI-Nginx-for-Testing-Nginx-Configuration/globalblacklist.conf
/### Version Information/x
.t.
.,/### Version Information END/-d
#,p
#,p used to print output replaced with w below to write
w /home/travis/build/mitchellkrogza/Travis-CI-Nginx-for-Testing-Nginx-Configuration/globalblacklist.conf
q
IN
rm $_inputdbA

# End time of script generation
# *****************************
#GENTIME=$IFS
#IFS=$'\n'
#end=$(date +%s.%N)    
#runtime=$(python -c "print(${end} - ${start})")
#echo $_startgen >> $_tmpnginxB
#printf "### "$runtime" seconds\n" >> $_tmpnginxB
#echo $_endgen  >> $_tmpnginxB
#IFS=$GENTIME
#mv $_tmpnginxB $_inputdbB
#ed -s $_inputdbB<<\IN
#1,/### Generated in/d
#/### End Generated in/,$d
#,d
#.r /home/travis/build/mitchellkrogza/Travis-CI-Nginx-for-Testing-Nginx-Configuration/globalblacklist.conf
#/### Generated in/x
#.t.
#.,/### End Generated in/-d
#w /home/travis/build/mitchellkrogza/Travis-CI-Nginx-for-Testing-Nginx-Configuration/globalblacklist.conf
#q
#IN
#rm $_inputdbB

exit 0
