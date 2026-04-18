#!/usr/bin/env nu
# Arch linux, linux-zen kernel

let packages = "7zip 26.00-1.1
aerc 0.21.0-1.1
alsa-firmware 1.2.4-4
alsa-tools 1.2.15-3.1
alsa-utils 1.2.15.2-2.1
android-udev 20250525-1
arduino-language-server 0.7.7-1.2
aspell 0.60.8.2-2.1
aspell-en 2026.02.25-1.1
awww 0.12.0-1.1
base 3-3
base-devel 1-2
bat 0.26.1-2.1
bindfs 1.18.4-1
blueman 2.4.6-2.1
bluetuith-bin 0.2.6-3
bluez 5.86-4.1
bluez-utils 5.86-4.1
bore 0.6.0-2.1
brightnessctl 0.5.1-3
btop 1.4.6-2.1
buf 1.68.0-1.1
cachyos-keyring 20240331-1
cachyos-mirrorlist 27-1
cachyos-v3-mirrorlist 27-1
cachyos-v4-mirrorlist 27-1
cage 0.3.0-1.1
calcurse 4.8.2-1.1
carapace-bin 1.6.4-1
carbonyl-bin 0.0.3-2
ccache 4.13.2-1.1
ccase 0.5.1-1
chafa 1.18.1-1.1
chawan-git r4675.acd29d2-1
check 0.15.2-4.1
clang 22.1.3-2
clipnotify 1.0.2-3.1
cmake 4.3.1-1.1
cmatrix 2.0-4.1
codebook-lsp 0.3.37-1.1
cpio 2.15-3.1
cups 2:2.4.16-2
cups-filters 2.0.1-2.1
cups-pdf 3.0.2-1.6
cyrus-sasl 2.1.28-4.1
dante 1.4.4-2.1
dmidecode 3.7-1
dnsmasq 2.92-1.1
doxygen 1.16.1-3.1
dua-cli 2.34.0-2.1
earlyoom 1.9.0-1.1
edk2-ovmf 202508-1
efibootmgr 18-3.1
emmet-cli 1.2.1-1
emmet-language-server 2.8.0-1
ex-vi-compat 2-1
eza 0.23.4-3.1
falkon 25.12.3-2.1
fastfetch 2.61.0-1.1
fbida 2.14-6.1
fbpdf-git r107.6a0d77f-1
firefox 149.0.2-1
fish 4.6.0-1
fish-autopair 1.0.4-2
fisher 4.4.8-1
foot 1.26.1-1.1
fzf 0.71.0-1.1
gdb-dashboard 0.17.4-1
gemini-cli 1:0.36.0-1.1
ghostty 1.3.1-2.2
gimp 3.2.2-1
git 2.53.0-1.1
git-filter-repo 2.47.0-3
github-cli 2.89.0-1.1
gnome-disk-utility 46.1-2.2
gnome-maps 50.1-1.1
google-chrome 147.0.7727.55-1
gopls 0.21.1-2.1
greetd 0.10.3-2.1
greetd-tuigreet 0.9.1-2.1
grim 1.5.0-2.1
guestfs-tools 1.54.0-1.1
guvcview 2.2.2-1.1
htop 3.5.0-1.1
hypridle 0.1.7-8.1
hyprland 0.54.3-2.1
hyprlock 0.9.3-2.1
hyprpolkitagent 0.1.3-6.1
hyprshot 1.3.0-4
iamb-bin 0.0.11-3
imagemagick 7.1.2.19-1.1
inotify-tools 4.25.9.0-1.1
intel-compute-runtime 26.09.37435.1-1.1
intel-gpu-tools 2.3-2
intel-media-driver 25.4.6-1.2
intel-media-sdk 23.2.2-6
intel-ucode 20260227-1
isync 1.5.1-2.1
junction 1.12-1
kdeconnect 25.12.3-1.1
keychain 2.9.8-1
keyd 2.6.0-5.1
kitty 0.46.2-1.2
kolourpaint 25.12.3-1.1
ksmtuned-git 15.fef066f-1
ksshaskpass 6.6.4-1.1
laptop-mode-tools 1.74-1
lazygit 0.61.1-1.1
libcamera 0.7.0-3.1
libinput-tools 1.31.1-1.1
libreoffice-fresh-en-gb 26.2.2-1
libsixel 1.10.5-1.1
libva-intel-driver 2.4.1-6.2
libva-utils 2.22.0-1.1
libvirt 1:12.2.0-1.1
libvncserver 0.9.15-1.1
libxaw 1.0.16-2.1
libxcrypt-compat 4.5.2-1.1
libxpresent 1.0.2-1.1
libxvmc 1.0.15-1.1
linux-firmware 1:20260309-1
linux-lts 6.18.22-1
linux-zen 6.19.11.zen1-1
lowdown 3.0.1-1.1
man-db 2.13.1-1.1
man-pages 6.17-1
marksman 20260208-1
mdbook 0.5.2-1.1
meson 1.10.2-1
mingw-w64-gcc 15.2.0-1.1
mkdocs 1.6.1-3
mkdocs-material 9.7.6-1
mold 2.41.0-1.1
mplayer 38542-6
mpv 1:0.41.0-3.1
msmtp 1.8.32-1.1
musikcube-bin 3.0.5-1
nano 9.0-1.1
nautilus 50.1-1.1
nautilus-share 0.7.5-5.1
nchat-git 5.13.17.r22.g2b66c60-1
ncmpcpp 0.10.1-7.1
ncspot 1.3.3-2.1
neovim 0.12.1-1.1
network-manager-applet 1.36.0-2.1
networkmanager 1.56.0-1
networkmanager-openvpn 1.12.5-1.1
networkmanager-vpn-plugin-openvpn 1.12.5-1.1
notmuch 0.40-1.1
noto-fonts-cjk 20240730-1
nss-mdns 0.15.1-2.1
nushell 0.112.1-1.1
nwg-displays 0.3.28-1
oatmeal-bin 0.13.0-1
obs-studio 32.1.1-2.1
opencl-headers 2:2025.07.22-1
openvpn 2.7.1-1.1
pandoc-cli 3.6-17
patchelf 0.18.0-4.1
pavucontrol 1:6.2-1.1
pdfjs-legacy 5.6.205-1
pipewire-jack 1:1.6.3-1.1
pipewire-pulse 1:1.6.3-1.1
pkgfile 25-2.1
polkit-kde-agent 6.6.4-1.1
postgresql 18.3-2.1
powertop 2.15-2.1
pueue 4.0.4-1
pulsemixer 1.5.1-8
python-adblock 0.6.0-5.1
python-distlib 0.4.0-2
python-pip 26.0.1-1
python-pipx 1.11.1-1
python-pyclip 0.7.0-9
python-pymdown-extensions 10.21.2-1
python-pymupdf 1.27.2.2-1.1
python-send2trash 1.8.3-3
qemu-full 10.2.2-3
qemu-img 10.2.2-3
qt5-wayland 5.15.18+kde+r55-1.1
qt6-wayland 6.11.0-1.1
qutebrowser 3.7.0-1
qwen-code 0.14.0-2
rclone 1.73.4-1.1
remmina 1:1.4.43-2.1
resvg 0.47.0-2.1
ripgrep 15.1.0-2
rofi 2.0.0-1.1
rustup 1.29.0-2.1
samba 2:4.24.0-1.1
scrcpy 3.3.4-1.1
sddm 0.21.0-8
serpl 0.3.4-1.2
slack-term-bin 0.5.0-1
slurp 1.5.0-2.1
smartmontools 7.5-1.1
smem 1.5-8
speedtest-cli 2.1.3-10
spice-vdagent 0.23.0-1.1
spotify-launcher 0.6.5-1.1
starship 1.24.2-2
subversion 1.14.5-5
svelte-language-server 0.17.30-1
sway 1:1.11-1.1
swaylock 1.8.5-1.1
swaync 0.12.6-1.1
swtpm 0.10.1-2.1
system-config-printer 1.5.18-6
system-monitoring-center 3.3.0-1
taplo-cli 0.10.0-1.1
tcc 0.9.27.r1337.gb39cbc70-1
tectonic 0.16.8-1.1
tlp 1.9.1-1
tlp-pd 1.9.1-1
tlp-rdw 1.9.1-1
tmux 3.6_a-1.1
tombi 0.9.17-1.1
transmission-cli 4.1.1-1
transmission-gtk 4.1.1-1
ttf-firacode-nerd 3.4.0-2
ttf-iosevka-nerd 3.4.0-2
ttf-victor-mono-nerd 3.4.0-2
typescript-language-server 5.1.3-1
typescript-svelte-plugin 0.3.51-1
udiskie 2.6.2-1
uget 2.2.3-7.1
unzip 6.0-23.1
usb_modeswitch 2.6.2.20251207-1.1
uwsm 0.26.4-1
vim 9.2.0316-1.1
virt-install 5.1.0-3
virt-manager 5.1.0-3
virt-viewer 11.0-4.1
vscode-css-languageserver 1.113.0-1
vscode-html-languageserver 1.113.0-1
vscode-json-languageserver 1.113.0-1
vulkan-intel 2:26.0.4-2
wakatime 1:1.60.4-2
waybar 0.15.0-2.1
waydroid 1.6.2-1
waypaper 2.8-1
wf-recorder 0.6.0-1.1
wget 1.25.0-3.1
wine 11.6-1.1
wireless_tools 30.pre9-5.1
wl-clipboard 1:2.3.0-1.1
wl-mirror 0.18.5-1.1
wofi 1.5.3-1.1
words 2.1-8
xdg-desktop-portal-hyprland 1.3.11-4.1
xdg-utils 1.2.1-2
xf86-video-amdgpu 25.0.0-1.1
xf86-video-ati 1:22.0.0-3.1
xf86-video-fbdev 0.5.1-1.1
xf86-video-nouveau 1.0.18-1.1
xorg-server 21.1.22-1.1
xorg-xinit 1.4.4-1.1
xtrans 1.6.0-1
yaml-language-server 1.21.0-1
yamlfmt 0.21.0-1.1
yay 12.5.7-1
yay-debug 12.5.7-1
yazi 26.1.22-4
zathura 2026.03.27-1.1
zathura-pdf-mupdf 2026.02.03-6.1
zed 0.231.2-1.1
zls 0.15.1-1.1
zoxide 0.9.9-2.1
zpaqfranz-git 1:64.7.r0.g87b9655-1
zram-generator 1.2.1-1.1" | lines | parse "{name} {version}";

