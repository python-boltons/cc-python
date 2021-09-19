.. {{ cookiecutter.package_name }}

Welcome to {{ cookiecutter.package_name }}'s documentation!
============================{{ '=' * cookiecutter.package_name.__len__() }}

{{ cookiecutter.package_description }}

.. toctree::
   :maxdepth: -1
   :caption: Table of Contents

    API Reference <modules>
    CHANGELOG <CHANGELOG.md>
    CODE_OF_CONDUCT <CODE_OF_CONDUCT.md>
    CONTRIBUTING <CONTRIBUTING.md>
    README <README.md>

Useful Links
============

* `cc-python <https://github.com/bbugyi200/cc-python>`_: The cookiecutter that was used to
  generate this project. Changes made to this cookiecutter are periodically synced with this
  project.
* `github:{{ cookiecutter.git_org_name }}/{{ cookiecutter.git_repo_name }} <https://github.com/{{
  cookiecutter.git_org_name }}/{{ cookiecutter.git_repo_name }}>`_: This project's source code is
  hosted on GitHub.


Indices and Tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`
