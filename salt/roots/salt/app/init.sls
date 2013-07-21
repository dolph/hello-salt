gunicorn:
  pkg:
    - installed

python-gevent:
  pkg:
    - installed

python-git:
  pkg:
    - installed

supervisor:
  pkg:
    - installed
  service:
    - running
    - require:
      - pkg: supervisor
    - watch:
      - file: supervisord_conf

supervisord_conf:
  file.managed:
    - name: /etc/supervisord.conf
    - source: salt://app/supervisord.conf

app:
  git.latest:
    - name: {{ pillar['git_repo'] }}
    - rev: {{ pillar['git_rev'] }}
    - target: /var/www/hello/
    - force: true
