# TON installation packages for various operating systems

These packages are based on the latest binary artifacts https://github.com/ton-blockchain/ton/releases

<details>
<summary>
Click here to reveal the list of installed binaries and their locations.
</summary>

#### For Linux systems:

**/usr/bin**

* validator-engine-console
* validator-engine
* tonlib-cli
* tlbc
* storage-daemon-cli
* storage-daemon
* storage-cli
* rldp-http-proxy
* lite-client
* http-proxy
* generate-random-id
* func
* fift
* dht-server
* create-state
* create-hardfork
* blockchain-explorer
* adnl-proxy


**/usr/lib**
* libtonlibjson.so
* libemulator.so

**/usr/lib/fift**
* TonUtil.fif
* Stack.fif
* Lists.fif
* Lisp.fif
* GetOpt.fif
* Fift.fif
* FiftExt.fif
* Disasm.fif
* Color.fif
* Asm.fif

**/usr/share/ton/smartcont/**

* wallet-v3.fif
* wallet-v3-code.fif
* wallet-v2.fif
* wallet.fif
* wallet-code.fc
* wallet3-code.fc
* validator-elect-signed.fif
* validator-elect-req.fif
* update-elector-smc.fif
* update-config-smc.fif
* update-config.fif
* testgiver.fif
* stdlib.fc
* simple-wallet-ext-code.fc
* simple-wallet-code.fc
* show-addr.fif
* restricted-wallet-code.fc
* restricted-wallet3-code.fc
* restricted-wallet2-code.fc
* recover-stake.fif
* pow-testgiver-code.fc
* payment-channel-code.fc
* new-wallet-v3.fif
* new-wallet-v2.fif
* new-wallet.fif
* new-testgiver.fif
* new-restricted-wallet.fif
* new-restricted-wallet3.fif
* new-restricted-wallet2.fif
* new-pow-testgiver.fif
* new-pinger.fif
* new-manual-dns.fif
* new-highload-wallet-v2.fif
* new-highload-wallet.fif
* new-auto-dns.fif
* multisig-code.fc
* mathlib.fc
* manual-dns-manage.fif
* LICENSE.LGPL
* highload-wallet-v2-one.fif
* highload-wallet-v2.fif
* highload-wallet-v2-code.fc
* highload-wallet.fif
* highload-wallet-code.fc
* gen-zerostate-test.fif
* gen-zerostate.fif
* envelope-complaint.fif
* elector-code.fc
* dns-manual-code.fc
* dns-auto-code.fc
* CreateState.fif
* create-elector-upgrade-proposal.fif
* create-config-upgrade-proposal.fif
* create-config-proposal.fif
* config-proposal-vote-signed.fif
* config-proposal-vote-req.fif
* config-code.fc
* complaint-vote-signed.fif
* complaint-vote-req.fif
* auto-dns.fif
* asm-to-cpp.fif

**/usr/share/ton/smartcont/auto**

* config-code.cpp
* config-code.fif
* dns-auto-code.cpp
* dns-auto-code.fif
* dns-manual-code.cpp
* dns-manual-code.fif
* elector-code.cpp
* elector-code.fif
* highload-wallet-code.cpp
* highload-wallet-code.fif
* highload-wallet-v2-code.cpp
* highload-wallet-v2-code.fif
* multisig-code.cpp
* multisig-code.fif
* payment-channel-code.cpp
* payment-channel-code.fif
* pow-testgiver-code.cpp
* pow-testgiver-code.fif
* restricted-wallet-code.cpp
* restricted-wallet-code.fif
* restricted-wallet2-code.cpp
* restricted-wallet2-code.fif
* restricted-wallet3-code.cpp
* restricted-wallet3-code.fif
* simple-wallet-code.cpp
* simple-wallet-code.fif
* simple-wallet-ext-code.cpp
* simple-wallet-ext-code.fif
* wallet-code.cpp
* wallet-code.fif
* wallet3-code.cpp
* wallet3-code.fif

#### For MacOS systems:

Depending on your macOS version, either here
* /usr/local/bin
* /usr/local/lib
* /usr/local/lib/fift
* /usr/local/share/ton/ton/smartcont
* /usr/local/share/ton/ton/smartcont/auto

or here:

* /opt/homebrew/bin
* /opt/homebrew/lib
* /opt/homebrew/lib/fift
* /opt/homebrew/share/ton/ton/smartcont
* /opt/homebrew/share/ton/ton/smartcont/auto

#### For Windows systems:
Default locations under C:\ drive:

* C:\ProgramData\chocolatey\lib\ton\bin
* C:\ProgramData\chocolatey\lib\ton\bin\lib
* C:\ProgramData\chocolatey\lib\ton\bin\smartcont
* C:\ProgramData\chocolatey\lib\ton\bin\smartcont\auto

</details>

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