# scripts
some scripts  
* These steps are for ubuntu18.04
## some base apt install

build-essential cmake curl git neofetch proxychains fcitx fish openssh-server net-tools feh flameshot vlc figlet 
dependencies for  libx11-dev libxft-dev libxinerama-dev libharfbuzz-dev sharutils
* omf

* lazygit 
```
sudo add-apt-repository ppa:lazygit-team/release
sudo apt-get update
sudo apt-get install lazygit
```
* chrome

* sogoupinyin

* uTools

* ranger

* fzf
```
 git clone --depth 1 https://github.com/junegunn/fzf.git
```
* nvim 
requirements:
```{bash}
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install neovim

curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs
cd ~/.config/
git clone git@github.com:shaobo007/nvim.git
cd nvim
proxychain vim
```
* cuda

* miniconda 

* labelimg

* dwm st dmenu
* slock?
```
 
sudo add-apt-repository ppa:ubuntu-toolchain-r/test

sudo apt-get update

sudo apt-get install gcc-9 g++-9

gcc-9 --version

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 700 --slave /usr/bin/g++ g++ /usr/bin/g++-7

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 900 --slave /usr/bin/g++ g++ /usr/bin/g++-9

sudo update-alternatives --config gcc
```


