# My NixOS configurations
I use multiple machines (currently 3) that run NixOS: `homepc` (desktop pc), `legion` (laptop), `thinkcentre` (server).

## Reasoning
I wanted to organize those multiple configurations nicely, in order to make the config reading and editing actions easier.
I am tinkering with this almost daily, so breaking changes are happening often.

## Directory structure
Top-level directory contains:
  * `flake.nix` and its `flake.lock`
  * `configs` directory, which holds specific configurations and the special shared directory.
  * `overlays` directory, which contains some package fixes via overlays
  * `secrets` directory, which is used by `agenix` for storing and managing `.age` files, which hold encrypted secrets (stuff like passwords, ssh private keys, ...)

#### Configs directory
The shared directory has `by-all` and `by-pcs` dirs, which contain stuff shared by all 3 configs, and by pc configs respectively.
Stuff that is specific to a single configuration are added to its config dir, in the exactly same way as we did for the shared stuff in `shared`, i.e without any special concatenation 
logic.

*An example*:

Hyprland's config file, found at `shared/by-pcs/home-manager/programs/hyprland/default.nix`:
```nix
 wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    configType = "hyprlang";

    settings = {
      debug.disable_logs = true;
      exec-once = [
        "mako &"
        "noctalia &"
      ];
      # .... many more options ....
     };
```
Now, the device-specific Hyprland's config file, found at `homepc/home-manager/programs/hyprland/default.nix`:
```nix
wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        "DP-2,2560x1440@74.97,auto,auto"
        "HDMI-A-1,preferred,auto-left,auto"
      ];
      # .... other homepc-specific options ....
    };
```
Monitor configuration is something specific to the actual device, so we needed to specify that per device, but the syntax is identical, without any concatenation logic which would append
device-specific adjustments to the shared logic.
