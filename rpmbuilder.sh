rm -rf ~/rpmbuild/SRPMS/*
rm -rf ~/rpmbuild/SOURCES/*
rm -rf ~/rpmbuild/SPECS/*
cd ~/rpmbuild/SRPMS/
while read line; 
do
        yumdownloader --source $line;
done < ~/rpmbuild/rpmstobuild;

rpm -ivh ~/rpmbuild/SRPMS/*;

ls ~/rpmbuild/SPECS/* > /rpmbuild/specslist;

while read line; 
do
yum-builddep -y $line
rpmbuild -bb $line
done < ~/rpmbuild/specslist;
