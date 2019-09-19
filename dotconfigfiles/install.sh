#/bin/sh

configPath="$1"

if [ -z "${configPath// }" ] ; then
    configPath="$HOME"
fi

packageManager="pacman -Syu"
packages="which man xorg-server neovim i3-gaps kitty dunst zsh compton go libclang nodejs npm mono cmake make clang texlive-core biber texlive-bibtexextra texlive-fontsextra texlive-latexextra texlive-pictures texlive-scienc ghci pandoc redshift firefox thunderbird okular ranger hamster dmenu"

if [ $(hostnamectl) ] ; then
    operatingSystem=$(hostnamectl | grep 'Operating System:')

    if [ -n $(echo $operatingSystem | grep 'Ubuntu') ] ; then
        packageManager="apt install "

        packages+=" $aurPackages"
    fi
fi

echo "Installing stuff..."
eval "$packageManager $packages"

aurPackages="polybar siji"

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
ln -s $configPath/.config/nvim/vimrc $HOME/.vimrc
ln -s $configPath/.config/git/gitconfig $HOME/.gitconfig
ln -s $configPath/.config/shell/bashrc $HOME/.bashrc
ln -s $configPath/.config/shell/profile $HOME/.profile
ln -s $configPath/.config/shell/zprofile $HOME/.zprofile
ln -s $configPath/.config/shell/zshrc $HOME/.zshrc
ln -s $configPath/.config/shell/aliases $HOME/.aliases
ln -s $configPath/.config/x/xinitrc $HOME/.xinitrc

echo "Installing vim-plug..."
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim -c 'PlugInstall'

pushd $HOME/.local/share/nvim/plugged/YouCompleteMe/
python3 install.py --clang-completer --system-libclang --go-completer --cs-completer --ts-completer
popd

echo "Making scripts executable..."
for directory in .scripts/* ; do for file in $directory ; do chmod +x $file ; done ; done


