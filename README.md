
Geary: Send and receive email
=============================

![Geary icon](https://gitlab.gnome.org/GNOME/geary/raw/HEAD/icons/hicolor/scalable/apps/org.gnome.Geary.svg)

Geary is an email application built around conversations, for the
GNOME desktop. It allows you to read, find and send email with a
straight-forward, modern interface.

![Geary displaying a conversation](https://static.gnome.org/appdata/geary/geary-40-main-window.png)

## Changes in this fork

- **Resizable panes**: Replaced the responsive Handy leaflet layout with fixed GtkPaned panels, allowing the folder list, conversation list, and conversation viewer to be resized by dragging the dividers. Pane positions are saved and restored between sessions.
- **Always load remote images**: Added a global preference to always load remote images in all emails, bypassing per-sender authentication checks.
- **Override HTML email colors**: Added a preference to override original colors in HTML emails for better integration with the app theme.
- **Merged image loading options**: Consolidated the two separate remote image loading toggles into a single, clear preference.
- **Minimum pane widths**: Set minimum widths for each section (sidebar: 100px, mail list: 200px, mail detail: 300px) to prevent panels from collapsing.

## Original project

Upstream repository: https://gitlab.gnome.org/GNOME/geary
