# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
let 
  #nixvim = import (builtins.fetchGit {
    #url = "https://github.com/nix-community/nixvim";
    #ref = "nixos-23.11";
    #});
  # home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz";
  # stylix = pkgs.fetchFromGithub {
  #   owner = "danth";
  #   repo = "stylix";
  #   rev = "...";
  #   sha256 = "...";
  # };
  # stylix = builtins.fetchGit {
  #   url = "https://github.com/danth/stylix";
  # };
in
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  imports =
    [ # Include the results of the hardware scan.
      # (import stylix).homeManagerModules.stylix
      ./hardware-configuration.nix
      # inputs.home-manager.nixosModules.default
      # (import "${home-manager}/nixos")
      # nixvim.nixosModules.nixvim
      ./emacs/emacs.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nixos-laptop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  

  security.polkit.enable = true;
  
  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Enable xdg portal
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
  };
  # Enable flatpak.
  services.flatpak.enable = true;
  services.greetd = {
    enable = true;
    # package = pkgs.greetd.tuigreet;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "gerald";
      };
    };
  };

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      amdvlk
    ]; 
    #extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
  };
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;


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
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gerald = {
    isNormalUser = true;
    description = "gerald";
    extraGroups = [ "networkmanager" "wheel" "input" "git" ];
    packages = with pkgs;
    let
    customR = rWrapper.override{ packages = with rPackages;
    [ 
      ggplot2
      tidyverse
      psych
    ];};
    in
    [
      # Essentials: Browser, editor, terminal, WM, etc.
      firefox
      chromium
      tor-browser
      # i3
      # i3ipc-glib
      grim
      slurp
      wl-clipboard
      mako
      nitrogen
      feh
      sway-launcher-desktop
      unzip
      picom
      git
      ripgrep
      discord
      element-desktop
      nordic
      papirus-nord
      rose-pine-gtk-theme
      rose-pine-icon-theme

      # Wacky terminal apps
      neofetch
      gotop
      lf
      fzf
      srm

      # Productivity or whatever
      cura
      pandoc
      zathura
      #texliveSmall
      texliveFull
      libreoffice-fresh

      # Development
      godot_4
      customR
      elixir
      elixir-ls
      marksman
      nixd
      python3
      python311Packages.python-lsp-server
      # python2
      gnumake
      gcc
      #guix # Wait, what? You can do that?

      # Multimedia
      youtube-dl
      mpv
      obs-studio
      libsForQt5.kdenlive
      pavucontrol
      ffmpeg
      musescore
      cmus
      audacity

      # Gaming?
      lutris
      # Imaging, partitioning, etc.
      rpi-imager
      gparted
      gnome.gnome-disk-utility
    ];
  };
  stylix = {
      enable = true;
      image = ./assets/nix_background.png;
      fonts = {
        monospace = {
          package = pkgs.nerdfonts;
          name = "Hack Nerd Font";
        };
        sansSerif = {
          package = pkgs.nerdfonts;
          name = "Arimo Nerd Font";
        };
      };
      
      autoEnable = true;
      targets.gtk.enable = true;
      base16Scheme = {
        base00 = "170c04";
        base01 = "330000";
        base02 = "2f1f13";
        base03 = "b36624";
        base04 = "eab15e";
        base05 = "ff8400";
        base06 = "e69532";
        base07 = "c9bf28";
        base08 = "bf6300";
        base09 = "4d301c";
        base0A = "4e3103";
        base0B = "b35900";
        base0C = "eb9c24";
        base0D = "bb6c3b";
        base0E = "e65c17";
        base0F = "c9a005";
      };
  };
  home-manager.users.gerald = {
    home.stateVersion = "24.05";
    wayland.windowManager.sway = {
      enable = true;
      extraConfig = ''
      for_window [title="Launcher"] floating enable
      '';
      config = rec {
        input = {
          "*" = {xkb_layout = "de";};
        };
        modifier = "Mod4";
        terminal = "alacritty";
        # menu = "alacritty -e sway-launcher-desktop --class floating";
        menu = "exec alacritty -t Launcher -e sway-launcher-desktop";
        keybindings = lib.mkOptionDefault {
          # "${modifier}+d" = "exec alacritty -t Launcher -e sway-launcher-desktop";
          "${modifier}+Shift+s" = ''exec "slurp | grim -g - - | wl-copy"'';
          "${modifier}+Control+1" = "move container to workspace number 1; workspace number 1";
          "${modifier}+Control+2" = "move container to workspace number 2; workspace number 2";
          "${modifier}+Control+3" = "move container to workspace number 3; workspace number 3";
          "${modifier}+Control+4" = "move container to workspace number 4; workspace number 4";
          "${modifier}+Control+5" = "move container to workspace number 5; workspace number 5";
          "${modifier}+Control+6" = "move container to workspace number 6; workspace number 6";
          "${modifier}+Control+7" = "move container to workspace number 7; workspace number 7";
          "${modifier}+Control+8" = "move container to workspace number 8; workspace number 8";
          "${modifier}+Control+9" = "move container to workspace number 9; workspace number 9";
          "${modifier}+Control+0" = "move container to workspace number 10; workspace number 10";
        };
        startup = [
          {command = "nitrogen --restore";}
        ];
        gaps = {
          outer = -10;
          inner = 10;
        };
        bars = [
          {
            # fonts = {
              # size = 15.0;
            #   names = [ "Terminess Nerd Font Mono" ];
            # };
            position = "top";
            command = "waybar";
          }
        ];
        colors = rec {
          focused.border = lib.mkForce "${config.stylix.base16Scheme.base07}";
          
          unfocused.border = lib.mkForce "${config.stylix.base16Scheme.base09}";
          # focusedInactive.border = lib.mkForce unfocused.border;
          focusedInactive.border = lib.mkForce "${config.stylix.base16Scheme.base09}";
        };
      };
    };
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          position = "left";
          width = 40;
          modules-left = [
            "sway/workspaces"
            "sway/mode"
          ];
          modules-center = [
            "sway/window"
          ];
          modules-right = [
            # "cpu"
            "custom/label-memory"
            "memory"
            "custom/label-disk"
            "disk"
            "battery"
            "pulseaudio/slider"
            "clock"
            "tray"
          ];
          
          "sway/window" = {
            rotate = 90;
            format = "{title}";
          };
          
          # "cpu" = {
          #   format = " CPU \n {}%\n";
          # };
          
          "custom/label-memory" = {
            format = "MEM";
          };
          "memory" = {
            interval = 30;
            format = "{used:0.1f}GB\n";
          };
          "custom/label-disk" = {
            format = "DISK";
          };
          "disk" = {
            path = "/";
            format = "{specific_used:0.0f}GB";
            unit = "GB";
          };
            
        };
      };
      style = ''
      * {
        font-size: 20px;
        font-family: Terminess Nerd Font Mono;
      }
      
      '';
    };
    programs.swaylock.enable = true;
    programs.mako.enable = true;
    programs.alacritty = {
      enable = true;
      settings = {
        font.normal.family = lib.mkForce "Terminess Nerd Font Mono";
        font.size = lib.mkForce 15;
        window.opacity = lib.mkForce 0.9;
      };
    };
    programs.neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
	      rose-pine
	      nord-nvim
	      alpha-nvim
	      telescope-nvim
	      nvim-tree-lua
	      tabular
	      nvim-dap
	      nvim-web-devicons
	      vim-suda  
	      mkdnflow-nvim
	      lualine-nvim
	      luasnip
	      nvim-treesitter
	      nvim-cmp
	      cmp_luasnip
	      cmp-nvim-lsp
	      nvim-lspconfig
	      nvim-treesitter.withAllGrammars
      ];
    };
  };

  programs.dconf.enable = true;
  programs.gnupg.agent = {
    enable = true;
  #   enableSSHSupport = true;
  };

  programs.bash = {
    shellAliases = {
      nixcfg = "sudo nvim /etc/nixos/configuration.nix";
      nixrecfg = "sudo nixos-rebuild switch";
      encrypt-secrets = "gpgtar --encrypt --symmetric --gpg-args --no-symkey-cache --output Secrets.gpgtar Secrets.gpgtar_1_ && srm -r Secrets.gpgtar_1_";
      decrypt-secrets = "gpgtar --decrypt --gpg-args --no-symkey-cache --output Secrets Secrets.gpgtar && srm -r Secrets.gpgtar";
    };
    promptInit = ''
      PS1="\[\033[01;32m\]\u \[\033[00m\]\[\033[02;37m\] \w \[\033[00m\] \[\033[01;36m\]» \[\033[00m\]"
    '';
  };

  programs.nix-ld.enable = true; 

  # Allow unfree packages
  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ "nix-2.16.2" "python-2.7.18.7" ];
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # neovim
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    basez
    wget
    killall
    ntfs3g
    xfce.xfce4-i3-workspaces-plugin
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-panel-profiles
    xfce.xfce4-pulseaudio-plugin
    libgcc
    xclip
    libsForQt5.breeze-icons
    lightdm-slick-greeter
    gst_all_1.gstreamer
    gst_all_1.gst-libav
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
  ];

  fonts.packages = with pkgs; [
    nerdfonts
  ];  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  #programs.steam = {
    #enable = true;
    #remotePlay.openFirewall = true;
    #dedicatedServer.openFirewall = true;
  #};

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

}
