"""Tests for the {{ cookiecutter.package_name }} package."""

from {{ cookiecutter.package_name }} import dummy


def test_dummy() -> None:
    """Test the dummy() function."""
    assert dummy(1, 2) == 3
