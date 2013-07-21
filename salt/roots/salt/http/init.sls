nginx:
  pkg:
    - installed
  service:
    - running
    - require:
      - pkg: nginx
    - watch:
      - file: nginxconf

nginxconf:
  file.managed:
    - name: /etc/nginx/nginx.conf
    - source: salt://http/nginx.conf
