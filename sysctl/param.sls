{% from "sysctl/map.jinja" import sysctl_settings with context %}

{% for param, setting in salt['pillar.get']('sysctl:params', {}).iteritems() %}
sysctl_present_{{ param }}:
  sysctl.present:
    - name: {{ param }}
    - value: {{ setting.get('value') }}
    {% if setting.get('config') is defined %}
    - config: {{ sysctl_settings.config.location }}/{{ setting.get('config') }}
    {% endif %}
    - require:
      - sls: sysctl.package
{% endfor %}
