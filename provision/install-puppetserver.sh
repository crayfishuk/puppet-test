#!/bin/bash

# Install puppet-common before we provision properly
echo "Adding puppetlabs repo..."
cd /tmp
wget http://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
sudo dpkg -i puppetlabs-release-pc1-xenial.deb

echo "Updating Packages..."
sudo apt-get -q update

echo "Installing puppetserver..."
sudo apt-get -q -y install puppetserver
echo "PATH=/opt/puppetlabs/bin:$PATH" >> /etc/bash.bashrc
echo "export PATH" >> /etc/bash.bashrc
export PATH=/opt/puppetlabs/bin:$PATH

echo "Updating configuration for puppet..."
sudo cp /vagrant/provision/files/puppet.conf /etc/puppetlabs/puppet/puppet.conf

echo "Adjusting Java Memory requirements..."
echo "(reducing 2g to 512m)"
sudo sed -i.bak '/JAVA_ARGS/s/2g/512m/g' /etc/default/puppetserver
echo "(removing deprecated option)"
sudo sed -i.bak '/JAVA_ARGS/s/ -XX:MaxPermSize=256m//' /etc/default/puppetserver

echo "Update the /etc/hosts manually CHECK THIS!!!!"
sudo cat /vagrant/provision/files/hosts | sudo tee --append /etc/hosts > /dev/null

echo "Then start the puppetserver using:"
echo "    sudo systemctl start puppetserver"
echo "    sudo systemctl enable puppetserver"
