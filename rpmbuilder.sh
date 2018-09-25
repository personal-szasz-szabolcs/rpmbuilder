yum groupinfo Base|grep -v 'Load\|Setting\|*\|Group\|Description\|Packages\|^$'|wc > ~/rpmbuilder/rpmstobuild
rm -rf ~/rpmbuild/SRPMS/*
rm -rf ~/rpmbuild/SOURCES/*
rm -rf ~/rpmbuild/SPECS/*
cd ~/rpmbuild/SRPMS/
while read line; 
do
        yumdownloader --source $line;
done < ~/rpmbuilder/rpmstobuild;

rpm -ivh ~/rpmbuild/SRPMS/*;

ls ~/rpmbuild/SPECS/* > /rpmbuilder/specslist;

while read line; 
do
yum-builddep -y $line
rpmbuild -bb $line
done < ~/rpmbuilder/specslist;
