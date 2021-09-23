"""Shared fixture file used by pytest.

https://docs.pytest.org/en/6.2.x/fixture.html#conftest-py-sharing-fixtures-across-multiple-files
"""

from _pytest.config import Config
from typeguard.importhook import install_import_hook


def pytest_configure(config: Config) -> None:
    """Setup typeguard importhooks.

    Note:
        We cannot use --typeguard-packages=tests since we currently get the
        following error:

        typeguard cannot check these packages because they are already imported

        When trying to install an import hook for the 'tests' pacakge (i.e.
        install_import_hook('tests')), it breaks pytest's assertion rewriting.
        See the following URL for more information:

        https://docs.pytest.org/en/stable/writing_plugins.html#assertion-rewriting
    """
    del config

    install_import_hook("{{ cookiecutter.package_name }}")
