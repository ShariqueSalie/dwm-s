.PHONY: install print-config print-theme-dir

SDDM_CONF_DIR = $(DESTDIR)/etc/sddm.conf.d
THEME_DIR = $(DESTDIR)/usr/share/sddm/themes
THEME_NAME = dwm-s

print-config:
	@printf '%s\n' '[Theme]'
	@printf 'Current=%s\n' "$(THEME_NAME)"

print-theme-dir:
	@printf '%s\n' '$(THEME_DIR)/$(THEME_NAME)'

install:
	tmp=$$(mktemp); \
	trap 'rm -f "$$tmp"' EXIT; \
	$(MAKE) --no-print-directory print-config >"$$tmp"; \
	if [ -f $(SDDM_CONF_DIR)/20-dwm-s.conf ] && ! cmp -s "$$tmp" $(SDDM_CONF_DIR)/20-dwm-s.conf; then \
		cp -a $(SDDM_CONF_DIR)/20-dwm-s.conf $(SDDM_CONF_DIR)/20-dwm-s.conf.dwm-s.$$(date +%Y%m%d%H%M%S).bak; \
	fi; \
	install -Dm644 "$$tmp" $(SDDM_CONF_DIR)/20-dwm-s.conf
	install -Dm644 metadata.desktop $(THEME_DIR)/$(THEME_NAME)/metadata.desktop
	install -Dm644 theme.conf $(THEME_DIR)/$(THEME_NAME)/theme.conf
	install -Dm644 Main.qml $(THEME_DIR)/$(THEME_NAME)/Main.qml
	install -Dm644 wallpaper.png $(THEME_DIR)/$(THEME_NAME)/wallpaper.png
