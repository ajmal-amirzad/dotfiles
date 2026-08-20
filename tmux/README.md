# tmux Setup

## 1. Install tmux

Install tmux using Homebrew:

```bash
brew install tmux
```

Verify the installation:

```bash
tmux -V
```

## 2. Create the tmux configuration

Create the configuration directory:

```bash
mkdir -p ~/.config/tmux
```

Create your configuration file:

```bash
touch ~/.config/tmux/.tmux.conf
```

Place the provided tmux configuration in:

```text
~/.config/tmux/.tmux.conf
```

tmux normally looks for `~/.tmux.conf`, so create a symlink:

```bash
ln -sf ~/.config/tmux/.tmux.conf ~/.tmux.conf
```

The final structure should look like:

```text
~/.tmux.conf -> ~/.config/tmux/.tmux.conf

~/.config/tmux/
└── .tmux.conf
```

## 3. Install TPM

Clone Tmux Plugin Manager into the location referenced by the configuration:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

Your structure should now look like:

```text
~/.tmux.conf -> ~/.config/tmux/.tmux.conf

~/.config/tmux/
├── .tmux.conf
└── plugins/
    └── tpm/
```

## 4. Start tmux and load the configuration

Start tmux:

```bash
tmux
```

Since the configuration changes the prefix from `Ctrl-b` to `Ctrl-s`, manually source the configuration first:

```bash
tmux source-file ~/.tmux.conf
```

Alternatively, from inside tmux:

```text
Ctrl-b :
```

then run:

```text
source-file ~/.tmux.conf
```

After the configuration has been loaded, the new prefix is active:

```text
Ctrl-s + r
```

This reloads the configuration and displays:

```text
Config reloaded
```

**From now on, use `Ctrl-s + r` to reload the configuration.**

## 5. Install tmux plugins

Inside tmux, press:

```text
Ctrl-s + I
```

TPM will install all plugins defined in `.tmux.conf`.

The configured plugins include:

* `tmux-sensible`
* `vim-tmux-navigator`
* `dracula/tmux`
* `tmux-menus`

## 6. Useful Keybindings

### Prefix

```text
Ctrl-s
```

### Reload configuration

```text
Ctrl-s + r
```

### Pane navigation

```text
Ctrl-s + h    Left
Ctrl-s + j    Down
Ctrl-s + k    Up
Ctrl-s + l    Right
```

### Resize panes

```text
Ctrl-s + H    Resize left
Ctrl-s + J    Resize down
Ctrl-s + K    Resize up
Ctrl-s + L    Resize right
```

### Split panes

```text
Ctrl-s + |    Split horizontally
Ctrl-s + -    Split vertically
```

### Plugin management

```text
Ctrl-s + I    Install plugins
Ctrl-s + U    Update plugins
```

## 7. Notes

The TPM initialization line must remain **at the very bottom** of `.tmux.conf`:

```bash
run '~/.config/tmux/plugins/tpm/tpm'
```

If the Dracula status bar displays missing icons, make sure a Nerd Font is installed and configured in your terminal.

