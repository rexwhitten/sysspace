#!/bin/sh
# put other system startup commands here

#load dependencies
tce-load -wi openssh
tce-load -wi git 
tce-load -wi mono
tce-load -wi nodejs
tce-load -wi linux-headers-3.0.3-tinycore
tce-load -wi eglibc_base-devel
tce-load -wi eglibc_conv
tce-load -wi lua 
tce-load -wi tcc 

#build redis 
cd /home/tc/
git clone git://github.com/rexwhitten/redis.git

#security 
echo tc:!QAZxsw2| chpasswd

#git is installed now to pull down other stuff if needed
-- get application scripts 