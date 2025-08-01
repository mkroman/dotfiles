{ config, pkgs, ... }:

{
  imports = [
    ./local.nix
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.act
    pkgs.actionlint
    pkgs.argo
    pkgs.argocd
    pkgs.bat
    pkgs.cargo-audit
    pkgs.cargo-binstall
    pkgs.cargo-outdated
    pkgs.cargo-release
    pkgs.chart-testing
    pkgs.cmake
    pkgs.delta
    pkgs.dive
    pkgs.doctl
    pkgs.eza
    pkgs.exiftool
    pkgs.fd
    pkgs.gh
    pkgs.git
    pkgs.git-lfs
    pkgs.kubectl
    pkgs.kubevirt
    pkgs.htop
    pkgs.hugo
    pkgs.jq
    pkgs.minikube
    pkgs.ncdu
    pkgs.neovim
    pkgs.nmap
    pkgs.nushell
    pkgs.postgresql
    pkgs.qrencode
    pkgs.rust-petname
    pkgs.reg
    pkgs.restic
    pkgs.ripgrep
    pkgs.socat
    pkgs.taskwarrior
    pkgs.opentofu
    pkgs.terraform-ls
    pkgs.tmux
    pkgs.wget
    pkgs.yadm
    pkgs.yarn
    pkgs.yq-go
    pkgs.zola
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
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/mk/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.go.enable = true;
  programs.direnv.enable = true;
}
