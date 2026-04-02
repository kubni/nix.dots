{
  imports = [
    ./waybar
  ];
  wayland.windowManager.mango = {
     enable = true;
     settings = ''
      allow_tearing=1
      windowrule=force_tearing:1,appid:.*
      adaptive_sync=1
      accel_profile=0
      drag_tile_to_tile=1
      no_border_when_single=1

      xkb_rules_layout=us,rs
      xkb_rules_variant=,latin
      xkb_rules_options=grp:ralt_rshift_toggle

      # Env vars
      env=GTK_IM_MODULE,fcitx
      env=QT_IM_MODULE,fcitx
      env=SDL_IM_MODULE,fcitx
      env=XMODIFIERS,@im=fcitx
      env=GLFW_IM_MODULE,ibus

      # Monitor rules
      monitorrule=HDMI-A-1,0.55,1,tile,0,1,0,0,1920,1080,60
      monitorrule=DP-2,0.55,1,tile,0,1,1920,0,2560,1440,74.97

      #Keys
      keymode=common
      bind=Super+Shift,r,reload_config

      keymode=default
      bind=Super,Return,spawn,wezterm
      bind=Super,q,killclient,
      bind=Super,d,spawn,wofi --show drun
      bind=alt,f,spawn,wezterm start ranger
      bind=Super+Shift,q,quit 
      bind=Print,spawn_shell,grim -g "$(slurp)" - | wl-copy && wl-paste > ~/Screenshots/Screenshot-$(date +%F_%T).png | dunstify "Screenshot of the region taken" -t 1000"
      bind=SHIFT+Print,spawn_shell,grim -c - | wl-copy && wl-paste > ~/Screenshots/Screenshot-$(date +%F_%T).png | dunstify "Screenshot of the whole screen taken"

      ## Tag management
      bind=SUPER,0,view,0
      bind=SUPER,1,view,1
      bind=SUPER,2,view,2
      bind=SUPER,3,view,3
      bind=SUPER,4,view,4
      bind=SUPER,5,view,5
      bind=SUPER,6,view,6
      bind=SUPER,7,view,7
      bind=SUPER,8,view,8
      bind=SUPER,9,view,9

      bind=SUPER+SHIFT,1,tag,1
      bind=SUPER+SHIFT,2,tag,2
      bind=SUPER+SHIFT,3,tag,3
      bind=SUPER+SHIFT,4,tag,4
      bind=SUPER+SHIFT,5,tag,5
      bind=SUPER+SHIFT,6,tag,6
      bind=SUPER+SHIFT,7,tag,7
      bind=SUPER+SHIFT,8,tag,8
      bind=SUPER+SHIFT,9,tag,9
      bind=SUPER+SHIFT,0,tag,10

      ## Window management
      bind=SUPER,Left,focusdir,left
      bind=SUPER,Down,focusdir,down
      bind=SUPER,Up,focusdir,up
      bind=SUPER,Right,focusdir,right
      bind=SUPER+Shift,f,togglefullscreen,
      ## Layouts  
      bind=ALT+Shift,s,setlayout,scroller
      bind=ALT+Shift,v,setlayout,vertical_scroller,
      bind=ALT+Shift,t,setlayout,tile
     '';
     autostart_sh = ''
      mako &
      wl-paste --type text --watch cliphist store
      wl-paste --type image --watch cliphist store 
      '';
   };
 }
 
 
 
 
 
