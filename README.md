# rpmbuilder
script for rpm rebuild on CentOS
Prerequisites:

useradd mockbuild
useradd mock
yum install -y rpmdevtools
rpmdev-setuptree
yum install -y yum-utils
./rpmbuilder.sh testrepo http://vault.centos.org/centos/7/os/Source http://vault.centos.org/RPM-GPG-KEY-CentOS-7
