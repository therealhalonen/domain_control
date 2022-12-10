install_ssh:
  pkg.installed:
    - pkgs:
      - openssh-server
      - ssh
  
/etc/ssh/sshd_config:
  file.managed:
    - source: "salt://ssh/sshd_config"
   
ssh.service:
  service.running:
    - enable: True
    - reload: True
    - watch:
      - file: /etc/ssh/sshd_config
