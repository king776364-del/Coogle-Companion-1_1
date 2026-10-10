#!/system/bin/sh
PACKAGE=com.google.android.googlequicksearchbox
APP_DIR=$MODPATH/system/priv-app/GoogleQuickSearchBox

mkdir -p "$APP_DIR"
find "$APP_DIR" -maxdepth 1 -type f -name '*.apk' -delete 2>/dev/null

pm path "$PACKAGE" 2>/dev/null |
  sed -n 's/^package://p' |
  while IFS= read -r apk; do
    [ -f "$apk" ] || continue
    cp -f "$apk" "$APP_DIR/${apk##*/}"
done

set_perm_recursive $MODPATH 0 0 0755 0644

set_perm_recursive "$MODPATH/system" 0 0 0755 0644
for script in boot-completed.sh setup.sh uninstall.sh prepare-audio.sh status.sh; do
    set_perm "$MODPATH/$script" 0 0 0755
done
/system/bin/sh "$MODPATH/prepare-audio.sh"
ui_print "Google system app, enrollment and DSP support combined. Reboot required."
