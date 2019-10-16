#/bin/sh

configPath="$1"

if [ -z "${configPath// }" ] ; then
    configPath="$HOME"
fi

packageManager="pacman -Syu"
packages="base-devel man xorg-server xorg-xinit xorg-xwininfo xorg-xbacklight xclip calcurse libnotify xwallpaper ffmpeg gnome-keyring xorg-xprop mpd mpc mopidy ncmpcpp networkmanager pulseaudio pulseaudio-alsa pulsemixer gotop neofetch unzip youtube-dl neovim i3-gaps kitty dunst zsh go libclang nodejs npm mono cmake make texlive-most biber ghci pandoc redshift firefox thunderbird zathura zathura-pdf-mupdf ranger hamster dmenu redshift rofi networkmanager-dmenu"

aurPackages="polybar siji compton-tryone-git"

if [ $(hostnamectl) ] ; then
    operatingSystem=$(hostnamectl | grep 'Operating System:')

    if [ -n $(echo $operatingSystem | grep 'Ubuntu') ] ; then
        packageManager="apt install "

        packages+=" $aurPackages"
    fi
fi

echo "Installing stuff..."
eval "$packageManager $packages"

if [ "$packageManager" == "pacman -Syu" ] ; then
    git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
    aurPackageManager="yay -Syu"
    eval $aurPackageManager $aurPackages
fi

shopt -s dotglob

currentDirectory=/root/dotconfigfiles/*

echo "Using $packageManager"

echo "Moving everything from $currentDirectory to $configPath"
mv "$currentDirectory" "$configPath"

echo "Creating symlinks..."
ln -s $configPath/.config/git/gitconfig $HOME/.gitconfig
ln -s $configPath/.config/shell/bashrc $HOME/.bashrc
ln -s $configPath/.config/shell/profile $HOME/.profile
ln -s $configPath/.config/shell/profile $HOME/.zprofile
ln -s $configPath/.config/shell/aliases $HOME/.aliases
ln -s $configPath/.config/x/xinitrc $HOME/.xinitrc

echo "Installing vim-plug..."
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim -c 'PlugInstall'

echo "Making scripts executable..."
chmod +x .scripts/*


