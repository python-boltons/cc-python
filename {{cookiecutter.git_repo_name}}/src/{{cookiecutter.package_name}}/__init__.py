"""{{ cookiecutter.package_description }}"""
{%- if cookiecutter.package_type == "library" %}

from .{{ cookiecutter.package_module }} import dummy
{% endif %}

__author__ = "{{ cookiecutter.author }}"
__email__ = "{{ cookiecutter.email }}"
__version__ = "0.0.1"
