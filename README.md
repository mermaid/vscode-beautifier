# vscode-beautifier
A bash script for mac that will set VSCodes icons back to the [one true icon](https://github.com/Leedehai/nostalgia-vscode)

it will automatically set the icon of `Visual Studio Code.app` if it is located in `/Applications` or `~/Applications`
otherwise provide the file path you want as an argument

You can run it with `bash $(curl https://github.com/mermaid/vscode-beautifier/raw/master/vscode-beautifier.sh)` if you don't mind piping bash from the web
Or with `bash vscode-beautifier.sh` or `bash vscode-beautifier.sh "~/Downloads/Visual Studio Code.app"` if you have a non-standard app location
