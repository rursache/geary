#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

BUILD_DIR="build"

# Runtime dependencies (uncomment to install if needed)
# RUNTIME_DEPS=("webkit2gtk-4.1" "libhandy" "gspell" "gmime3" "gsound" "libpeas-2" "libytnef" "folks")
# BUILD_DEPS=("git" "vala" "gobject-introspection" "itstool" "meson" "ninja")
# sudo pacman -S --needed --noconfirm "${RUNTIME_DEPS[@]}" "${BUILD_DEPS[@]}"

# Configure if no build dir
if [ ! -d "$BUILD_DIR" ]; then
    echo "==> Configuring..."
    meson setup "$BUILD_DIR" -Dprofile=release --prefix=/usr
fi

# Build
echo "==> Building..."
ninja -C "$BUILD_DIR"

echo "==> Build succeeded!"

# Install (needs sudo)
if [ "$1" = "--install" ] || [ "$1" = "-i" ]; then
    # Kill any running geary process
    echo "==> Stopping running Geary instances..."
    pkill -f geary || true

    # Clean up stale files from a previous /usr/local install
    if [ -f /usr/local/bin/geary ] || [ -f /usr/local/share/glib-2.0/schemas/org.gnome.Geary.gschema.xml ]; then
        echo "==> Removing stale /usr/local install..."
        sudo rm -f /usr/local/bin/geary
        sudo rm -rf /usr/local/share/geary /usr/local/lib/geary /usr/local/share/applications/*geary*
        sudo rm -f /usr/local/share/glib-2.0/schemas/org.gnome.Geary.gschema.xml
        sudo glib-compile-schemas /usr/local/share/glib-2.0/schemas/
    fi

    echo "==> Installing (requires sudo)..."
    sudo meson install -C "$BUILD_DIR"

    echo "==> Compiling GLib schemas..."
    sudo glib-compile-schemas /usr/share/glib-2.0/schemas/

    echo "==> Updating desktop database..."
    sudo update-desktop-database /usr/share/applications/

    echo "==> Installed! Restart Geary to see changes."
else
    echo "==> Run with --install (-i) to install system-wide"
fi
