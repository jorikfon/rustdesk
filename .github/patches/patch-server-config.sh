#!/bin/bash
# Patches RustDesk config with custom server settings
# Uses environment variables: CUSTOM_SERVER, CUSTOM_KEY

CONFIG_FILE="libs/hbb_common/src/config.rs"

if [ -n "$CUSTOM_SERVER" ]; then
    sed -i'' -e "s|pub const RENDEZVOUS_SERVERS: &\[&str\] = &\[\".*\"\];|pub const RENDEZVOUS_SERVERS: \&[\&str] = \&[\"$CUSTOM_SERVER\"];|" "$CONFIG_FILE"
    echo "Patched RENDEZVOUS_SERVERS to: $CUSTOM_SERVER"
fi

if [ -n "$CUSTOM_KEY" ]; then
    sed -i'' -e "s|pub const RS_PUB_KEY: &str = \".*\";|pub const RS_PUB_KEY: \&str = \"$CUSTOM_KEY\";|" "$CONFIG_FILE"
    echo "Patched RS_PUB_KEY"
fi

grep -n "RENDEZVOUS_SERVERS\|RS_PUB_KEY" "$CONFIG_FILE" | head -5
