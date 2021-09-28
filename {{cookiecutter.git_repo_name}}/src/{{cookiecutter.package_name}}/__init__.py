"""{{ cookiecutter.package_description }}"""

__author__ = "{{ cookiecutter.author }}"
__email__ = "{{ cookiecutter.email }}"
__version__ = "0.0.1"

{% if cookiecutter.package_type == "library" -%}
from .{{ cookiecutter.package_name }} import dummy
{%- endif %}
