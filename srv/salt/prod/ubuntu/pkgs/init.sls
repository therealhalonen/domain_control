needed_packages:
  pkg.installed:
    - pkgs:
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

install_firefox_esr:
  pkgrepo.managed:
    - name: ppa:mozillateam/ppa
    - dist: precise
    - file: /etc/apt/sources.list.d/mozillateam.list

firefox:
  pkg.purged
  
firefox-esr:
  pkg.installed
