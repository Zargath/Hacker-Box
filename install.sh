#!/bin/sh

sudo apt-get update
sudo apt-get install vim nmap aircrack-ng curl wireshark john hydra git libxml2-utils openjdk-8-jdk -qq

# Install metasploit
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && chmod 755 msfinstall && ./msfinstall

# Install VSCode
curl -L http://go.microsoft.com/fwlink/?LinkID=760868 -o vscode.deb 
sudo apt install ./vscode.deb

# Install OWASP Zap
curl https://raw.githubusercontent.com/zaproxy/zap-admin/master/ZapVersions.xml -o ZapVersions.xml
zapUrl=$(xmllint --xpath '/ZAP/core/linux/url/text()' ZapVersions.xml)
curl $zapUrl -o zap.tar.gz -L
sudo mkdir -p /opt/zap && sudo tar xf zap.tar.gz -C /opt/zap --strip-components 1

# Install Burp Suite
burpUrl=$(curl https://portswigger.net/burp/communitydownload | grep -oP 'href=\"\K.+type=linux.+(?=\")' -m 1)
burpUrl="https://portswigger.net${burpUrl}"
curl -o burp.sh ${burpUrl//&amp;/&} -L --header "accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3"
sh burp.sh -q
