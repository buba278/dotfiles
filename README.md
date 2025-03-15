# Debian

![hi](readme_images/desktop_preview.png?raw=true)

Things to cover
fonts cursor wm bar runner appimages packages sshkey and agent stow system debinstal spotify yazi

setup sudoers file:
```
su
sudo visudo
```

then add this line:
```
chris  ALL=(ALL) ALL
```

```
sudo apt install alacritty code feh fonts-firacode fonts-jetbrains-mono gh git i3 opentabletdriver qalc scrot stow xclip zathura vim
```

Other Apps (non packages):
- yazi (source code)
- stm32cubeide [(manual package)](https://www.st.com/en/development-tools/stm32cubeide.html)
- 

TODO: Make bash script

but unfortuntaley taking break from linux...

# Windows
This is less important cause its not like actual dotfiles but a good refresher to do the manual setup a bit quicker

Debloat windows with the [Chris Titus tool](https://github.com/ChrisTitusTech/winutil)
## Microwin
Run with admin:
```
irm "https://christitus.com/win" | iex
```
First get the MicroWin ISO to reinstall.

When getting the ISO if there is a script running error, change the permissions
```
Set-ExecutionPolicy -ExecutionPolicy Unrestricted
```
Put on a ventoy drive if want

## Apps
- Photoshop / Adobe stuff (m0nkrus)
- Altium
- Equalizer APO / Peace
- LTSpice
- Teams
- Moku
- Motec Build/Tune/i2
- Obsidian
- Osu
  - Batch Beatmap Downloader
  - Osu trainer
  - OBS
- qalc
- qBittorrent
- Spotify/Spicetify
- Stm32CubeIDE
- Vesktop/Discord
- 7zip
- Xpp/Onenote
- Candapter Analyzer
- Fusion 360

IF AFTER FINISHING SETUP OSU FEELS FLOATY LOOK AT:
- Dual Monitors (turn second one off)
- NVIDIA profiler
- Make sure all overlay apps are disabled
note: pretty sure fullscreen optimisations is irrelevant now
