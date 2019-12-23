echo ' 
arch-linux-installation script 
'
EDITOR=emacs visudo 
DRIVE=/dev/xvda
USER=anton
HOSTNAME=arch-thinkpad

# Host configuration
echo $HOSTNAME >> /etc/hostname
echo "
127.0.0.1    localhost
::1          localhost
127.0.1.1    $HOSTNAME.localdomain    $HOSTNAME
"  >> /etc/hosts

echo '
write your password root
'
passwd

useradd -m -G wheel -s /bin/bash $USER
echo '
write your password user
'
passwd $USER


# Region specific configuration
echo '
en_GB.UTF-8 UTF-8
en_GB ISO-8859-1
sv_SE.UTF-8 UTF-8
sv_SE ISO-8859-1
' >> /etc/locale.gen
locale-gen

echo '
LANG=en_GB.UTF-8
' >> /etc/locale.conf
echo '
KEYMAP=sv-latin1
' >>/etc/vconsole.conf


ln -sf /usr/share/zoneinfo/Europe/Stockholm /etc/localtime
hwclock --systohc

# Mirroring list
pacman -S --noconfirm pacman-contrib
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist

# Network
pacman -S --noconfirm jre-openjdk networkmanager
systemctl enable NetworkManager
## ssh
pacman -S --noconfirm openssh
systemctl enable sshd
systemctl start sshd

# Boot loader
pacman -S --noconfirm grub
grub-install $DRIVE
grub-mkconfig -o /boot/grub/grub.cfg

# Directory anton home
cd /home/anton
sudo -u anton mkdir Programs Documents Documents/git-projects Pictures Pictures/wallpaper Downloads
#chmod 777 Programs Documents Documents/git-projects Pictures Pictures/wallpaper Downloads

## zsh
pacman -S --noconfirm zsh zsh-completions zsh-syntax-highlighting
chsh -s /bin/zsh

# Desktop environment
pacman -S --noconfirm dialog wpa_supplicant openssl xorg xorg-xinit xorg-server lightdm lightdm-gtk-greeter i3-gaps i3status dmenu feh alsa-utils powerline w3m
systemctl enable lightdm
## desktop language
sudo -u anton localectl set-keymap se
sudo -u anton localectl set-x11-keymap se

# Applications
pacman -S --noconfirm rxvt-unicode firefox ranger nautilus arduino kicad openscad zathura openscad

## yay
pacman -S --noconfirm --needed base-devel git
cd /home/anton/Programs
sudo -u anton git clone https://aur.archlinux.org/yay.git
chmod 777 yay
cd yay
sudo -u anton makepkg -si

sudo -u anton yay -S siji termsyn-font polybar

# printer
pacman -S --noconfirm cups cups-pdf gtk3-print-backends system-config-printer
systemctl enable org.cups.cupsd.service
systemctl start org.cups.cupsd.service
sudo -u anton yay -S brother-mfc-l2700dw

## configuration files
#scp anton@192.168.1.210:/plex/other/mountain1.jpg /home/anton/Pictures/wallpaper/wallpaper.jpg
wget -q https://raw.githubusercontent.com/anton-1999/configuration-files/master/config/.zshrc -O ¨/.zshrc
wget -q https://raw.githubusercontent.com/anton-1999/configuration-files/master/config/.emacs -O ¨/.emacs
wget -q https://raw.githubusercontent.com/anton-1999/configuration-files/master/config/.Xdefaults -O ¨/.Xdefaults
wget -q https://github.com/anton-1999/configuration-files/blob/master/config/.config/i3/config -O ¨/.config/i3/config
wget -q https://raw.githubusercontent.com/anton-1999/configuration-files/master/config/.config/polybar/config -O ¨/.config/polybar/config
wget -q https://raw.githubusercontent.com/anton-1999/configuration-files/master/config/.config/polybar/launch.sh -O ¨/.config/polybar/launch.sh
wget -q https://raw.githubusercontent.com/anton-1999/configuration-files/master/config/.config/ranger/rc.conf -O ¨/.config/ranger/rc.conf
wget -q https://raw.githubusercontent.com/anton-1999/configuration-files/master/config/.config/zathura/zathurarc -O ¨/.config/zathura/zathurarc

echo '
# Finnish
exit
umount -R /mnt
reboot
'
