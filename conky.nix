# conky.nix
{ pkgs, ... }:

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
''${cpugraph 25,150 f5c2e7 cba6f7}

''${color #cba6f7}MEMORY ''${hr}
''${color #f5c2e7}RAM:''${color} $mem/$memmax - $memperc%
''${membar 6}

''${color #cba6f7}NETWORK (enp34s0) ''${hr}
''${color #f5c2e7}Down:''${color} ''${downspeed enp34s0} ''${color #f5c2e7} Up:''${color} ''${upspeed enp34s0}
''${downspeedgraph enp34s0 25,150 f5c2e7 cba6f7}
]]
    '';
  };
}
