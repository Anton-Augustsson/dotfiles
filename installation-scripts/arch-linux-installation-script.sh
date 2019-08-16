echo ' 
arch-linux-installation script 
'
EDITOR=emacs visudo

# Host configuration
echo 'al-thinkpad' >> /etc/hostname
echo '
127.0.0.1    localhost
::1          localhost
127.0.1.1    al-thinkpad.localdomain    al-thinkpad
'  >> /etc/hosts

echo '
write your password root
'
passwd

useradd -m -G wheel -s /bin/bash anton
echo '
write your password user
'
passwd anton


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

# Network
pacman -S --noconfirm networkmanager
systemctl enable NetworkManager
## ssh
pacman -S --noconfirm openssh
systemctl enable sshd
systemctl start sshd

# Boot loader
pacman -S --noconfirm grub
grub-install --target i386-pc /dev/xvda
grub-mkconfig -o /boot/grub/grub.cfg

# Directory anton home
cd /home/anton
sudo -u anton mkdir Programs Documents Documents/git-projects Pictures Pictures/wallpaper Downloads
chmod 777 Programs Documents Documents/git-projects Pictures Pictures/wallpaper Downloads

# Desktop environment
pacman -S --noconfirm dialog wpa_supplicant openssl xorg xorg-xinit xorg-server lightdm lightdm-gtk-greeter i3-gaps i3status rxvt-unicode dmenu feh firefox ranger nautilus alsa-utils
systemctl enable lightdm
## desktop language
localectl set-keymap se
localectl set-x11-keymap se
## download conf file
scp anton@192.168.1.210:/plex/other/mountain1.jpg /home/anton/Pictures/wallpaper/wallpaper.jpg
#wget -q https://raw.githubusercontent.com/UsernameEqualToAnton/configuration-files/master/anton-config/.config/i3/config -O /home/anton/.config/i3/config
wget -q https://raw.githubusercontent.com/UsernameEqualToAnton/configuration-files/master/anton-config/.emacs -O /home/anton/.emacs
echo 'alias e="sudo emacs -nw"'>> ~/.bashrc
wget -q https://raw.githubusercontent.com/UsernameEqualToAnton/configuration-files/master/anton-config/.Xdefaults -O /home/anton/.Xdefaults

# Applications
## yay
pacman -S --noconfirm --needed base-devel git
cd /home/anton/Programs
sudo -u anton git clone https://aur.archlinux.org/yay.git
chmod 777 yay
cd yay
sudo -u anton makepkg -si

pacman -S --noconfirm arduino kicad

echo '
# Finnish
exit
umount -R /mnt
reboot
'
