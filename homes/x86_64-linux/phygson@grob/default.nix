{pkgs, ...}: {
  home = {
    username = "phygson";
    homeDirectory = "/home/phygson";
  };

  home.packages = with pkgs; [
    swaynotificationcenter
    hicolor-icon-theme
    unstable._64gram
    qbittorrent
    ruffle
    libreoffice-fresh
    hunspellDicts.ru-ru
    libqalculate
    mpv
    swww
    waypaper
    unstable.obsidian
    any-nix-shell
    (nerdfonts.override {fonts = ["FiraCode" "DroidSansMono"];})
    unstable.vesktop
    whatsapp-for-linux
    yandex-disk
    eza
    bat
  ];

  z.grimblast.enable = true;

  z.gtklock = {
    enable = true;
    pkgsInstance = pkgs.master;
    hyprland = {
      enable = true;
      enablePowerbarModule = true;
      mod = "SUPER";
      key = "L";
    };
  };

  z.prismlauncher = {
    enable = true;
    enableWayland = true;
    javaPackages = with pkgs; [
      temurin-jre-bin-8
      temurin-jre-bin-17
      master.temurin-jre-bin-21
    ];
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium.fhsWithPackages (ps: [
      pkgs.nixd
    ]);
    mutableExtensionsDir = true;
    enableExtensionUpdateCheck = false;
    extensions = with pkgs.unstable.vscode-extensions; [
      jnoortheen.nix-ide
      kamadorueda.alejandra
      llvm-vs-code-extensions.vscode-clangd
      mkhl.direnv
      jdinhlife.gruvbox
      haskell.haskell
      justusadam.language-haskell
    ];
    userSettings = {
      "editor.fontFamily" = "'FiraCode Nerd Font Mono'";
      "editor.fontLigatures" = true;
      "terminal.integrated.shellIntegration.enabled" = false;
      "terminal.integrated.defaultProfile.linux" = "fish";
      "terminal.integrated.cursorStyle" = "line";
      "terminal.explorerKind" = "integrated";
      "terminal.integrated.cursorBlinking" = true;
      "terminal.integrated.shellIntegration.decorationsEnabled" = "never";
      "workbench.colorTheme" = "Default Dark Modern";
      "[cpp]" = {
        "editor.defaultFormatter" = "llvm-vs-code-extensions.vscode-clangd";
      };
      "editor.formatOnSave" = true;
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";
      "nix.serverSettings" = {
        "nixd" = {
          "formatting" = {
            "command" = ["nix fmt"];
          };
          "options" = {
            "nixos" = {
              "expr" = "(builtins.getFlake \"/etc/nixos/nix-flake\").nixosConfigurations.grob.options";
            };
            "home-manager" = {
              "expr" = "(builtins.getFlake \"/etc/nixos/nix-flake\").homeConfigurations.\"phygson@grob\".options";
            };
          };
        };
      };
    };
  };

  xdg.enable = true;
  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;
  xdg.desktopEntries = {
    waypaper = {
      name = "waypaper";
      exec = "waypaper";
      terminal = false;
    };
  };

  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox.enable = true;
    plugins = {
      nix.enable = true;
      chadtree.enable = true;
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  gtk.enable = true;
  gtk.theme = {
    name = "Adwaita-dark";
    package = pkgs.gnome.gnome-themes-extra;
  };
  gtk.iconTheme.package = pkgs.moka-icon-theme;
  gtk.iconTheme.name = "Moka";

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.git.extraConfig.core.editor = "nvim";
  programs.gh.enable = true;
  programs.firefox.enable = true;

  programs.bash.enable = true;
  programs.fzf.enable = true;
  programs.fish = {
    enable = true;
    shellAliases = {
      gacp = "git add -A && git commit && git push";
      gacmp = "git add -A && git commit --amend && git push -f";
      gd = "git diff HEAD";
      gs = "git status";
      ga = "git add -A";
      l = "eza -l --icons --git";
      la = "l -a";
    };
    interactiveShellInit = ''
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
    '';
    plugins = with pkgs.fishPlugins; [
      {
        name = "pure";
        src = pure.src;
      }

      {
        name = "fzf.fish";
        src = fzf-fish.src;
      }
    ];
  };
  #programs.command-not-found.enable = true;
  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    settings.shell = "fish";
    settings.font_family = "FiraCode Nerd Font Mono";
    theme = "Gruvbox Dark";
  };

  programs.wofi.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.11";
}
