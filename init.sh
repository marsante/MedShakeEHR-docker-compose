#! /bin/bash
vRelease=$(curl --silent "https://api.github.com/repos/MedShake/MedShakeEHR-base/releases/latest" |
        grep '"tag_name":' |                                                          
        sed -E 's/.*"([^"]+)".*/\1/')
wget --no-check-certificate https://github.com/MedShake/MedShakeEHR-base/archive/$vRelease.zip
unzip $vRelease.zip  
version=$(echo $vRelease | cut -f2 -d "v")  

mkdir medshakeehr-data
mv -f MedShakeEHR-base-$version/* ehr
echo "app/ehr
	" > medshakeehr-data/public_html/MEDSHAKEEHRPATH
sed -i "1iSetEnv MEDSHAKEEHRPATH /app/ehr" medshakeehr-data/public_html/.htaccess

rm -r $vRelease.zip MedShakeEHR-base-$version

sudo docker-compose build --pull && docker-compose up -d

