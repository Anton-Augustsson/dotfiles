# Desktop environment
pacman -S --noconfirm dialog wpa_supplicant openssl xorg xorg-xinit xorg-server lightdm lightdm-gtk-greeter i3-gaps i3status dmenu feh alsa-utils
systemctl enable lightdm
## desktop language
localectl set-keymap se
localectl set-x11-keymap se

# Applications
pacman -S --noconfirm rxvt-unicode firefox ranger nautilus arduino kicad openscad

## yay
pacman -S --noconfirm --needed base-devel git
cd /home/anton/Programs
sudo -u anton git clone https://aur.archlinux.org/yay.git
chmod 777 yay
cd yay
sudo -u anton makepkg -si

sudo -u anton yay -S polybar siji termsyn-font

## configuration files
#scp anton@192.168.1.210:/plex/other/mountain1.jpg /home/anton/Pictures/wallpaper/wallpaper.jpg
#wget -q https://raw.githubusercontent.com/UsernameEqualToAnton/configuration-files/master/anton-config/.config/i3/config -O /home/anton/.config/i3/config
#wget -q https://raw.githubusercontent.com/UsernameEqualToAnton/configuration-files/master/anton-config/.emacs -O /home/anton/.config/emacs
#echo 'alias e="sudo emacs -nw"'>> ~/.bashrc
#wget -q https://raw.githubusercontent.com/UsernameEqualToAnton/configuration-files/master/anton-config/.Xdefaults -O /home/anton/.config/Xdefaults

