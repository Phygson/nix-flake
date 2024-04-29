{
  lib,
  config,
  pkgs,
  ...
}: {
  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      position = "top";
      height = 30;
      output = [
        "eDP-1"
        "HDMI-A-1"
      ];

      modules-left = ["hyprland/workspaces"];
      modules-center = ["hyprland/window"];
      modules-right = ["hyprland/language" "custom/notification"];

      "hyprland/workspaces" = {
        format = "{icon}";
        format-icons = {
          "1" = "";
          "2" = "󰈹";
          "3" = "";
          "4" = "";
          active = "";
          default = "";
        };
        persistent-workspaces = {
          "*" = 9;
        };
      };

      "hyprland/language" = {
        format = "{}";
        format-en = "🇺🇸";
        format-ru = "🇷🇺";
        on-click = "hyprctl switchxkblayout gaming-keyboard next";
      };

      "hyprland/window" = {
        format = "{}";
        rewrite = {
          "(.*) — Mozilla Firefox" = "󰈹  $1 󰈹 ";
          "(.*) - fish" = "󰈺  [$1]";
          "(.*) - VSCodium" = "  $1  ";
        };
        separate-outputs = true;
      };

      "custom/notification" = {
        tooltip = false;
        format = "{icon}";
        format-icons = {
          notification = "<span foreground='red'><sup></sup></span>";
          none = "";
          dnd-notification = "<span foreground='red'><sup></sup></span>";
          dnd-none = "";
          inhibited-notification = "<span foreground='red'><sup></sup></span>";
          inhibited-none = "";
          dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
          dnd-inhibited-none = "";
        };
        return-type = "json";
        exec-if = "which swaync-client";
        exec = "swaync-client -swb";
        on-click = "swaync-client -t -sw";
        on-click-right = "swaync-client -d -sw";
        escape = true;
      };
    };
  };
}
