# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  nix-software-center = import (pkgs.fetchFromGitHub {
    owner = "vlinkz";
    repo = "nix-software-center";
    rev = "0.1.2";
    sha256 = "xiqF1mP8wFubdsAQ1BmfjzCgOD3YZf7EGWl9i69FTls=";
  }) {};
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";
  environment.shells = [ pkgs.fish ];

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };
#allow insecure packages
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1v"
  ];
  # Enable CUPS to print documents.
  services.printing.enable = true;
  programs.fish.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  # hardware.nvidia.package = (config.boot.kernelPackages.nvidiaPackages.stable.overrideAttrs {
  #   src = pkgs.fetchurl {
  #     url = "https://download.nvidia.com/XFree86/Linux-x86_64/470.199.02/NVIDIA-Linux-x86_64-470.199.02.run";
  #     sha256 = "1zb8swlb8f1l9l6bya64fwd12pk9z0x1lqj2bg1k5khivw721y7x";
  #   };
  # });

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rogernix = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "rogernix";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # kate
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    firefox
    # ollama
    baobab
    # cudaPackages_12_2.cudatoolkit
    # libayatana-appindicator
    polybar
    # distrobox
#     vscode
    nix-software-center
    # git
#   vscode-extensions.rust-lang.rust-analyzer
#   rust-analyzer
    nvidia-system-monitor-qt
    nvitop
    nvidia-podman
    vscodium
    gparted
    gcc gdb
    # pkg-config
    # webkitgtk
#     mailspring
    wget
    lm_sensors
    jetbrains-toolbox
    microsoft-edge
    # fish
#     chromium
#     quota
    github-desktop
    linuxquota
    telegram-desktop
    # ollama
  ];
  programs.git = {
  enable = true;
  package = pkgs.gitFull;
  config.credential.helper = "libsecret";
};
services.ollama = {
    enable = true;
    acceleration = "cuda";
  };
# programs.nix-ld.enable = true;
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
  system.stateVersion = "23.11"; # Did you read the comment?

  # services.envfs.enable = true;
  programs.nix-ld.enable = true;
  # https://github.com/Mic92/dotfiles/blob/main/nixos/modules/nix-ld.nix
  programs.nix-ld.libraries = with pkgs; [
    # alsa-lib
    # at-spi2-atk
    # at-spi2-core
    # atk
    # cairo
    # cups
    curl
    # dbus
    # expat
    # fontconfig
    # freetype
    # fuse3
    # gdk-pixbuf
    # glib
    # gtk3
    # icu
    # libGL
    libappindicator-gtk3
    # libdrm
    # libglvnd
    # libnotify
    # libpulseaudio
    # libunwind
    # libusb1
    # libuuid
    # libxkbcommon
    # libxml2
    # mesa
    # nspr
    # nss
    # openssl
    # pango
    # pipewire
    # stdenv.cc.cc
    # systemd
    # vulkan-loader
    # xorg.libX11
    # xorg.libXScrnSaver
    # xorg.libXcomposite
    # xorg.libXcursor
    # xorg.libXdamage
    # xorg.libXext
    # xorg.libXfixes
    # xorg.libXi
    # xorg.libXrandr
    # xorg.libXrender
    # xorg.libXtst
    # xorg.libxcb
    # xorg.libxkbfile
    # xorg.libxshmfence
    # zlib
  ];

}
