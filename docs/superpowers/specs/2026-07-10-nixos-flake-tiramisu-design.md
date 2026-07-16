# NixOS Flake: tiramisu

Date: 2026-07-10
Status: approved

## Goal

A NixOS flake in `flake/` that configures this laptop (host `tiramisu`) as a
full NixOS system, with home-manager embedded as a NixOS module so a single
`nixos-rebuild switch` manages both system and user environment. The repo
(`~/figs`) remains the live source of truth for complex configs via
out-of-store (OOS) symlinks.

## Hardware (captured from live system, 2026-07-10)

- CPU: Intel Core Ultra 7 255U (Arrow Lake-U) → `kvm-intel`, Intel microcode,
  `linuxPackages_latest` (new iGPU + CNVi wifi want a fresh kernel)
- GPU: Intel Arrow Lake-U iGPU → `hardware.graphics` with `intel-media-driver`
- Wifi: Intel CNVi (iwlwifi, in-kernel)
- RAM: 64 GB
- Boot: UEFI, ESP mounted at `/efi` → systemd-boot
- Disk: nvme0n1
  - p1 vfat `4E54-8401` → `/efi`
  - p2 swap `de91c1dc-c9e1-46b8-8800-e22869db0957`
  - p3 ext4 `19951959-6c24-4978-a505-78cb72004278` → `/`
- Partition layout is kept as-is; hardware.nix is written by hand from these
  UUIDs so an in-place reinstall (keep p1–p3, install NixOS onto p3) works.
- Timezone: America/Los_Angeles; locale en_US.UTF-8.

## Flake layout

```
flake/
  flake.nix                  # inputs: nixpkgs (nixos-unstable), home-manager
  hosts/tiramisu/
    default.nix              # system configuration
    hardware.nix             # handwritten hardware config
  home/
    home.nix                 # entry point for user june
    modules/
      packages.nix           # user packages
      zsh.nix                # native programs.zsh port of zsh/zshrc
      kitty.nix              # native programs.kitty port of kitty/kitty.conf
      dunst.nix              # native services.dunst port of dunst/dunstrc
      xdg.nix                # xdg.userDirs from user-dirs.dirs
      symlinks.nix           # OOS symlinks into ~/figs
```

## System configuration

- systemd-boot, ESP at `/efi`
- hostname `tiramisu`, NetworkManager, bluetooth
- pipewire (alsa + pulse), rtkit
- greetd + tuigreet
- Both compositors: `programs.hyprland.enable` and `programs.sway.enable`
- Docker (`virtualisation.docker.enable`; a `/var/lib/docker` mount exists on
  the current install)
- thermald + power-profiles-daemon (laptop)
- user `june`: wheel, docker, video, input; shell zsh
- fonts: tamzen, nerd-fonts.gohufont, noto-fonts (+emoji)
- polkit, xdg-desktop-portal (hyprland + wlr + gtk)
- `system.stateVersion = "26.05"` (fresh install)

## Home-manager (NixOS module)

`home-manager.users.june`, `useGlobalPkgs` + `useUserPackages`.

### Native module ports

- **zsh** (`programs.zsh` + oh-my-zsh): HM owns oh-my-zsh install. Bundled omz
  plugins: git fzf docker docker-compose eza colorize kitty urltools z
  ssh-agent colored-man-pages. Custom plugins replaced with HM natives:
  `autosuggestion.enable`, `syntaxHighlighting.enable`, zsh-completions via
  package. Aliases, exports, `vpn`/`mcd` functions, PATH additions, `source
  ~/.keys` (guarded), opam hook ported into `initContent`/`shellAliases`.
  Dropped as Gentoo-specific: os-release branch, `/usr/lib64` QML_IMPORT_PATH,
  `makeport`/`xxx` portage aliases, `EDITOR=/usr/bin/nvim` becomes
  `EDITOR=nvim`.
- **starship**: `programs.starship.enable` + zsh integration (replaces manual
  eval)
- **pyenv**: `programs.pyenv` (replaces manual eval)
- **fzf**: `programs.fzf`
- **kitty**: `programs.kitty.settings` (Tamzen font, padding 5, column width
  110%); `include themes/dark.conf` preserved, themes dir OOS-symlinked
- **dunst**: `services.dunst.settings` (GohuFont, #489c7a frame, urgency
  sections)
- **xdg.userDirs**: from `user-dirs.dirs`

### OOS symlinks (`config.lib.file.mkOutOfStoreSymlink` → `~/figs/...`)

nvim, novim, hypr, sway, waybar, quickshell, yazi, rofi, tmux, newsboat,
kitty/themes. `scripts/*` → `~/.local/bin`. Live-edit workflow preserved;
requires the repo checked out at `~/figs`.

**Deviation from the earlier draft:** tmux and newsboat moved from "native"
to OOS. tmux.conf is built around tpm with vendored plugins and scripts under
`~/.config/tmux`; newsboat depends on its urls/themes files. Native ports
would fight both. Packages still installed by nix.

### Packages (user)

neovim, tmux, yazi, newsboat, kitty, rofi-wayland, waybar, quickshell, eza,
zoxide, jq, ripgrep, fd, wireguard-tools, grim, slurp, wl-clipboard.

## Verification

On this (non-NixOS) machine: `nix flake check` and
`nix eval .#nixosConfigurations.tiramisu.config.system.build.toplevel.drvPath`
(full evaluation without building). Flakes enabled per-command via
`--extra-experimental-features 'nix-command flakes'`. Files must be
git-added for the flake to see them.

## Usage (after installing NixOS on this machine)

```
sudo nixos-rebuild switch --flake ~/figs/flake#tiramisu
```
