# just es un ejecutor de comandos; Justfile es muy parecido a Makefile, pero más simple.

############################################################################
#
#  Commandos de Nix relacionados con la máquina local
#
############################################################################

# HOSTNAME := env_var('HOST')
HOSTNAME := `hostname`
# HOSTNAME := `cat /etc/hostname 2>/dev/null || echo "localhost"`

deploy:
  nixos-rebuild switch --flake .#{{HOSTNAME}} --elevate=sudo

debug:
  nixos-rebuild switch --flake .#{{HOSTNAME}} --elevate=sudo --show-trace --verbose

up:
  nix flake update

# Actualizar un input específico
# uso: make upp i=home-manager
upp:
  nix flake update $(i)

history:
  nix profile history --profile /nix/var/nix/profiles/system

repl:
  nix repl -f flake:nixpkgs

clean:
  # elimina todas las generaciones con más de 7 días
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

gc:
  # recolecta como basura todas las entradas sin usar del store de nix
  sudo nix-collect-garbage --delete-old

