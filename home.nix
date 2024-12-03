{ lib, config, pkgs, ... }:

with lib.hm.gvariant;
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ralphpig";
  home.homeDirectory = "/home/ralphpig";

  programs.git = {
    enable = true;
    userEmail = "mail@ralphpig.dev";
    userName = "Mike";
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    # ".zshrc".source = ./.zshrc;
    # ".profile".source = ./.profile;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ralphpig/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = {
  	enable = true;
  	enableCompletion = true;
  	autosuggestion.enable = true;
  	syntaxHighlighting.enable = true;

	history = {
    		size = 10000;
  	};

	oh-my-zsh = {
  		enable = true;
    		plugins = [
			"git"
		];
    		theme = "ys";
  	};
  };

  # dconf
  dconf.settings =  {
	# GNOME
	"org/gnome/desktop/interface" = {
		color-scheme = "prefer-dark";
		clock-show-weekday = true;
		clock-show-seconds = true;
		clock-format = "12h";
	};

	"org/gnome/mutter" = {
		workspaces-only-on-primary = true;
	};

	"org/gnome/desktop/wm/preferences" = {
		num-workspaces = 10;
	};

	"org/gnome/desktop/input-sources" = {
		xkb-options = ["altwin:swap_alt_win"]; # Swap Super to Alt
	};

	"org/gnome/desktop/datetime" = {
		automatic-timezone = true;
	};
   	"org/gnome/shell" = {
		last-selected-power-profile = "performance";
		favorite-apps = [
  			"org.gnome.Nautilus.desktop"
			"org.gnome.Console.desktop"
			"microsoft-edge.desktop"
			"sublime_text.desktop"
			"sublime_merge.desktop"
		];

		
		# Extensions
		disable-user-extensions = false;
		enabled-extensions = [
			"places-menu@gnome-shell-extensions.gcampax.github.com"
			"drive-menu@gnome-shell-extensions.gcampax.github.com"
			"system-monitor@gnome-shell-extensions.gcampax.github.com"
			"workspace-indicator@gnome-shell-extensions.gcampax.github.com"
			"windowsNavigator@gnome-shell-extensions.gcampax.github.com"
      		];
	};

	# Keyboard
	"org/gnome/desktop/peripherals/keyboard" = {
		delay = (mkUint32 200);
		repeat-interval = (mkUint32 30);
	};

	# Keybindings
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

	"org/gnome/shell/extensions/system-monitor" = {
		show-upload = false;
		show-download = false;
	};

	# GTK
	"org/gtk/settings/file-chooser" = {
		clock-format = "12h";
	};
  };
}
