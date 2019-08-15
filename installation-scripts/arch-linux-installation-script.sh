echo ’ arch-linux-installation script ‘

# Host configuration
echo '
127.0.0.1    localhost
::1        localhost
127.0.1.1    al-thinkpad.localdomain    al-thinkpad
'  >> /etc/hostname

echo 'al-thinkpad' >> /etc/hostname

echo ‘
write your password root
‘
passwd

useradd -m -G wheel -s /bin/bash anton
echo ‘
write your password user
‘
passwd anton


# Region specific configuration
echo ‘
en_GB.UTF-8 UTF-8
en_GB ISO-8859-1
sv_SE.UTF-8 UTF-8
sv_SE ISO-8859-1
‘ >> /etc/locale.gen
locale-gen

echo ‘
LANG=en_GB.UTF-8
‘ >> /etc/locale.conf
echo ‘
KEYMAP=sv-latin1
‘ >>/etc/vconsole.conf


ln -sf /usr/share/zoneinfo/Europe/Stockholm /etc/localtime
hwclock --systohc

# Network
pacman -S networkmanager
systemctl enable NetworkManager
## ssh
pacman -S openssh
systemctl enable sshd
systemctl start sshd

# Boot loader
pacman -S grub
grub-install --target i386-pc /dev/xvda
grub-mkconfig -o /boot/grub/grub.cfg

# Directory anton home
cd /home/anton
mkdir Programs Documents Documents/git-projects Pictures Pictures/wallpaper Downloads

# Desktop environment
pacman -S dialog wpa_supplicant openssl xorg xorg-xinit xorg-server lightdm lightdm-gtk-greeter i3-gaps i3status rxvt-unicode dmenu feh firefox ranger nautilus 
systemctl enable lightdm
##
localectl set-keymap se
localectl set-x11-keymap se
##
scp anton@192.168.1.210:/plex/other/mountain1.jpg /home/anton/pictures/wallpaper/wallpaper.jpg
wget -q https://raw.githubusercontent.com/UsernameEqualToAnton/configuration-files/master/anton-config/.config/i3/config -O /home/anton/.config/i3/config
wget -q https://raw.githubusercontent.com/UsernameEqualToAnton/configuration-files/master/anton-config/.emacs -O /home/anton/.emacs
echo 'alias e="sudo emacs -nw"'>> ~/.bashrc
wget -q https://raw.githubusercontent.com/UsernameEqualToAnton/configuration-files/master/anton-config/.Xdefaults -O /home/anton/.Xdefaults

# Applications
## yay
pacman -S --needed base-devel git
mkdir programs
cd programs
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

cd /home/anton
pacman -S texlive-most arduino kicad