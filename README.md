# Pre-Ramble
distros are just software philosiphy around repositories and package manager.
i like history and rollback of dnf, I like fedora professional software repository testing and philosiphy of 6 month releases. also I like not having to do the tedious shit with arch just for the sake of it even though it was good to learn, and get a vibe for but really its just pretending cause if you really want to learn then go do linux from scratch, in fact go make a processor first, in fact make your own IC, and find the silicone and make the machinery yourself. dickhed.

we back to linux. but only on my desktop, because I still need to do uni and fs on my windows laptop. I can have fun at home.

this setup will be based around fedora minimal install that I did through the everything net installer. refer to that ramble above if you ever forget why and question if you should try another distro. this will be a bit more slow and methodical cause im not using it for my main system yet im just slowly building things together. 

I initially started with fedora workstation 42, then i was like, damn this gnome thing is kinda too sterile and multi purpose, I kinda miss the instant feeling tm setup I had, it was more FUN. So then I tried the way install, then realised it was kinda ugly and I wanted things to be pretty so I'm now onto using hyperland for its transparency (not animations).

Note that as of writing this right now I havent even installed anything, cause I don't have super amounts of time right now and I kinda want to do the setup and documentation at the same time, cause then it'll be easier to recreate or make a script for.

# rough things I want
lazyvim
dnf parallel downloads
fedora minimal install
system snapshots
some backup system like maybe rsync?
hyprland, 
whatever wayland stuff I need for hyprland
neovim foot 
fish (ill have to learn about this)
 waybar rofi
I dont think I need thunar or yazi or any file explorer i want to get good at terminal file commands but I realise what about the file picker stuff hmm
sound stuff setup
cursors setup
hyprpaper
oh damn and think about the whole stuff how it used to be on arch of manually having to mount flashdrives and stuff I wonder if fedora already handles that? probably not unless I have a file explorer like thunar huh
some sort of clipboard manager
maybe dunst but feel free to recommend something else its just what I know
idk if there is some authentication agent I need (i just want simple)
ungoogled-chromium

idk if you have preference for the audio stuff but i used to use playerctl and pamixer if thats still good, and brightnessctl though im on a desktop so idk if I need that 

had hyprshot and yeah idk give me some other suggestions

# Setup
## 1. housekeeping
``` bash
sudo nano /etc/dnf/dnf.conf
```
enable DNF parallel downlods by adding `max_parallel_downloads=10` to bottom of file

or just run 
``` bash
echo "max_parallel_downloads=10" | sudo tee -a "/etc/dnf/dnf.conf"
```
where we effectively pipe (with output) and append our line

then we can update
``` bash
sudo dnf upgrade --refresh -y
```

setup community package repo, RPM Fusion for stuff like NVIDIA drivers
``` bash
sudo dnf install \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
```

install NVIDIA drivers and kernel modules
``` bash
sudo dnf install akmod-nvidia xorg-x11-drv-nvidia-cuda -y
```

reboot to make sure new kernel modules are loaded
``` bash
sudo reboot
```

### 1.2 DE
install hyprland and associated thangs along with some goodies

``` bash
sudo dnf copr enable solopasha/hyprland
sudo dnf install hyprland hyprpaper foot waybar \
xorg-x11-server-Xwayland qt5-qtwayland qt6-qtwayland \
lxqt-policykit -y
```
- hyprland, hyprpaper, foot, waybar: The core components I chose.
- Xwayland: The critical compatibility layer for non-Wayland apps.
- qt-wayland: For Qt-based applications to run properly.
- lxqt-policykit: The simple authentication agent that will ask for password.

dev tools group for stuff like gcc and make
``` bash
sudo dnf install @development-tools -y
```

### 1.3 Other system needs
ui stuff
``` bash
sudo dnf install fuzzel mako cliphist -y
```
- fuzzel: Your Wayland-native application launcher.
- mako: Your notification daemon.
- cliphist: The clipboard manager.

system int 
``` bash
sudo dnf install thunar udiskie playerctl pamixer \
xdg-desktop-portal-hyprland nwg-look -y
```
- Thunar: The file manager we'll use for file-picker dialogs.
- udiskie: The service that will auto-mount USB drives.
- playerctl & pamixer: For controlling media playback and volume.
- xdg-desktop-portal-hyprland: The backend that allows apps to request things like file pickers.
- nwg-look: A tool to set your cursor and application themes.

screenshot utils
``` bash
sudo dnf install grim slurp satty -y
```

- grim: The screenshot tool for Wayland.
- slurp: The tool to select a region of the screen.
- satty: The screenshot editor you can pipe the image to.

## 1.4 actual software
    ```bash
    sudo dnf copr enable atim/starship -y
    sudo dnf install firefox neovim fish starship -y
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

run `hyprland` after startup to get into DE

1.  **Find a Wallpaper:** Download a wallpaper you like and configure `hyprpaper`.
2.  **Configure Waybar:** Edit `~/.config/waybar/config` and `style.css` to customize your status bar.
3.  **Configure Starship & Fish:** Run `starship preset pure-preset > ~/.config/starship.toml` to get a good starting prompt, then explore the Starship website for more options.
4.  **Theme Your Applications:** Run `nwg-look` to set a dark GTK theme and a cursor theme so your graphical apps like Thunar and Ungoogled Chromium look consistent. You may need to install themes first (e.g., `sudo dnf install adwaita-dark-theme bibata-cursor-themes`).
5.  **Configure Fuzzel & Mako:** They have their own config files in `~/.config/fuzzel/fuzzel.ini` and `~/.config/mako/config` for you to customize colors and behavior.
6.  **Set up BorgBackup:** Install it with `sudo dnf install borgbackup` and write a simple script to back up your `/home` directory to an external drive.
