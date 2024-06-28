{ config, lib, pkgs, ... }:
#let 
#home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";
#in 
{
  home-manager.users.gerald = {
    services.emacs.enable = true;
    programs.emacs = {
      enable = true;
      package = pkgs.emacs29-pgtk;
      extraPackages = epkgs: [
        # Essentials
        epkgs.use-package
        epkgs.meow
        epkgs.doom-modeline
        epkgs.sudo-edit 
        epkgs.dashboard
        epkgs.transient
        epkgs.magit 

        # Themes and look
        epkgs.nord-theme
        epkgs.ef-themes
        epkgs.base16-theme
        epkgs.nerd-icons
        
        # Document authoring
        epkgs.olivetti
        epkgs.el-easydraw
        epkgs.sketch-mode
        epkgs.pdf-tools
        epkgs.org-fragtog 

        # Coding
        epkgs.elixir-mode
        epkgs.python-mode
        epkgs.nix-mode
        epkgs.ess

        # Autocomplete / LSP
        epkgs.eglot
        epkgs.yasnippet
        epkgs.company
        epkgs.flymake 
      ];
      extraConfig = (builtins.readFile ./init.el);
    };
  };
}
