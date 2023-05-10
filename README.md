### Install
```
sudo bash -c 'cat > /etc/yum.repos.d/ton.repo << EOF
[ton]
name=Ton
baseurl=https://ton-blockchain.github.io/rpm-repo/rpm
enabled=1
type=rpm
gpgcheck=0
EOF'

yum install ton
```
