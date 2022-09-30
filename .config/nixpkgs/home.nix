{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "flake";
  home.homeDirectory = "/home/flake";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    emacs
    mu
    zsh
    oh-my-zsh
  ];

  programs.zsh = {
	  enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    defaultKeymap = "emacs";
    oh-my-zsh = {
    	enable = true;
      plugins = [ "git" ];
    	theme = "robbyrussell";
    };
  };
#  programs.emacs = {
#    enable = true;
#  };
#  programs.mu.enable = true;
}
