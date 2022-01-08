# scripts
some scripts  
## These steps are for ubuntu18.04
### some base apt install

build-essential cmake curl git neofetch proxychains fcitx fish openssh-server net-tools feh ~~flameshot~~ ~~vlc~~ figlet compton
arandr
nm-applet buleman

Dependencies for  libx11-dev libxft-dev libxinerama-dev libharfbuzz-dev sharutils libxrandr-dev

libimlib2-dev

fonts-symbola --for more emojis
### manaul install

* omf

* zsh?

* lazygit 
```
sudo add-apt-repository ppa:lazygit-team/release
sudo apt-get update
sudo apt-get install lazygit
```
* chrome

* sogoupinyin

* uTools

* fzf + silversearcher-ag
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
sudo apt install yarn
[sudo] npm -g install instant-markdown-d@next  (for instant-markdown-preview)

```
* cuda

* miniconda 

* nerd font

* ranger

* labelimg --label tool

### some suckless stuff

* dwm st dmenu

* slock
```
 
sudo add-apt-repository ppa:ubuntu-toolchain-r/test

sudo apt-get update

sudo apt-get install gcc-9 g++-9

gcc-9 --version

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 700 --slave /usr/bin/g++ g++ /usr/bin/g++-7

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 900 --slave /usr/bin/g++ g++ /usr/bin/g++-9

sudo update-alternatives --config gcc
```

* dunst --notification service

* sxiv --image viewer

* mutt? --mail

* zathura  --pdf viewer (groff) needed 

* maim xdotool --for screenshot

* mpv  --media player

* mpd?  --music player

* sxhkd --global keybinding?

* cmus --music player?

* calcurse --calendar 

* rsync  --file sync tool

* entr ?

* ~~qq music player~~

* dict for linux ?

* bluetoothctl ?
```
rfkill unblock bluetooth
```
* brightness-control-tool  --brightness fix
```
 sudo add-apt-repository ppa:apandada1/brightness-controller
 sudo apt update
 sudo apt-get install brightness-controller-simple
```
* cache file clean? --using dmenu

## some config filedir
* fish config
* neofetch config
* mpv config
* sxhkd config
* sxiv config
* zathura config

## basic env varieties
 ```
  TERMINAL=st
  BROWSER="google-chrome-stable"
  EDITOR=nvim

  DOT_CONFIG_HOME="$HOME/.config"
  DOT_CACHE_HOME="$HOME/.cache"
  BUILD_HOME="$HOME/Builds"
  SCRIPT_HOME="$HOME/scrips"

 ```
* paper -> Document
* note, md -> Document
* source -> Document

