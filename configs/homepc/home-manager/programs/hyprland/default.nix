{pkgs, lib, hyprland, hyprsplit, ...}: # TODO: Hyprsplit

{
  imports = [
    ./waybar
    ./hyprpaper.nix
  ]; 
	
  wayland.windowManager.hyprland = {
     enable = true;
     package = null;
     portalPackage = null;

     settings = {
       debug = {
        disable_logs = false;
       };
       monitor = [
	 "DP-3,2560x1440@74.97,auto,auto"
	 "HDMI-A-1,preferred,auto-left,auto"
       ];

       exec-once = [
	 "mako &"
	 "wl-paste --type text --watch cliphist store"
	 "wl-paste --type image --watch cliphist store"
       ];

       "$mainMod" = "SUPER";
       "$terminal" = "wezterm";
       "$fileManager" = "wezterm ranger";
       "$menu" = "wofi --show drun";

       env = [
	 "HYPRCURSOR_SIZE, 40"
   "QT_QPA_PLATFORM,wayland;xcb"
	 "QT_QPA_PLATFORMTHEME, qt6ct"

	 # Nvidia stuff
	 "LIBVA_DRIVER_NAME, nvidia"
   "NVD_BACKEND, direct"
   "MOZ_DISABLE_RDD_SANDBOX, 1"
   "EGL_PLATFORM, wayland"
	 "XDG_SESSION_TYPE, wayland"
   "XDG_SESSION_DESKTOP, Hyprland"
   "XDG_CURRENT_DESKTOP, Hyprland"
	 #"GBM_BACKEND, nvidia-drm"  # Enabling this makes Hyprland crash when second monitor is plugged in
	 "__GLX_VENDOR_LIBRARY_NAME, nvidia"
       ];

       input = {
	 kb_layout = "us,rs,";
	 kb_variant = ",latin";
	 kb_model = ",qwerty";
	 kb_options = "grp:alt_shift_toggle";

	 follow_mouse = "1";
	 sensitivity = "0";
       };

       general = {
	 gaps_in = "5";
	 gaps_out = "10";
	 border_size = "2";
	 "col.active_border" = "rgba(8fbcbbaa) rgba(88c0d0aa) rgba(81a1c1aa) rgba(5e81acaa) 45deg";
	 "col.inactive_border" = "rgba(595959aa)";

	 layout = "master";
       };

       #windowrulev2 = [
       #  "immediate, class:^(cs2)$"
       #];

       decoration = {
     rounding = "10";
     blur = {
       enabled = "true";
       size = "3";
       passes = "1";
       vibrancy = "0.1696";
     };
     shadow = {
       enabled = "true";
       range = "4";
       render_power = "3";
       color = "rgba(1a1a1aee)";
     };
   };
       animations = {
	 enabled = "true";
	 bezier = [
	   "myBezier, 0.05, 0.9, 0.1, 1.05"
	 ];
	 animation = [
	   "windows, 1, 7, myBezier"
	   "windowsOut, 1, 7, default, popin 80%"
	   "border, 1, 10, default"
	   "borderangle, 1, 8, default"
	   "fade, 1, 7, default"
	   "workspaces, 1, 6, default"
	 ];
       };

       dwindle = {
	 pseudotile = "true";
	 preserve_split = "true";
       };

       master = {
	 new_status = "master";
       };

       misc = {
	 force_default_wallpaper = "0";
	 enable_swallow = "true";
	 swallow_regex = "^(kitty)$";
       };

       device = {
	 name = "logitech-g403-prodigy-gaming-mouse";
	 accel_profile ="flat";
       };

       cursor = {
	 no_hardware_cursors = "true";
       };

       bind = [
	 "$mainMod, Q, killactive"
	 "$mainMod SHIFT, Q, exit"
	 "$mainMod SHIFT, F, fullscreen"
	 "$mainMod, P, pseudo"
	 "$mainMod, J, togglesplit"
	 "$mainMod, T, togglefloating"
	 
	 "$mainMod, RETURN, exec, $terminal"
	 "$mainMod, F, exec, librewolf"
	 "$mainMod, D, exec, $menu"
	 "$mainMod, E, exec, emacs"
	 "$mainMod, V, exec, cliphist list | wofi --dmenu | cliphistdecode | wl-copy"

	 "$mainMod, left, movefocus, l" 
	 "$mainMod, right, movefocus, r" 
	 "$mainMod, up, movefocus, u" 
	 "$mainMod, down, movefocus, d" 

	 "ALT, F, exec, $fileManager"
	 "ALT, P, exec, $terminal pulsemixer"
	 
	 ", Print, exec, grim -g \"$(slurp)\" - | wl-copy && wl-paste > ~/Screenshots/Screenshot-$(date +%F_%T).png | dunstify \"Screenshot of the region taken\" -t 1000"

	 "SHIFT, Print, exec, grim -c - | wl-copy && wl-paste > ~/Screenshots/Screenshot-$(date +%F_%T).png | dunstify \"Screenshot of the whole screen taken\""

	  "$mainMod, 1, split:workspace, 1"
	  "$mainMod, 2, split:workspace, 2"
	  "$mainMod, 3, split:workspace, 3"
	  "$mainMod, 4, split:workspace, 4"
	  "$mainMod, 5, split:workspace, 5"
	  "$mainMod, 6, split:workspace, 6"
	  "$mainMod, 7, split:workspace, 7"
	  "$mainMod, 8, split:workspace, 8"
	  "$mainMod, 9, split:workspace, 9"
	  "$mainMod, 10, split:workspace, 10"

	  "$mainMod SHIFT, 1,  split:movetoworkspace, 1"
	  "$mainMod SHIFT, 2,  split:movetoworkspace, 2"
	  "$mainMod SHIFT, 3,  split:movetoworkspace, 3"
	  "$mainMod SHIFT, 4,  split:movetoworkspace, 4"
	  "$mainMod SHIFT, 5,  split:movetoworkspace, 5"
	  "$mainMod SHIFT, 6,  split:movetoworkspace, 6"
	  "$mainMod SHIFT, 7,  split:movetoworkspace, 7"
	  "$mainMod SHIFT, 8,  split:movetoworkspace, 8"
	  "$mainMod SHIFT, 9,  split:movetoworkspace, 9"
	  "$mainMod SHIFT, 10, split:movetoworkspace, 10"

	  "$mainMod, mouse_down, split:workspace, e+1"
	  "$mainMod, mouse_up, split:workspace, e-1"

       ];

       bindm = [
	 "$mainMod, mouse:272, movewindow"
	 "$mainMod, mouse:273, resizewindow"
       ];
    };

    plugins = [
       hyprsplit.packages.${pkgs.system}.hyprsplit 
#      hyprspace.packages.${pkgs.system}.Hyprspace
    ];
  };
}
