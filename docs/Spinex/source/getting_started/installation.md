## Installing packaged versions of p4c

p4c has package support for several Ubuntu and Debian distributions.

### Ubuntu

A p4c package is available in the following repositories for Ubuntu 20.04 and newer.

```bash
source /etc/lsb-release
echo "deb http://download.opensuse.org/repositories/home:/p4lang/xUbuntu_${DISTRIB_RELEASE}/ /" | sudo tee /etc/apt/sources.list.d/home:p4lang.list
curl -fsSL https://download.opensuse.org/repositories/home:p4lang/xUbuntu_${DISTRIB_RELEASE}/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_p4lang.gpg > /dev/null
sudo apt-get update
sudo apt install p4lang-p4c
```

### Debian

For Debian 11 (Bullseye) it can be installed as follows:

```bash
echo 'deb https://download.opensuse.org/repositories/home:/p4lang/Debian_11/ /' | sudo tee /etc/apt/sources.list.d/home:p4lang.list
curl -fsSL https://download.opensuse.org/repositories/home:p4lang/Debian_11/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_p4lang.gpg > /dev/null
sudo apt update
sudo apt install p4lang-p4c
```

If you cannot use a repository to install p4c, you can download the `.deb` file
for your release and install it manually. You need to download a new file each
time you want to upgrade p4c.

1. Go to https://build.opensuse.org/package/show/home:p4lang/p4lang-p4c, click on
"Download package" and choose your operating system version.

2. Install p4c, changing the path below to the path where you downloaded the package.

```bash
sudo dpkg -i /path/to/package.deb
```
