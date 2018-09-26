#!/bin/bash
REPONAME=$1
REPOURL=$2
REPOURLKEY=$3

cp ~/rpmbuilder/.rpmmacros /root/
rm -rf /root/rpmbuild/SRPMS/*
rm -rf /root/rpmbuild/SOURCES/*
rm -rf /root/rpmbuild/SPECS/*
rm -rf /root/rpmbuild/RPMS/*
cd /root/rpmbuild/SRPMS/

rm /etc/yum.repos.d/$REPONAME.repo
echo "[$REPONAME]" >> /etc/yum.repos.d/$REPONAME.repo
echo "name=$REPONAME" >> /etc/yum.repos.d/$REPONAME.repo
echo "baseurl=$REPOURL" >> /etc/yum.repos.d/$REPONAME.repo
echo "enabled=0" >> /etc/yum.repos.d/$REPONAME.repo
echo "gpgcheck=1" >> /etc/yum.repos.d/$REPONAME.repo
echo "gpgkey=$REPOURLKEY" >> /etc/yum.repos.d/$REPONAME.repo

yum groupinfo Base|grep -v 'Load\|Setting\|*\|Group\|Description\|Packages\|^$'|tr -d + > ~/rpmbuilder/rpmstobuild

        while read line; 
                do
                yumdownloader --disablerepo=* --enablerepo=$REPONAME --source $line;
                done < ~/rpmbuilder/rpmstobuild;

rpm -ivh ~/rpmbuild/SRPMS/*;
ls ~/rpmbuild/SPECS/* > ~/rpmbuilder/specslist;
while read line; 
do
yum-builddep -y $line
rpmbuild -bb $line
done < ~/rpmbuilder/specslist;
