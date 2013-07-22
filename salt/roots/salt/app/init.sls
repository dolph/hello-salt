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
      - git: app-repo
    - watch:
      - file: supervisor_conf

supervisor_conf:
  file.managed:
    - name: /etc/supervisor/conf.d/hello.conf
    - source: salt://app/supervisor.conf

app-repo:
  require:
   - pkg: app-packages
  git.latest:
    - name: {{ pillar['git_repo'] }}
    - rev: {{ pillar['git_rev'] }}
    - target: /var/www/hello/
    - force: true
