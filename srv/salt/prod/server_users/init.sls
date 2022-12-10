sicki:
  user.present:
    - shell: /bin/bash
    - home: /home/sicki
    - password: {{ pillar['regular_pass'] }}

supreme:
  user.present:
    - password: {{ pillar['superior_pass'] }}
    - createhome: false
    - shell: /bin/bash
    - groups:
      - sudo
    - optional_groups:  
      - sambauser
      - www-data