for package in $packages {
  sudo pacman -S $package.name
}

# setup swap

sudo fallocate 11G /swapfile
sudo chmod 600 /swapfile
sudo swapon /swapfile
echo '/swapfile none swap defaults 0 0' | sudo tee -a /etc/fstab

# swaps escape and caps lock, hold caps for ctrl
#

# git config --global http.postBuffer 524288000
# git config --global http.lowSpeedLimit 0
# git config --global http.lowSpeedTime 999999
#
# fisher install jorgebucaran/fisher && fisher install franciscolourenco/done # notify on long-running cmd
# sudo systemctl enable --now fstrim.timer
# KK

set -gx SSH_ASKPASS /usr/bin/ksshaskpass

# sudo systemctl enable --now fstrim.timer
#

sudo pacman -S keyd

echo "
[ids]
*

[main]
# capslock behaves as 'control' when held, and 'escape' when tapped
capslock = overload(control, esc)

esc = capslock" | sudo tee /etc/keyd/default.conf

sudo systemctl enable --now keyd

sudo keyd reload # to reload

# command finish notificaitons
fisher install jorgebucaran/fisher && fisher install franciscolourenco/done # notify on long-running cmd

# longer battery life
sudo systemctl enable --now fstrim.timer

# `dua` from cargo for disk storage analyser
#
sudo usermod -aG engon,wheel,audio,input,lp,render,tty,video,libvirt,ollama,docker $USER

# use iwd instead of wpa_supplicant
