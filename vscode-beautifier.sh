#!/bin/bash    

# https://stackoverflow.com/questions/4632028/how-to-create-a-temporary-directory
# the directory of the script

# omit the -p parameter to create a temporal directory in the default location
TEMP_DIR=`mktemp -d -t vscode-beautifier`

# check if tmp dir was created
if [[ ! "$TEMP_DIR" || ! -d "$TEMP_DIR" ]]; then
  echo "Could not create temp dir"
  exit 1
fi

# deletes the temp directory
function cleanup {      
  rm -rf "$TEMP_DIR"
  echo "Cleaned up the temp directory"
}

# register the cleanup function to be called on the EXIT signal
trap cleanup EXIT

function copy_icons {    
  cp Code.icns "$1/Contents/Resources/Code.icns"
  cp code_file.icns "$1/Contents/Resources/code_file.icns"
  cp letterpress-dark.svg "$1/Contents/Resources/app/resources/letterpress-dark.svg"
  cp letterpress-hc.svg "$1/Contents/Resources/app/resources/letterpress-hc.svg"
  cp letterpress.svg "$1/Contents/Resources/app/resources/letterpress.svg"

  #this command will error, but still set the icon
  echo "read 'icns' (-16455) \"Code.icns\";" | Rez -o "`printf "$1/Icon\r"`" 2>/dev/null
  
  echo "Finished setting icons for $1"
  echo
}

VSCODEDIRS=("/Applications/Visual Studio Code.app" "~/Applications/Visual Studio Code.app")



if [ "$#" -ne  "0" ]; then
    VSCODEDIRS[2]="$1"
fi


cd $TEMP_DIR
echo "Cloning https://github.com/Leedehai/nostalgia-vscode into $(pwd)"
git clone https://github.com/Leedehai/nostalgia-vscode 2>/dev/null
cd nostalgia-vscode

echo

for d in "${VSCODEDIRS[@]}"; do
    if [ -d "$d" ]; then
        copy_icons "$d"
    fi
done

echo "Restarting the Dock"
killall Dock

echo "Dunzo!"
