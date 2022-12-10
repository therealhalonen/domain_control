apache2:
  pkg.installed

/var/www/html/index.html:
  file.managed:
    - source: salt://webserver/apache/www/index.html

/etc/apache2/mods-enabled/userdir.conf:
  file.symlink:
    - target: /etc/apache2/mods-available/userdir.conf

/etc/apache2/mods-enabled/userdir.load:
  file.symlink:
    - target: /etc/apache2/mods-available/userdir.load

apache2restart:
  service.running:
    - name: apache2
    - watch:
      - file: /etc/apache2/mods-enabled/userdir.conf
      - file: /etc/apache2/mods-enabled/userdir.load
