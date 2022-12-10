{% if (grains.os) == 'Windows'%}
"echo Hello %COMPUTERNAME%!":
  cmd.run
{% else %}
"echo Hello $(hostname)!":
  cmd.run
{% endif %}
