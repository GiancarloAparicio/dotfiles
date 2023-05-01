#!/data/data/com.termux/files/usr/bin/bash

proot cp -f ./bin.sh ~/../usr/bin/editorconfig
proot cp -r -f -u ../editorconfig ~/editorconfig

#-------------------------------------------------------------------
# Change first line
file=~/../usr/bin/editorconfig
newLine="#!/data/data/com.termux/files/usr/bin/bash"

sed -i "1s/.*/$newLine/" $file

#-------------------------------------------------------------------
# Set permission
proot chmod +x  ~/../usr/bin/editorconfig
