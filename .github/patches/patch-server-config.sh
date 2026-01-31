#!/bin/bash
# Patches RustDesk config with custom server and branding settings
# Uses environment variables: CUSTOM_SERVER, CUSTOM_KEY, CUSTOM_APP_NAME

CONFIG_FILE="libs/hbb_common/src/config.rs"

if [ -n "$CUSTOM_SERVER" ]; then
    sed -i'' -e "s|pub const RENDEZVOUS_SERVERS: &\[&str\] = &\[\".*\"\];|pub const RENDEZVOUS_SERVERS: \&[\&str] = \&[\"$CUSTOM_SERVER\"];|" "$CONFIG_FILE"
    echo "Patched RENDEZVOUS_SERVERS to: $CUSTOM_SERVER"
fi

if [ -n "$CUSTOM_KEY" ]; then
    sed -i'' -e "s|pub const RS_PUB_KEY: &str = \".*\";|pub const RS_PUB_KEY: \&str = \"$CUSTOM_KEY\";|" "$CONFIG_FILE"
    echo "Patched RS_PUB_KEY"
fi

# Patch APP_NAME for branding (default: MikoDesk)
CUSTOM_APP_NAME="${CUSTOM_APP_NAME:-MikoDesk}"
sed -i'' -e "s|pub static ref APP_NAME: RwLock<String> = RwLock::new(\".*\".to_owned());|pub static ref APP_NAME: RwLock<String> = RwLock::new(\"$CUSTOM_APP_NAME\".to_owned());|" "$CONFIG_FILE"
echo "Patched APP_NAME to: $CUSTOM_APP_NAME"

grep -n "RENDEZVOUS_SERVERS\|RS_PUB_KEY\|APP_NAME" "$CONFIG_FILE" | head -10
