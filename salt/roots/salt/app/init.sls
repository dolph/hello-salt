app-packages:
  pkg.installed:
    - names:
      - python-git
      - gunicorn
      - python-gevent

supervisor:
  pkg:
    - installed
  service:
    - running
    - require:
      - pkg: supervisor
      - pkg: app-packages
    - watch:
      - file: supervisord_conf

supervisord_conf:
  file.managed:
    - name: /etc/supervisord.conf
    - source: salt://app/supervisord.conf

app:
  require:
   - pkg: app-packages
  git.latest:
    - name: {{ pillar['git_repo'] }}
    - rev: {{ pillar['git_rev'] }}
    - target: /var/www/hello/
    - force: true
