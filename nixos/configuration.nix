# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/greetd/greetd.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Make some extra kernel modules available to NixOS
  boot.extraModulePackages = with config.boot.kernelPackages;
    [ v4l2loopback.out ];

  # Activate kernel modules (choose from built-ins and extra ones)
  boot.kernelModules = [
    # Virtual Camera
    "v4l2loopback"
    # Virtual Microphone, built-in
    "snd-aloop"
  ];

  # Set initial kernel module settings
  boot.extraModprobeConfig = ''
    # exclusive_caps: Skype, Zoom, Teams etc. will only show device when actually streaming
    # card_label: Name of virtual camera, how it'll show up in Skype, Zoom, Teams
    # https://github.com/umlaeute/v4l2loopback
    options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
  '';

  networking.hostName = "BigBoy"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # flakes enable
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    download-buffer-size = 8589934592;
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # mullvad service
  services.mullvad-vpn.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # bluetooth
  services.blueman.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # input method
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
      fcitx5-configtool
    ];
  };

  # environment variables
  environment.variables = {
  QT_IM_MODULE = "fcitx";
  XMODIFIERS = "@im=fcitx";
  XMODIFIER = "@im=fcitx";
  GLFW_IM_MODULE = "ibus";
};

  # Configure keymap in X11
  services.xserver = {
    videoDrivers = [ "nvidia" ];
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # variables
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  # hardware
  hardware = {
    graphics.enable = true;
    nvidia = {
      modesetting.enable = true;
      open = false;
    };
  };

  # desktop portal
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sho-kun = {
    isNormalUser = true;
    description = "shojo";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    useDefaultShell = true;
  };

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [ "olm-3.2.16" ];
  };

  # zsh
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
  pkgs.vim
  pkgs.wget
  pkgs.hyprland
  pkgs.waybar
  pkgs.dunst
  pkgs.libnotify
  pkgs.swww
  pkgs.rofi-wayland
  pkgs.networkmanagerapplet
  pkgs.nwg-look
  pkgs.bluez
  pkgs.bluetui
  pkgs.blueman
  pkgs.git
  pkgs.mpd
  pkgs.brightnessctl
  pkgs.mullvad-vpn
  pkgs.btop
  pkgs.greetd.greetd
  pkgs.greetd.tuigreet
  pkgs.ntfs3g
  pkgs.ipaexfont
  pkgs.ripgrep
  pkgs.fd
  pkgs.hyprcursor
  pkgs.android-tools
  pkgs.gnome-keyring
  pkgs.cmake
  pkgs.gnumake
  pkgs.gcc
  pkgs.libtool
  ];

  # fonts
  fonts.packages = with pkgs; [
    nerdfonts
    ipafont
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    fira-code
    fira-code-symbols
    ubuntu_font_family
    ipaexfont
    kochi-substitute
    ipafont
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

}

