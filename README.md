# TON installation packages for various operating systems

These packages are based on the latest binary artifacts https://github.com/ton-blockchain/ton/releases

### Install deb (apt)
#### Debian, Ubuntu, Linux Mint... (x86-64, aarch64)
```
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F6A649124520E5F3
sudo add-apt-repository ppa:ton-foundation/ppa
sudo apt update
sudo apt install ton
```

### Install via brew
#### macOS (x86-64, aarch64)
```
brew tap ton-blockchain/ton
brew install ton

# upgrade
brew update
brew reinstall ton
```

### Install via Chocolatey
#### Windows (x86-64)
Please, be aware that multiple false positive alarms from various antivirus vendors may occur.
This is an expected behaviour and there is no reason to worry.

Open an elevated terminal (Run as Administrator) and execute the below command:
```
choco install ton
```

### Install RPM (yum)
#### RedHat, Fedora, CentOS... (x86-64, aarch64)
```
sudo bash -c 'cat > /etc/yum.repos.d/ton.repo << EOF
[ton]
name=TON
baseurl=https://ton-blockchain.github.io/packages/rpm
enabled=1
type=rpm
gpgcheck=0
EOF'

sudo yum install -y ton
```

### Install AUR (pamac)
#### Manjaro, RebornOS, Arch Linux... (x86-64, aarch64)
```
sudo pamac build -no-confirm ton-bin
```