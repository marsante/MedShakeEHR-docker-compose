#! /bin/bash
# gen cert
openssl genrsa -out config/cert/localhost.key 4096
openssl req -new -key config/cert/localhost.key -out config/cert/localhost.csr
openssl x509 -req -days 3650 -in config/cert/localhost.csr -signkey config/cert/localhost.key -out config/cert/localhost.pem

vRelease=$(curl --silent "https://api.github.com/repos/MedShake/MedShakeEHR-base/releases/latest" |
        grep '"tag_name":' |                                                          
        sed -E 's/.*"([^"]+)".*/\1/')
wget --no-check-certificate https://github.com/MedShake/MedShakeEHR-base/archive/$vRelease.zip -P 
unzip $vRelease.zip  
version=$(echo $vRelease | cut -f2 -d "v")  

mkdir ehr
mv -f MedShakeEHR-base-$version/* ehr
echo "app/ehr
	" > ehr/public_html/MEDSHAKEEHRPATH
sed -i "1iSetEnv MEDSHAKEEHRPATH /app/ehr" ehr/public_html/.htaccess

rm -r $vRelease.zip MedShakeEHR-base-$version

docker-compose up --build

