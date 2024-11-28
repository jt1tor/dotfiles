{ config, pkgs, ... }:

{
  home.username = "sho-kun";
  home.homeDirectory = "/home/sho-kun/";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  home.packages = [
    pkgs.kitty
    pkgs.mupdf
    pkgs.zathura
    pkgs.qbittorrent
    pkgs.grim
    pkgs.hyprshot
    pkgs.pom
    pkgs.hyprpicker
    pkgs.slurp
    pkgs.jq
    pkgs.wl-clipboard
    pkgs.libnotify
    pkgs.vesktop
    pkgs.yt-dlg
    pkgs.element-desktop
    pkgs.iamb
    pkgs.dijo
    pkgs.playerctl
    pkgs.yazi
    pkgs.ncmpcpp
    pkgs.mpv
    pkgs.librewolf
    pkgs.archivemount
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    XDG_PICTURES_DIR = "/home/titor/pics/scrots";
    HYPRSHOT_DIR = "/home/titor/pics/scrots";
  };

  programs = {
    # program enable stuff
    kitty.enable = true;
    pywal.enable = true;
    yt-dlp.enable = true;
    zathura.enable = true;
    jq.enable = true;
    emacs.enable = true;
    newsboat.enable = true;
    home-manager.enable = true;

    # zsh stuff
    zsh = {

      # zsh enable stuff
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      
      # zsh jp countdown
      initExtra = '' echo "$(( ( $(date -d "2025-12-01" +%s) - $(date +%s) ) / 86400 )) days left until the The Big Day" '';

      # zsh oh my zsh stuff
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "kardan";
      };

      # zsh shell aliases
      shellAliases = {
        eco = "cd nixos; sudo vim configuration.nix; cd ~/";
	eho = "cd nixos; sudo vim home.nix; cd ~/";
	hup = "cd nixos; home-manager switch --flake .; cd ~/";
	cup = "cd nixos; sudo nixos-rebuild switch --flake .; cd ~/";
	nixup = "cd ~/nixos; nix flake update; sudo nixos-rebuild switch --flake .; home-manager switch --flake .; cd ~/";
      };

      # zsh history
      history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };

      # zsh variables
      sessionVariables = {
	EDITOR = "vim";
      };
    };


  };

  # services
  services = {
    emacs.enable = true;
  };

  # dunst source file
  home.file."/.config/dunst/dunstrc".source = ./modules/dunst/dunstrc;

  # gtk source file
  home.file."/.config/gtk-3.0/settings.ini".source = ./modules/gtk-3.0/settings.ini;

  # hyprland source file
  home.file."/.config/hypr/hyprland.conf".source = ./modules/hypr/hyprland.conf;

  # kitty source file
  home.file."/.config/kitty/kitty.conf".source = ./modules/kitty/kitty.conf;

  # newsboat source file
  home.file."/.config/newsboat/config".source = ./modules/newsboat/config;

  # newsboat urls source file
  home.file."/.config/newsboat/urls".source = ./modules/newsboat/urls;

  # rofi source file
  home.file."/.config/rofi/config.rasi".source = ./modules/rofi/config.rasi;

  # waybar source file
  home.file."/.config/waybar/config".source = ./modules/waybar/config;

  # yazi source file
  home.file."/.config/yazi/yazi.toml".source = ./modules/yazi/yazi.toml;

  # yazi keymap source file
  home.file."/.config/yazi/keymap.toml".source = ./modules/yazi/keymap.toml;

  # iamb source file
  home.file."/.config/iamb/config.toml".source = ./modules/iamb/config.toml;

}

