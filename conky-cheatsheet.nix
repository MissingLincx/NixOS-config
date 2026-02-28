{ pkgs, lib, ... }:
{
  systemd.user.services.conky-cheatsheet = {
    Unit = { Description = "Vim/NixOS Cheatsheet Conky"; };
    Install = { WantedBy = [ "graphical-session.target" ]; };
    Service = {
      ExecStart = "${pkgs.conky}/bin/conky -c ${pkgs.writeText "cheatsheet.conf" ''
        conky.config = {
            alignment = 'top_left',
            gap_x = 40,
            gap_y = 40,
            draw_shades = false,
            draw_outline = false,
            draw_borders = false,
            draw_graph_borders = true,
            font = 'DejaVu Sans Mono:size=10',
            own_window = true,
            own_window_type = 'override',
            own_window_transparent = true,
            double_buffer = true,
            use_xft = true,
            default_color = '#f5c2e7',
            out_to_wayland = true,
            update_interval = 84600,
            total_run_times = 0,
            cpu_avg_samples = 1,
            net_avg_samples = 1,
        }
        conky.text = [[
        ''${color #cba6f7}NIXOS COMMANDS ''${hr}
        ''${color #f5c2e7}rebuild   ''${color} sudo nixos-rebuild switch
        ''${color #f5c2e7}upgrade   ''${color} nix flake update
        ''${color #f5c2e7}cleanup   ''${color} nix-collect-garbage -d
        ''${color #f5c2e7}search    ''${color} nix search nixpkgs [pkg]

        ''${color #cba6f7}VIM FOR NANO USERS ''${hr}
        ''${color #f5c2e7}i / Esc   ''${color} Enter / Exit Insert mode
        ''${color #f5c2e7}:wq       ''${color} Save and Quit (like Ctrl+O, Ctrl+X)
        ''${color #f5c2e7}:q!       ''${color} Force Quit (Discard changes)
        ''${color #f5c2e7}v + arrow ''${color} Select text (Visual mode)
        ''${color #f5c2e7}y / p     ''${color} Copy (Yank) / Paste
        ''${color #f5c2e7}dd / dw   ''${color} Delete Line / Delete Word
        ''${color #f5c2e7}w / b     ''${color} Jump Word forward / back
        ''${color #f5c2e7}0 / $     ''${color} Start / End of line
        ''${color #f5c2e7}A         ''${color} Append at end of line
        ''${color #f5c2e7}cw        ''${color} Change word (delete + Insert)

        ''${color #cba6f7}CLI TOOLS ''${hr}
        ''${color #f5c2e7}grep -r   ''${color} Recursive search
        ''${color #f5c2e7}ps aux    ''${color} Show all processes
        ''${color #f5c2e7}chmod +x  ''${color} Make file executable
        ''${color #f5c2e7}!!        ''${color} Run last command as sudo
        ]]
      ''}";
    };
  };
}
