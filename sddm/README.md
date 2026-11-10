# dwm-s SDDM greeter

The repository ships a small SDDM theme so systems that use SDDM get a branded
login screen with the selected wallpaper.

Install it with root:

```sh
sudo make -C sddm install
```

The install target writes:

- `/etc/sddm.conf.d/20-dwm-s.conf` (`Current=dwm-s`)
- `/usr/share/sddm/themes/dwm-s/{metadata.desktop,theme.conf,Main.qml,wallpaper.png}`

Replace `sddm/wallpaper.png` to change the login wallpaper, then reinstall and
restart SDDM or reboot. The theme is also installed by `install.sh` when SDDM is
the detected display manager.
