needed_packages:
  pkg.installed:
    - pkgs:
# Dependency
      - software-properties-common
# Basic
      - micro
      - git
      - libreoffice
# Android Development
      - adb
      - android-sdk-platform-tools
# Networking Debug
      - usbutils
      - dnsutils
      - net-tools
      - curl
      - net-tools
      - nmap
# Security
      - pwgen

# BUG IN SALT: https://github.com/saltstack/salt/issues/59065
#  pkgrepo.managed:
#    - name: ppa:mozillateam/ppa
#    - dist: precise
#    - file: /etc/apt/sources.list.d/mozillateam.list
# NOT WORKING AT THE MOMENT

# Workaround by: 
# https://github.com/miljonka/miniproject/blob/main/Starterpack/init.sls
add_firefox_repo:
  cmd.run:
    - name: sudo add-apt-repository -y ppa:mozillateam/ppa
    - creates: /etc/apt/sources.list.d/mozillateam-ubuntu-ppa-jammy.list

firefox:
  pkg.purged
  
firefox-esr:
  pkg.installed
