#!/bin/bash

# Assumption: Focal Fossa Ubuntu 20.04
# Check with: lsb_release -a

# Update packet index and upgrade upgradable packets
echo "Mise à jour du système..."
sudo apt update -y
sudo apt upgrade -y

# Install mongo and mongosh
# after https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-ubuntu/
echo "Installing MongoDB on focal fossa"

# Import the public key
echo "Adding Mongo GPG key..."
curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg \
   --dearmor

# Adding Mongo repo to the list of authorized sources
echo "Adding Mongo repo..."
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list

# Update sources
echo "Updating sources"
sudo apt update -y

# Installing MongoDB and MongoShell
echo "Installing MongoDB..."
sudo apt install -y mongodb-org

# Checking if MongoDB is installed
echo "Check MongoShell..."
mongosh --version

echo "Start mongod"
sudo service mongod start

# Active le service mongod pour qu'il démarre au démarrage du système
echo "Activate mongod at startup"
sudo systemctl enable mongod


# Check mongod status
echo "Checking if server is alive..."
sudo service mongod status


# Final message
echo "Mongo Shell successfully installed and MongoDB started"
