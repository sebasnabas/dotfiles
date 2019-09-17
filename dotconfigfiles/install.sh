#/bin/sh

configPath="$1"

if [ -z "${configPath// }" ] ; then
    configPath="~/"
fi

packageManager="pacman -Syu"

if [ $(hostnamectl) ] ; then
    operatingSystem=$(hostnamectl | grep 'Operating System:')

    if [ -n $(echo $operatingSystem | grep 'Ubuntu') ] ; then
        packageManager="apt install "
    fi
fi

if [ "$packageManager" == "pacman -Syu" ] ; then
    git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

    packageManager="yay -Syu"
fi

shopt -s dotglob

currentDirectory=/root/dotconfigfiles/*

echo "Using $packageManager"

echo "Moving everything from $currentDirectory to $configPath"

mv "$currentDirectory" "$configPath"

packages="man xorg neovim polybar i3-gaps kitty dunst zsh"

eval "$packageManager $packages"
