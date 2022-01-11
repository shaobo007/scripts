# SCRIPTS
there are some scripts
## These steps are for ubuntu18.04
```
  ____  _____    _    ____  __  __ _____
 |  _ \| ____|  / \  |  _ \|  \/  | ____|
 | |_) |  _|   / _ \ | | | | |\/| |  _|
 |  _ <| |___ / ___ \| |_| | |  | | |___
 |_| \_\_____/_/   \_\____/|_|  |_|_____|

```
### some base apt install
```
sudo apt install build-essential cmake p7zip-full \
curl git neofetch proxychains fcitx \
openssh-server net-tools feh figlet compton silversearcher-ag
arandr groff xclip buleman maim xdotool acpi acpitool
```

* Dependencies for suckless utilities
```
sudo apt install libx11-dev libxft-dev libxinerama-dev libharfbuzz-dev sharutils libxrandr-dev libimlib2-dev

```
fonts-symbola --for more emojis
### manaul install
```
sudo apt install dunst sxiv zathura mpv mpd ncmpcpp \
pass neomutt msmtp isync rsync sxhkd lynx abook urlview notmuch
```
* fish + omf
```
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install fish
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
```
* ~~zsh?~~

* lazygit
```
sudo add-apt-repository ppa:lazygit-team/release
sudo apt-get update
sudo apt-get install lazygit
```
* chrome

* sogoupinyin

* uTools

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
sudo apt install python-pip python3-pip

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
```
pip install ranger-fm ueberzug
```
* labelimg --label tool

### some suckless utilities

* dwm st dmenu
1. add some useful layout to dwm
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

* neomutt? --mail

* pass --a password manager

* isync

* msmtp

* mutt-wizzard  lynx pam-gnupg abook urlview
```
sudo make install

```

* zathura  --pdf viewer (groff) needed

* maim xdotool --for screenshot

* mpv  --media player

* mpd ncmpcpp  --music player

* sxhkd --global keybinding?

* ~~cmus --music player?~~

* calcurse --calendar

* rsync  --file sync tool

* entr ?

* ~~qq music player~~

* dict for linux ?

* ~~bluetoothctl ?~~
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
* mpd config
* ncmpcpp config
* ~/.profile

## basic env varieties
```
TERMINAL=st
BROWSER="google-chrome-stable"
EDITOR=nvim

XDG_CONFIG_HOME="$HOME/.config"
XDG_CACHE_HOME="$HOME/.cache"
BUILD_HOME="$HOME/Repos/build"
SCRIPT_HOME="$HOME/scrips"

```
* paper -> Document
* note, md -> Document
* source -> Document

