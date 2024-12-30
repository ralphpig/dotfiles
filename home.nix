{
  lib,
  config,
  pkgs,
  ...
}:
with lib.hm.gvariant; {
  programs.home-manager.enable = true;

  home.username = "ralphpig";
  home.homeDirectory = "/home/ralphpig";

  home.packages = with pkgs; [
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    gnomeExtensions.vitals
  ];

  home.file = with config.lib.file; {
    ".config/sublime-text/Packages/User" = {
      source = mkOutOfStoreSymlink .config/sublime-text/Packages/User;
    };
    ".config/sublime-merge/Packages/User" = {
      source = mkOutOfStoreSymlink .config/sublime-merge/Packages/User;
    };
    ".config/zed" = {
      source = mkOutOfStoreSymlink .config/zed;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Programs
  programs.git = {
    enable = true;
    userEmail = "mail@ralphpig.dev";
    userName = "Mike";
    extraConfig = {
      safe.directory = "*";
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      set shiftwidth=2 smarttab
      set expandtab
      set tabstop=8 softtabstop=0
    '';
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
    };
    historySubstringSearch = {
      enable = true;
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
      theme = "ys";
    };

    shellAliases = {
      cpwd = "pwd | tee >(wl-copy)";
    };
  };

  # dconf
  dconf.settings = {
    # Appearance
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      clock-show-weekday = true;
      clock-show-seconds = true;
      clock-format = "12h";
      accent-color = "red";
    };
    "org/gnome/desktop/datetime" = {
      automatic-timezone = true;
    };
    "org/gtk/settings/file-chooser" = {
      clock-format = "12h";
    };
    "org/gnome/mutter" = {
      workspaces-only-on-primary = true;
    };
    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 10;
    };
    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };

    ## Wallpaper
    "org/gnome/desktop/background" = {
      picture-uri = "file:///home/ralphpig/dotfiles/wallpapers/nord/mountain-dark.jpg";
      picture-uri-dark = "file:///home/ralphpig/dotfiles/wallpapers/nord/mountain-dark.jpg";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };
    "org/gnome/desktop/screensaver" = {
      picture-uri = "file:///home/ralphpig/dotfiles/wallpapers/nord/mountain-dark.jpg";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/shell" = {
      last-selected-power-profile = "performance";
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "org.gnome.Console.desktop"
        "dev.zed.Zed.desktop"
        "sublime_text.desktop"
        "sublime_merge.desktop"
        "insomnia.desktop"
        "microsoft-edge.desktop"
        "spotify.desktop"
        # PWAs; Should have same app-id, but not sure
        "msedge-jnpecgipniidlgicjocehkhajgdnjekh-Default.desktop" # Protonmail
        "msedge-agimnkijcaahngcdmfeangaknmldooml-Default.desktop" # Youtube
        "msedge-ifpboanaelncmlfhjbnnloipmogocahb-Default.desktop" # Workflowy
        "msedge-cifhbcnohmdccbgoicgdjpfamggdegmo-Default.desktop" # Teams
      ];

      # Extensions
      disable-user-extensions = false;
      enabled-extensions = [
        "places-menu@gnome-shell-extensions.gcampax.github.com"
        "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
        "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
        "Vitals@CoreCoding.com"
      ];
    };

    # Extension Config
    "org/gnome/shell/extensions/vitals" = {
      hot-sensors = [
        "_processor_usage_"
        "_memory_usage_"
        "_storage_free_"
        "_memory_swap_usage_"
      ];
    };

    # Not used
    "org/gnome/shell/extensions/system-monitor" = {
      show-upload = false;
      show-download = false;
    };

    # Display
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-from = mkDouble 17.0;
      night-light-schedule-to = mkDouble 6.0;
      night-light-temperature = mkUint32 3700;
    };

    # Keyboard
    "org/gnome/desktop/peripherals/keyboard" = {
      delay = mkUint32 200;
      repeat-interval = mkUint32 30;
    };

    # Keybindings
    # "org/gnome/desktop/input-sources" = {
    #  xkb-options = ["altwin:swap_alt_win"]; # Swap Super to Alt
    # };

    "org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-left = ["<Super>a"];
      switch-to-workspace-right = ["<Super>d"];
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      switch-to-workspace-5 = ["<Super>5"];
      switch-to-workspace-6 = ["<Super>6"];
      switch-to-workspace-7 = ["<Super>7"];
      switch-to-workspace-8 = ["<Super>8"];
      switch-to-workspace-9 = ["<Super>9"];

      close = ["<Shift><Super>q"];
    };
    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [];
      switch-to-application-2 = [];
      switch-to-application-3 = [];
      switch-to-application-4 = [];
      switch-to-application-5 = [];
      switch-to-application-6 = [];
      switch-to-application-7 = [];
      switch-to-application-8 = [];
      switch-to-application-9 = [];
    };

    "org/gnome/mutter/keybindings" = {
      # disable <Super>p display type switching
      switch-monitor = ["XF86Display"];
    };

    # Custom Keybinds
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Open Terminal";
      binding = "<Super>Return";
      command = "kgx";
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.
}
