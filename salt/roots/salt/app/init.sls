app_packages:
  pkg.installed:
    - names:
      - gunicorn
      - python-gevent

supervisor:
  pkg:
    - installed
  service:
    - running
    - require:
      - pkg: supervisor
      - pkg: app_packages
      - git: git_repo
    - watch:
      - file: supervisor_conf

supervisor_conf:
  file.managed:
    - name: /etc/supervisor/conf.d/hello.conf
    - source: salt://app/supervisor.conf

git_repo:
  pkg.installed:
    - names:
      - git
  git.latest:
    - require:
      - pkg: git
    - name: {{ pillar['git_repo'] }}
    - rev: {{ pillar['git_rev'] }}
    - target: /var/www/hello/
    - force: true
