This is a config centered around the UEFI installed Fedora 42 Sway Spin.

idk if you have preference for the audio stuff but i used to use playerctl and pamixer if thats still good, and brightnessctl though im on a desktop so idk if I need that 

had hyprshot and yeah idk give me some other suggestions

# Setup
``` bash
# DNF Parallel downloads
echo "max_parallel_downloads=10" | sudo tee -a "/etc/dnf/dnf.conf"
# setup community package repo, RPM Fusion for stuff like NVIDIA drivers
sudo dnf install \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
# reload repos
sudo dnf upgrade --refresh -y
# install NVIDIA drivers and kernel modules
sudo dnf install akmod-nvidia xorg-x11-drv-nvidia-cuda -y
# load new kernel modules
sudo reboot
```

### 1.3 Other system needs
``` bash
# ui stuff
sudo dnf install fuzzel cliphist -y
# system int
sudo dnf install udiskie playerctl pamixer -y
# screenshot utils
sudo dnf install grim slurp satty -y
# login
sudo dnf install greetd greetd-tuigreet -y
sudo systemctl disable sddm
sudo systemctl enable greetd
# shell
sudo dnf copr enable atim/starship -y
sudo dnf install vim neovim fish starship tldr qalc -y
chsh -s $(which fish)
```
logout to apply the fish shell change.

DELETE STUFF:
``` bash
sudo dnf remove rofi-wayland dunst swaylock swayidle sddm -y
```

PRETTYFY:
``` bash
sudo dnf install nwg-look papirus-icon-theme adwaita-qt5-style-devel adwaita-dark-theme bibata-cursor-themes -y
nwg-look 
```
"GTK Themes":Adwaita-dark
"Icons":Papirus-Dark
"Cursors":?

```bash
# Clone the LazyVim starter
git clone https://github.com/LazyVim/starter ~/.config/nvim
```
The next time you run `nvim`, LazyVim will install itself.

BACKUPS:
```bash
sudo dnf install snapper python3-dnf-plugin-snapper -y
# deletes a default config that might exist and creates a new one
sudo snapper -c root create-config /
# take a snapshot every hour tf look at this
sudo systemctl enable --now snapper-timeline.timer
```
Now, Snapper will also automatically take a snapshot before and after every `dnf` command you run. 
LOOOK AT PROPERLY

SPOTIFY
``` bash
flatpak install flathub com.spotify.Client
flatpak run com.spotify.Client
# then close spotify idk how to do with command
curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh
curl -fsSL https://raw.githubusercontent.com/spicetify/marketplace/main/resources/install.sh | sh
spicetify
spicetify config spotify_path /var/lib/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify/
spicetify config prefs_path ~/.var/app/com.spotify.Client/config/spotify/prefs

sudo chmod a+wr /var/lib/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify
sudo chmod a+wr -R /var/lib/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify/Apps
spicetify apply
```
then install adblockify and theme

FLATPAK:
``` bash
flatpak install flathub it.mijorus.gearlever
sudo dnf install fuse fuse-libs
```

SECUREBOOT:
If I want to run secure boot `https://rpmfusion.org/Howto/Secure%20Boot`

OSU:
download OTD manually https://opentabletdriver.net/Wiki/Install/Linux
winello https://github.com/NelloKudo/osu-winello
idk if lazer runs that amazing yet so no lazer.

DOTFILES
get some dot manager
not super sure if we want no bar, might just make a config then toggle it on or something

CONFIG:
``` bash
# take the default fedora one to start
# eventually we can just copy in the config files
mkdir -p ~/.config/sway
cp /etc/sway/config ~/.config/sway/config
```
sway: bind fuzzel pamixer, grim (refer to old i3 and hyprland config), launch exec udiskie cliphist, use variables in config
swaybg wallpaper
minimal waybar (config.jsonc, style.css)
firefox css
fuzzel config
dunst config
foot config (font color behaviour)
starship config
Run `starship preset pure-preset > ~/.config/starship.toml` to get a good starting prompt, then explore the Starship website for more options.
borgbackup `sudo dnf install borgbackup` and write a simple script to back up your `/home` directory to an external drive.

reload sway with whatever bind you end up deciding on.
