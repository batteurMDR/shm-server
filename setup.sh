#! /bin/bash

echo "Welcome"
echo "==Update and Install core dependencies=="

apt update
apt install git curl nodejs -y

cd ~


echo "==Install NodeJS=="

curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh -o install_nvm.sh
bash install_nvm.sh
source ~/.profile

nvm install 8.12.0
nvm use 8.12.0


echo "==Install SHM SERVER=="

mkdir shm && cd shm

git clone --depth 1  https://github.com/batteurMDR/shm-server-back.git -b dev shm-server-back
git clone --depth 1  https://github.com/batteurMDR/shm-server-front.git -b dev shm-server-front

cd shm-server-back
npm install
npm run setup

cd ../shm-server-front
npm install
npm run build

cd ../
cp ./shm-server-front/build/ ./shm-server-back/public/


cd ./shm-server-back/

echo "Start the server with : npm run start"
echo "Have a nice day!"