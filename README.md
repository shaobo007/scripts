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

* Time sync
```
* sudo timedatectl set-local-rtc 1

* sudo hwclock --localtime --systohc
```

* grub change
```
  1. sudo mkdir /boot/grub/themes
  2. ./install.sh
```
* sudo vim /etc/systemd/system.conf
```
* DefaultTimeoutStopSec=3s
```
* sudo systemctl daemon-reload

### basic env varieties : $HOME/.profile
```
BUILD_HOME="$HOME/Repos/build"
SCRIPT_HOME="$HOME/scrips"

export TERMINAL=st
export EDITOR=nvim
export BROWSER="google-chrome-stable"

export PASSWORD_STORE_DIR="$HOME/.local/share/password-store"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/notmuch-config"
export MBSYNCRC="${XDG_CONFIG_HOME:-$HOME/.config}/mbsync/config"
export GIT_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/git/config"
export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/x11/xinitrc"

export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/bash_history"
```
### some base apt install
```
sudo apt install build-essential cmake p7zip-full \ curl git neofetch proxychains fcitx openssh-server net-tools \ feh figlet compton silversearcher-ag arandr groff xclip buleman maim xdotool acpi acpitool
```

* Dependencies for suckless utilities
```
sudo apt install libx11-dev libxft-dev libxinerama-dev libharfbuzz-dev sharutils libxrandr-dev libimlib2-dev

```
fonts-symbola --for more emojis
### manaul install
```
sudo apt install dunst sxiv zathura mpv \ pass neomutt msmtp isync rsync sxhkd lynx abook urlview notmuch
```
* fish + omf
```
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install fish
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
chsh -s /usr/bin/fish
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
```
sudo apt-get install fcitx
reboot
sudo  dpkg -i sogoupinyin_?????????_amd64.deb
sudo apt -f install
```
* uTools

* fzf
```
git clone --depth 1 https://github.com/junegunn/fzf.git
```
* nvim

Requirements:
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

sudo apt install golang-go  (for plug vim-hexokinase)
:CocCommand clangd.install
vimspector:
./install_badget.py --enable-python
```
* cuda
lsmod | grep nouveau
sudo vim /etc/modprobe.d/blacklist-nouveau.conf
```
blacklist nouveau
options nouveau modeset=0
sudo update-initramfs -u
```
lsmod | grep nouveau

* miniconda
```
conda create -n d2l-torch python=3.8.10
conda activate d2l-torch
pip install torch torchvision torchaudio
pip install d2l jupyter
pip install jupyter_contrib_nbextensions
jupyter contrib nbextension install --user
conda create -n opencv python=3.6.10
conda activate opencv
pip install  opencv-python==3.4.1.15
pip install opencv-contrib-python==3.4.1.15
```
* nerd font

* ranger
```
pip install ranger-fm ueberzug
```
* labelimg --label tool

### some suckless utilities

* dwm st dmenu tabbed
* surf
```
 sudo apt-get update
 sudo apt install libwebkit2gtk-4.0-dev libgcr-3-dev libglib2.0-dev
 sudo apt install gstreamer1.0-gtk3 gstreamer1.0-plugins-good gstreamer1.0-libav
 sudo apt install aria2
```
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
```
 sudo add-apt-repository ppa:cppiber/ppa
 sudo apt update
 sudo apt install mpd ncmpcpp

```

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

* paper -> Document
* note, md -> Document
* source -> Document

