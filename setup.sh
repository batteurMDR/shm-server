#! /bin/bash

echo "Welcome"
echo "==Update and Install core dependencies=="

apt-get update
apt-get install git curl libpng-dev make gcc -y

curl https://www.mongodb.org/static/pgp/server-4.0.asc | apt-key add -
echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/4.0 main" >> /etc/apt/sources.list.d/mongodb-org-4.0.list

apt-get update
apt-get install mongodb-org

systemctl enable mongod
systemctl start mongod

git clone --recursive https://github.com/kornelski/pngquant.git
cd pngquant/
make install

cd ~


echo "==Install NodeJS=="

curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh -o install_nvm.sh
bash install_nvm.sh
source ~/.profile

nvm install 8.12.0
nvm use 8.12.0


echo "==Install SHM SERVER=="

mkdir shm 
cd ./shm

git clone --depth 1  https://github.com/batteurMDR/shm-server-back.git -b dev shm-server-back
git clone --depth 1  https://github.com/batteurMDR/shm-server-front.git -b dev shm-server-front

cd ./shm-server-back
npm install
cd ../shm-server-front
npm install pngquant
npm install

echo "==We have few questions for you=="

cd ../shm-server-back
npm run setup

wait


echo "==Let's go=="

cd ../shm-server-front
npm run build

cd ../
mkdir ./shm-server-back/public/
cp -r ./shm-server-front/build/ ./shm-server-back/public/


cd ./shm-server-back/

echo "Start the server with : npm run start"
echo "Have a nice day!"