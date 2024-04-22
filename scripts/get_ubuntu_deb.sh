#!/bin/bash

# 脚本名：load_deb.sh
# 使用方法：./load_deb.sh 包名
# 如：./load_deb.sh gcc; ./load_deb.sh make 等等
set -e

sudo apt-get -qq --print-uris install $1 linux-headers-$(uname -r) | cut -d\' -f 2 > $1_deb_urls.txt
if [ ! -s $1_deb_urls.txt ]; then
    echo "Non found deb!"
    rm $1_deb_urls.txt
    exit
fi

wget -i $1_deb_urls.txt

echo '#!/bin/bash' > $1_install.sh
cat $1_deb_urls.txt | awk -F "/" '{print "dpkg -i " $NF}' >> $1_install.sh
chmod u+x $1_install.sh

echo "$1_deb_urls.txt" > zip_file
echo "$1_install.sh" >> zip_file
cat $1_deb_urls.txt | awk -F "/" '{print $NF}' >> zip_file
mkdir $1_deb
cat zip_file | xargs -i mv {} $1_deb 
zip -r $1_deb.zip $1_deb
#cat zip_file | xargs zip $1_deb.zip
rm -f zip_file
echo " "
echo "finish, package => $1_deb.zip"
