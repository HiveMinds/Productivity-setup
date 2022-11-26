#!/bin/bash

# Configure firefox by adding extensions.
sudo mkdir -p /etc/firefox/policies
sudo cp policies.json /etc/firefox/policies/policies.json
#sudo rm /etc/firefox/policies/policies.json

# Configure Ublock Origin to remove unwanted information from websites.
