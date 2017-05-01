#!/bin/bash
# Write Build Number into globalblacklist.conf 
# Created by: https://github.com/mitchellkrogza (mitchellkrog@gmail.com)
# Copyright: Mitchell Krog - https://github.com/mitchellkrogza

# Start time of script generation
start=$(date +%s.%N)

# Temporary database files we create
_inputdbA=$TRAVIS_BUILD_DIR/lastupdated.db
_inputdbB=$TRAVIS_BUILD_DIR/gentime.db

# Declare Nginx template and temp variables
_nginx=$TRAVIS_BUILD_DIR/globalblacklist.conf
_tmpnginxA=$TRAVIS_BUILD_DIRtmpnginxA
_tmpnginxB=$TRAVIS_BUILD_DIRtmpnginxB

# Start and End Strings to Search for to do inserts into template
_startdate="### Last Updated"
_enddate="### End Last Updated"
_startgen="### Generated in"
_endgen="### End Generated in"

# PRINT DATE AND TIME OF LAST UPDATE
# **********************************
LASTUPDATEIFS=$IFS
IFS=$'\n'
now="$(date)"
echo $_startdate >> $_tmpnginxA
printf "### Updated: "$now"\n ### Build: "$GIT_TAG"\n" >> $_tmpnginxA
echo $_enddate  >> $_tmpnginxA
IFS=$LASTUPDATEIFS
mv $_tmpnginxA $_inputdbA
ed -s $_inputdbA<<\IN
1,/### Last Updated/d
/### End Last Updated/,$d
,d
.r $TRAVIS_BUILD_DIR/globalblacklist.conf
/### Last Updated/x
.t.
.,/### End Last Updated/-d
#,p
#,p used to print output replaced with w below to write
w $TRAVIS_BUILD_DIR/globalblacklist.conf
q
IN
rm $_inputdbA

# End time of script generation
# *****************************
GENTIME=$IFS
IFS=$'\n'
end=$(date +%s.%N)    
runtime=$(python -c "print(${end} - ${start})")
echo $_startgen >> $_tmpnginxB
printf "### "$runtime" seconds\n" >> $_tmpnginxB
echo $_endgen  >> $_tmpnginxB
IFS=$GENTIME
mv $_tmpnginxB $_inputdbB
ed -s $_inputdbB<<\IN
1,/### Generated in/d
/### End Generated in/,$d
,d
.r $TRAVIS_BUILD_DIR/globalblacklist.conf
/### Generated in/x
.t.
.,/### End Generated in/-d
w $TRAVIS_BUILD_DIR/globalblacklist.conf
q
IN
rm $_inputdbB

exit 0
