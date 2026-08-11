# script

Personal scripts collection, organized by ecosystem. Everything is a
standalone executable; add the repo dirs to your `$PATH` (e.g. symlink
`~/.local/bin` to the category dirs) to use them.

## gnome/ — GNOME desktop (gsettings / gnome-extensions)

| Script | Description |
|---|---|
| `theme.sh` | Theme switcher: `dark`, `light`, `toggle`, `set <name>` |
| `dark-theme` | Apply the dark theme (wrapper for `theme.sh dark`) |
| `light-theme` | Apply the light theme (wrapper for `theme.sh light`) |
| `dock.sh` | Dock utilities: `toggle` (ubuntu-dock), `hide`, `isolate` |
| `custom_status.sh` | One-line status bar output (net, mem, temp, volume, battery, date) |

## wm/ — Window managers

| Script | Description |
|---|---|
| `toggle-touchpad` | Toggle the touchpad on/off in Hyprland (with notification) |
| `start-sway.sh` | Launch Sway with Wayland env vars (`-i` for interactive debug) |

## media/ — Audio/video, downloads, volume

| Script | Description |
|---|---|
| `add-srt.sh` | Merge video + subtitle into MP4 via ffmpeg (`-d <ext>` for a whole directory) |
| `ytdl.sh` | yt-dlp wrapper: `best`, `top`, `music`, `thumbnail`, `update` |
| `tidy-downloads.py` | Classify `~/Downloads` into Series/Films/Videos, extract archives |
| `adzan.sh` | Prayer-time reminder daemon (plays adhan via mpv) |
| `volume-helper` | PipeWire/PulseAudio volume control with desktop notification |

## net/ — Network

| Script | Description |
|---|---|
| `internet-speed-test.sh` | Periodic speedtest-cli runs, logged to CSV |
| `ndt7-test.sh` | Single ndt7-client measurement, appended to a log |

## setup/ — Toolchain and environment bootstrap

| Script | Description |
|---|---|
| `setup-env` | Interactive menu for the installers below |
| `install-nvm` | Idempotent NVM install |
| `install-rust` | Idempotent rustup install |
| `install-sdkman` | Idempotent SDKMAN install |
| `install-nvim` | Neovim latest release install with checksum verification |
| `setup-helix.sh` | Helix editor install to /opt |
| `zsh-profile.sh` | Interactive zsh setup (basic / oh-my-zsh / grml) |
| `emacs-profile.sh` | Clone Spacemacs profiles and switch `.emacs.d` symlinks |

## dev/ — Editors and build helpers

| Script | Description |
|---|---|
| `vscode.sh` | Launch VSCode with per-profile data/extensions dirs |
| `emacsclient-server.sh` | Open a file in an existing emacsclient frame or start one |
| `gcpp.sh` | Compile a C++ file with strict flags |

## shell/ — Shell helpers

| Script | Description |
|---|---|
| `short-pwd` | Abbreviate the current directory for a prompt |
| `cd2` | Print the directory stack |
| `ppath.sh` | Resolve a path relative to this repo dir |

## python/, powershell/, nautilus/ — Platform-specific

- `python/speech-to-text.py` — IBM Watson speech-to-text transcription (requires `IBM_WATSON_API_KEY` env var)
- `powershell/*.ps1` — Windows counterparts (subtitle merge, WebP conversion, yt-dlp wrapper)
- `nautilus/*` — Nautilus right-click scripts (flat dir required; depends on `add-srt.sh` on `$PATH`)
