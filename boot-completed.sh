#!/system/bin/sh
MODDIR=${0%/*}
sleep 30
# Binder shell commands require pipe FDs rather than module-directory FDs.
/system/bin/sh "$MODDIR/setup.sh" 2>&1 | cat > /dev/null
/system/bin/sh "$MODDIR/status.sh" > /dev/null 2>&1
