This is a config centered around the Fedora 42 Sway Spin.

idk if you have preference for the audio stuff but i used to use playerctl and pamixer if thats still good, and brightnessctl though im on a desktop so idk if I need that 

had hyprshot and yeah idk give me some other suggestions

# Setup
DNF Parallel downloads, setup community package repo, RPM Fusion for stuff like NVIDIA drivers
``` bash
echo "max_parallel_downloads=10" | sudo tee -a "/etc/dnf/dnf.conf"

sudo dnf install \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

sudo dnf upgrade --refresh -y
```

install NVIDIA drivers and kernel modules (
``` bash
sudo dnf install akmod-nvidia xorg-x11-drv-nvidia-cuda -y
```

reboot to make sure new kernel modules are loaded
``` bash
sudo reboot
```

### 1.3 Other system needs
ui stuff
``` bash
sudo dnf install fuzzel cliphist -y
```

system int 
``` bash
sudo dnf install udiskie playerctl pamixer -y
```

screenshot utils
``` bash
sudo dnf install grim slurp satty -y
```

``` bash
sudo dnf install greetd greetd-tuigreet -y
sudo systemctl disable sddm
sudo systemctl enable greetd
```

DELETE STUFF:
``` bash
sudo dnf remove rofi-wayland dunst swaylock swayidle sddm -y
```

PRETTYFY:
``` bash
sudo dnf install nwg-look papirus-icon-theme adwaita-qt5-style-devel -y
nwg-look
```
"GTK Themes":Adwaita-dark
"Icons":Papirus-Dark
"Cursors":?

SHELL:
``` bash
sudo dnf copr enable atim/starship -y
sudo dnf install vim neovim fish starship tldr qalc -y
```

Set Fish as Your Default Shell:
log out and back in for this to take full effect.

    ```bash
    chsh -s $(which fish)
    ```

Install LazyVim:
*Note: From this point on, you can likely run commands without `sudo` unless specified.*

    ```bash
    # Clone the LazyVim starter
    git clone https://github.com/LazyVim/starter ~/.config/nvim
    ```
    The next time you run `nvim`, LazyVim will install itself.

# 1.5 Backups

Let's configure the system snapshots. We'll do a basic setup.

1.  **Install Snapper:**

    ```bash
    sudo dnf install snapper python3-dnf-plugin-snapper -y
    ```

2.  **Create a Snapper Configuration for Your System Root (`/`):**

    ```bash
    # This deletes a default config that might exist and creates a new one
    sudo snapper -c root create-config /
    ```

3.  **Enable Automatic Timeline Snapshots:**
    This will take a snapshot every hour.

    ```bash
    sudo systemctl enable --now snapper-timeline.timer
    ```
    Now, Snapper will also automatically take a snapshot before and after every `dnf` command you run. You are now protected!

SPOTIFY
``` bash
flatpak install flathub com.spotify.Client
flatpak run com.spotify.Client
# then close spotify idk how to do with command
curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh
curl -fsSL https://raw.githubusercontent.com/spicetify/marketplace/main/resources/install.sh | sh
spicetify
spicetify --path /var/lib/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify/
spicetify --prefs ~/.var/app/com.spotify.Client/config/spotify/prefs
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

dotfile manager grrr
not super sure if we want no bar, might just make a config then toggle it on or something

CONFIG:


1.  **Find a Wallpaper:** Download a wallpaper you like and configure `hyprpaper`.
2.  **Configure Waybar:** Edit `~/.config/waybar/config` and `style.css` to customize your status bar.
3.  **Configure Starship & Fish:** Run `starship preset pure-preset > ~/.config/starship.toml` to get a good starting prompt, then explore the Starship website for more options.
4.  **Theme Your Applications:** Run `nwg-look` to set a dark GTK theme and a cursor theme so your graphical apps like Thunar and Ungoogled Chromium look consistent. You may need to install themes first (e.g., `sudo dnf install adwaita-dark-theme bibata-cursor-themes`).
5.  **Configure Fuzzel & Mako:** They have their own config files in `~/.config/fuzzel/fuzzel.ini` and `~/.config/mako/config` for you to customize colors and behavior.
6.  **Set up BorgBackup:** Install it with `sudo dnf install borgbackup` and write a simple script to back up your `/home` directory to an external drive.
