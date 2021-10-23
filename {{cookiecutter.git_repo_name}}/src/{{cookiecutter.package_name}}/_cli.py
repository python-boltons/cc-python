"""Contains the {{ cookiecutter.package_name }} package's main entry point."""

from typing import Sequence

import clap
from pydantic.dataclasses import dataclass


@dataclass(frozen=True)
class Arguments(clap.Arguments):
    """Command-line arguments."""


def parse_cli_args(argv: Sequence[str]) -> Arguments:
    """Parses command-line arguments."""
    parser = clap.Parser()

    args = parser.parse_args(argv[1:])
    kwargs = vars(args)

    return Arguments(**kwargs)


def run(args: Arguments) -> int:
    """This function acts as this tool's main entry point."""
    del args
    return 0


main = clap.main_factory(parse_cli_args, run)
