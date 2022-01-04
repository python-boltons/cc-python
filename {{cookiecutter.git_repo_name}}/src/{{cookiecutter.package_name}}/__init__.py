"""{{ cookiecutter.package_description }}"""
{%- if cookiecutter.package_type == "library" %}

import logging as _logging

from ._core import dummy


__all__ = ["dummy"]

{% endif -%}
__author__ = "{{ cookiecutter.author }}"
__email__ = "{{ cookiecutter.email }}"
__version__ = "0.0.1"
{%- if cookiecutter.package_type == "library" %}

_logging.getLogger(__name__).addHandler(_logging.NullHandler())
{%- endif %}
