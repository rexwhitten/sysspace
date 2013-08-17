#!/bin/sh
# put other system startup commands here

#load dependencies
tce-load -wi openssh
tce-load -wi git 
tce-load -wi mono
tce-load -wi nodejs

#security 
echo tc:!QAZxsw2| chpasswd

#git is installed now to pull down other stuff if needed
