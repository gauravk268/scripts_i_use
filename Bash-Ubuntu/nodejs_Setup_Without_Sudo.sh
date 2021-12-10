#!/bin/bash

sudo cp -r node-v16.13.0-linux-x64/ /usr/local/lib/nodejs/
cd /usr/local/lib/nodejs/
sudo chown $USER node-v16.13.0-linux-x64/

gedit ~/.profile

# add this line to end of the file
# PATH="/usr/local/lib/nodejs/node-v16.13.0-linux-x64/bin:$PATH"
