pkg:
  module.run:
    - name: pkg.refresh_db

install_software:
  pkg.installed:
    - pkgs:
#      - chocolatey
      - libreoffice
# choco:
#   chocolatey.installed:
#     - name: office365business # NOT WORKING! 
