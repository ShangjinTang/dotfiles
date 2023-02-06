# README

Use 'code' command in SHH'ed terminal to open VS Code on local machine with SSH extension.

Just like use 'code' command inside WSL.

## Steps

### On local PC

1. Show all commands (Windows: Ctrl+Shift+P)
2. Open “Remote Explorer: Focus on Remote View”
3. Connect to remote server (non-WSL)

### On remote linux server (non-WSL)

1. Copy 'code' to $PATH
2. Use 'code FILE|FOLDER' to open file or folder as WSL. The file/folder will be opened at local PC.

## Reference

https://stackoverflow.com/questions/62201080/is-it-possible-to-use-the-code-command-in-sshed-terminal-to-open-vs-code-on-l
