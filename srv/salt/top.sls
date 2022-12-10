# Base = Default = Production environment
prod:
# Applies to every machine in Base environment
  '*':
    - hello_all

# Applies to all Linux machines
  'kernel:Linux':
    - match: grain
    - update_systems

# Applies to every servers
  '*server*':
    - server_users
    - avahi
    - ssh

# Applies to only fileserver
  'fileserver':
    - fileserver.samba

# Applies to only webserver
  'webserver':
    - webserver.apache

# Applies to every Windows machines
  'os:Windows':
    - match: grain
    - win.apps

# Applies to every Ubuntu machines
  'os:Ubuntu':
    - match: grain
    - ubuntu.pkgs

# Development environment
#   Idea of this in the "future", is to test new states and configurations,
#   in dev environment, before merging them to production
dev:
# Applies to every development server
  'dev-server*':
    - hello_all

# Applies to Fedora development machine
  'dev-fedora-ws':
    - hello_all
# Applies to Ubuntu development machine
  'dev-ubuntu':
    - hello_all
#
