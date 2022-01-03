"""This file contains shared fixtures and pytest hooks.

https://docs.pytest.org/en/6.2.x/fixture.html#conftest-py-sharing-fixtures-across-multiple-files
"""

import logging

from pytest import fixture
import structlog


@fixture(autouse=True)
def clear_loggers() -> None:
    """Remove handlers from all loggers and unconfigure structlog.

    See https://github.com/pytest-dev/pytest/issues/5502 for an explanation on
    why we need this fixture.
    """
    loggers = [logging.getLogger()] + list(
        logging.Logger.manager.loggerDict.values()  # type: ignore[arg-type]
    )
    for logger in loggers:
        handlers = getattr(logger, "handlers", [])
        for handler in handlers:
            logger.removeHandler(handler)

    structlog.reset_defaults()
