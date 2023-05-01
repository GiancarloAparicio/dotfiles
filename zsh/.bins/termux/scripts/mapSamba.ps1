# Run in powershell:
#    Set-ExecutionPolicy Unrestricted -Force
#    wget -Uri http://192.168.0.6:9090/mapSamba.ps1 -OutFile samba.ps1
#    .\samba.ps1
# Open file execute and navigate to \\127.0.0.1\brain

$remoteHost= Read-Host -Prompt "Enter remote host"
netsh interface portproxy add v4tov4 protocol=tcp connectaddress=$remoteHost connectport=4445 listenport=445
netsh interface portproxy add v4tov4 protocol=tcp connectaddress=$remoteHost connectport=1139 listenport=139

# donwload obsidian app
wget -Uri https://github.com/obsidianmd/obsidian-releases/releases/download/v1.1.9/Obsidian.1.1.9.exe -OutFile obsidian.exe

# install obsidian app
Start-Process -Wait -FilePath ".\obsidian.exe" -ArgumentList "/S" -PassThru

# Open url in browser
Start-Process -FilePath "obsidian://open?vault=%F0%9F%A7%A0%20Cerebro%20digital&file=README.md"
