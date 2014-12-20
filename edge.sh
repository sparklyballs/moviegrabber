#!/bin/bash
# Does the user want the latest version
if [ -z "$EDGE" ]; then
echo "Bleeding edge not requested"
else
rm -rf /opt/moviegrabber
git clone https://github.com/binhex/moviegrabber.git /opt/moviegrabber
chown -R nobody:users /opt/moviegrabber

