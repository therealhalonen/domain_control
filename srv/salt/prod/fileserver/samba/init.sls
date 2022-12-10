samba:
  pkg.installed

sambauser:
  user.present:
    - shell: /usr/sbin/nologin
  pdbedit.managed:
    - password: {{ pillar['samba_pass'] }}
    - password_hashed: True

/etc/samba/smb.conf:
  file.managed:
    - source: "salt://fileserver/samba/smb.conf"

smbd:
  service.running

/home/sambauser/NAS:
  file.directory:
    - user: sambauser
    - group: sambauser
    - file_mode: 644
    - dir_mode: 755
    - makedirs: True
#    - recurse:
    
