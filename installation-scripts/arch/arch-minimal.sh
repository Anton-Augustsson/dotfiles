echo ' 
arch-linux-installation script 
'
EDITOR=emacs visudo
DRIVE=/dev/xvda

# Host configuration
echo 'arch-thinkpad' >> /etc/hostname
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
grub-mkconfig -o /boot/grub/grub.cfg
grub-install --target i386-pc $DRIVE

# Directory anton home
cd /home/anton
sudo -u anton mkdir Programs Documents Documents/git-projects Pictures Pictures/wallpaper Downloads
chmod 777 Programs Documents Documents/git-projects Pictures Pictures/wallpaper Downloads

## zsh
pacman -S --noconfirm zsh zsh-completions zsh-syntax-highlighting
chsh -s /bin/zsh
