#!/bin/bash
##This script is for Samba server creation
#i will also share a directory using the samba server
a=`rpm -qa samba | cut -d'-' -f1`
if [ "$a" = "samba" ]
then
        echo "$a RPM is already installed"
else
        apt-get install samba* -y
        echo "$a package successfully installed"

fi

read -p "create a directory which you want to share using samba: " b
mkdir "$b"
touch "$b"/abc
chmod 777 $b
echo "This is my Samba Testing file" > "$b"/abc1
sed -i "5a hosts allow = 127.0.0.1" /etc/samba/smb.conf
cat >> /etc/samba/smb.conf << EOF
[PublicShare]
comment = This is my Samba Server created using script file
path = $b
public = yes
EOF
systemctl start smb
systemctl enable smb
pidof smb
if [ $? = 0 ]

then
        echo "Samba service is running"
else
        systemctl start smb
        systemctl enable smb
fi
echo "Congrats sudhir you have shared the directory using Samba"
