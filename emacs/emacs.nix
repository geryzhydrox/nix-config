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
        epkgs.use-package
        epkgs.meow
        epkgs.doom-modeline
        epkgs.nord-theme
        epkgs.ef-themes
        epkgs.base16-theme
        epkgs.nerd-icons
        epkgs.sudo-edit 
        epkgs.dashboard
        epkgs.transient
        epkgs.magit 

        epkgs.el-easydraw
        epkgs.sketch-mode
        epkgs.pdf-tools
        epkgs.org-fragtog 

        epkgs.elixir-mode
        epkgs.python-mode
        epkgs.nix-mode
        epkgs.ess

        epkgs.eglot
        epkgs.yasnippet
        epkgs.company
        epkgs.flymake 
	      #epkgs.flycheck 
      ];
      extraConfig = (builtins.readFile ./init.el);
    };
  };
}
