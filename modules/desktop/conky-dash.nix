# conky.nix
{ pkgs, lib, ... }:

{
  services.conky = {
    enable = true;
    extraConfig = ''
    conky.config = {
      alignment = 'top_right',
      background = false,
      border_width = 1,
      cpu_avg_samples = 2,
      default_color = '#f5c2e7',
      double_buffer = true,
      draw_borders = false,
      draw_graph_borders = true,
      draw_outline = false,
      draw_shades = false,
      use_xft = true,
      font = 'DejaVu Sans Mono:size=10',
      gap_x = 40,
      gap_y = 60,
      minimum_height = 5,
      minimum_width = 5,
      net_avg_samples = 2,
      no_buffers = true,
      out_to_console = false,
      out_to_stderr = false,
      out_to_x = false,
      out_to_wayland = true,
      extra_newline = false,
      own_window = true,
      own_window_class = 'Conky',
      own_window_type = 'override',
      own_window_transparent = true,
      own_window_argb_visual = true,
      own_window_argb_value = 0,
      own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',
      stdenv_graph_size = '25,150',
      update_interval = 1.0,
      uppercase = false,
      use_spacer = 'none',
      show_graph_scale = false,
      show_graph_range = false,
    }

conky.text = [[
''${color #cba6f7}SYSTEM ''${hr}
''${color #f5c2e7}Hostname:''${color} $nodename
''${color #f5c2e7}Kernel:  ''${color} $kernel
''${color #f5c2e7}Uptime:  ''${color} $uptime

''${color #cba6f7}CPU ''${hr}
''${color #f5c2e7}Usage:''${color} $cpu% ''${color #f5c2e7}Freq:''${color} $freq_g GHz
''${cpugraph 25,250 f5c2e7 cba6f7}

''${color #cba6f7}MEMORY ''${hr}
''${color #f5c2e7}RAM:''${color} $mem / $memmax ''${alignr}$memperc%
''${membar 6}
''${color #f5c2e7}SWAP:''${color} $swap / $swapmax ''${alignr}$swapperc%
''${swapbar 6}

''${color #cba6f7}STORAGE ''${hr}
''${color #f5c2e7}Root:''${color} ''${fs_used /} / ''${fs_size /} ''${alignr}''${fs_used_perc /}%
''${fs_bar 6 /}
''${color #f5c2e7}Home:''${color} ''${fs_used /home} / ''${fs_size /home} ''${alignr}''${fs_used_perc /home}%
''${fs_bar 6 /home}

''${color #cba6f7}TOP PROCESSES ''${hr}
''${color #f5c2e7}''${top name 1} ''${alignr}''${top cpu 1}%
''${color}''${top name 2} ''${alignr}''${top cpu 2}%
''${color}''${top name 3} ''${alignr}''${top cpu 3}%
''${color}''${top name 4} ''${alignr}''${top cpu 4}%

''${color #cba6f7}NETWORK (''${exec ip route show default | awk '/default/ {print $5; exit}'}) ''${hr}
''${color #f5c2e7}Local IP:''${color} ''${alignr}''${addrs ''${exec ip route show default | awk '/default/ {print $5; exit}'}}
''${color #f5c2e7}Down:''${color} ''${downspeed ''${exec ip route show default | awk '/default/ {print $5; exit}'}} ''${alignr}''${color #f5c2e7}Up:''${color} ''${upspeed ''${exec ip route show default | awk '/default/ {print $5; exit}'}}
''${downspeedgraph ''${exec ip route show default | awk '/default/ {print $5; exit}'} 25,250 f5c2e7 cba6f7}
]]
    '';

  };

  systemd.user.services.conky.Service = {
    KillSignal = "SIGKILL";
    Restart = lib.mkForce "on-failure";
  };
}
