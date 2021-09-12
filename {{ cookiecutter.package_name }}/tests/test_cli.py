"""Tests the {{ cookiecutter.package_name }}.cli module."""

from {{ cookiecutter.package_name }}.cli import main


def test_main() -> None:
    """Tests main() function."""
    assert main([""]) == 0
