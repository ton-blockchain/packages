# The description of releasing TON binary packages 

## Release process
To simplify the release process of TON binary packages, the GH workflow ```.github/workflows/create-all-pkgs.yml``` has been added.

Once all mandatory artifacts, which are:

1. [ton-win-x86-64.zip](https://github.com/ton-blockchain/ton/releases/latest/download/ton-win-x86-64.zip)
2. [ton-linux-x86_64.zip](https://github.com/ton-blockchain/ton/releases/latest/download/ton-linux-x86_64.zip)
3. [ton-linux-arm64.zip](https://github.com/ton-blockchain/ton/releases/latest/download/ton-linux-arm64.zip)
4. [ton-mac-x86-64.zip](https://github.com/ton-blockchain/ton/releases/latest/download/ton-mac-x86-64.zip)
5. [ton-mac-arm64.zip](https://github.com/ton-blockchain/ton/releases/latest/download/ton-mac-arm64.zip)

are available one can trigger [Create all packages](https://github.com/ton-blockchain/packages/actions/workflows/create-all-pkgs.yml) GH action.

This action calls 4 below-described workflows in parallel.
Only ```create-rpm-packages.yml``` workflow will store binary RPM packages in the current repository, the other 3 workflows will push package files to the remote repositories.

**Notice**, that creation of Homebrew packages for macOS you have to trigger **manually**, by executing [this github action](https://github.com/ton-blockchain/homebrew-ton/actions/workflows/create-release.yml).

## AUR
### Repository
AUR (Arch User Repository) is an online store of packages for Arch-based Linux systems that users can access.

Account created at https://aur.archlinux.org/ and connected in Github via secret AUR_REPO_KEY which is actually a ssh-ed25519 private key.

TON foundation page: https://aur.archlinux.org/packages/ton-bin

Package name ```ton-bin```.
The suffix ```-bin``` is mandatory according to the rules of AUR repository for binary packages.

The version of the package inherited from the latest TON release with added ```-1``` suffix, e.g. ```2023.05-1```.
In case of the patch release, the package release is adjusted from ```2023.05-X```. to ```2023.05.X-1```.

### Github workflow

#### Location
[.github/workflows/create-aur-packages.yml](.github/workflows/create-aur-packages.yml)

Related packaging sources: [packages/arch](./packages/arch)

#### Description
GH action adds SSH key from the secret to the running system and pushes the artifact to the remote AUR repo.

AUR package consists of two files:
```./packages/arch/PKGBUILD``` and ```./packages/arch/.SRCINFO```,
the latter basically contains a link to artifact [ton-linux-x86-64.tar.gz](https://github.com/ton-blockchain/packages/releases/latest/download/ton-linux-x86-64.tar.gz) from the latest TON release.

### Installation
```
sudo pamac build -no-confirm ton-bin
```


## RPM
### Repository
It is a common practice to use a self-hosted YUM repository. 
In our case we use our Github account https://github.com/ton-blockchain/packages with rpm folder for RPM artifacts for both arm64 and amd64 architectures. 

Package name ```ton-dev-2023.05```.
The suffix ```-dev``` is mandatory. ```dev``` was selected in order to highlight that these binaries are for development only. 
If you need executables for validation purposes, we strongly recommend compiling and building them on the target validator host.

The version of the package inherited from the latest TON release, e.g. ```2023.05```
In case of the patch release, the package release is also adjusted from ```2023.05-X``` to ```2023.05.X```.

### Github workflow

#### Location
[.github/workflows/create-rpm-packages.yml](.github/workflows/create-rpm-packages.yml)

Related packaging sources: [packages/rpm](./packages/rpm) and ```./packages/rpm.sh```

#### Description

This workflow creates a release inside **ton-blockchain/packages** repository with the same name as the latest TON release.

It downloads two artifacts:

1. [ton-linux-arm64.zip](https://github.com/ton-blockchain/ton/releases/latest/download/ton-linux-arm64.zip)
2. [ton-linux-arm64.zip](https://github.com/ton-blockchain/ton/releases/latest/download/ton-linux-arm64.zip)

from the latest TON release, repacks them, builds RPM packages, and stores under **packages/rpm** folder.

This **rpm** folder also contains a mandatory **repodata** folder, that in combination with Github makes this folder available via web, and thus turns the repository into ordinary RPM repo, that can be recognized by YUM installer.

### Installation

```
sudo bash -c 'cat > /etc/yum.repos.d/ton.repo << EOF
[ton]
name=Ton
baseurl=https://ton-blockchain.github.io/packages/rpm
enabled=1
type=rpm
gpgcheck=0
EOF'

sudo yum install -y ton
```


## PPA deb
### Repository
PPA (Personal Package Archive) is a special repository hosted on Launchpad that is perfectly compatible with Ubuntu.
PPAs are mainly used in Ubuntu, but it is also possible to add them in Debian.

Account created at https://launchpad.net/ and connected in Github via GPG private key and its passphrase, GPG_PRIVATE_KEY, and GPG_PASSPHRASE secrets accordingly. 

TON deb binary artifacts are available at PPA https://launchpad.net/~ton-foundation/+archive/ubuntu/ppa.

```ton-foundation``` is the PPA name and the binary artifacts will be stored under the ```ton``` name, in this case we reserve the place for other artifacts within ```ton-foundation```, for example ```ton-wallet```.

Package name ```ton```.

The version of the package inherited from the latest TON release, e.g. ```2023.05```.
In case of the patch release, the package release is also adjusted from ```2023.05-X``` to ```2023.05.X```.

### Github workflow
#### Location
[.github/workflows/create-deb-ppa-packages.yml](.github/workflows/create-deb-ppa-packages.yml)

Related packaging sources: [packages/deb/debian](packages/deb/debian)
#### Description
After execution of the workflow, packages with architectures amd64 and arm64 for Jammy (Ubuntu 22.04) will be created at https://launchpad.net.
Soon after the package got published, one should manually copy/propagate the package to other releases using Launchpad "Copy package" function. 
### Installation
```
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F6A649124520E5F3
sudo add-apt-repository ppa:ton-foundation/ppa
sudo apt update
sudo apt install ton
```

## Chocolatey

### Repository
The Largest Repository of Windows Packages.

Account created at https://community.chocolatey.org and connected in Github via secret CHOCOLATEY_API_KEY.

TON Windows binary artifacts will be available at https://community.chocolatey.org/packages/ton/

Package name ```ton```

The version of the package inherited from the latest TON release, e.g. ```2023.05```
### Github workflow
#### Location
[.github/workflows/create-choco-packages.yml](.github/workflows/create-choco-packages.yml)

Related packaging sources: [packages/chocolatey](packages/chocolatey)
#### Description
To get the artifact's SHA256 checksum, Github workflow downloads it from the latest TON main release [ton-win-x86-64.zip](https://github.com/ton-blockchain/ton/releases/latest/download/ton-win-x86-64.zip),
then puts this checksum into package details and using CHOCOLATEY_API_KEY pushes to the remote Chocolatey repository. We do not store Windows artifact in **ton/package** repository.

Chocolatey package consists of two files:
```./packages/chocolatey/tools/chocolateyinstall.ps1``` and ```./packages/chocolatey/ton.nuspec```
### Installation
```
choco install ton
```

## Brew
The Package Manager for macOS.
### Repository
There is no need to create an account, we host our brew packages in our github repo https://github.com/ton-blockchain/homebrew-ton

The only requirement from Homebrew is that github repo must follow homebrew-**project** naming convention.

Package name ```ton```.

The version of the package inherited from the latest TON release, e.g. ```2023.05```

### Github workflow
#### Location
[ton-blockchain/homebrew-ton](https://github.com/ton-blockchain/homebrew-ton/blob/master/.github/workflows/create-release.yml)

Related packaging sources: [Ruby script](https://github.com/ton-blockchain/homebrew-ton/blob/master/ton.rb)
#### Description

The github action itself downloads two artifacts:

1. [ton-mac-arm64.zip](https://github.com/ton-blockchain/ton/releases/latest/download/ton-mac-arm64.zip)
2. [ton-mac-x86-64.zip](https://github.com/ton-blockchain/ton/releases/latest/download/ton-mac-x86-64.zip)

from the latest TON release, repacks, and attaches to the just created [release](https://github.com/ton-blockchain/homebrew-ton/releases) under **ton-blockchain/homebrew-ton** repository.

Ruby script ```ton.rb``` installs the binaries from **ton-blockchain/homebrew-repo** according to the target OS architecture.

### Installation
```
brew tap ton-blockchain/ton
brew install ton
```