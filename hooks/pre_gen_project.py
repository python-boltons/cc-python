"""Cookiecutter pre-hooks.."""

import json
import os
from typing import MutableMapping


def main() -> None:
    context = json.loads("""{{ cookiecutter | jsonify }}""")
    set_package_dir(context, context["package_name"])


def set_package_dir(
    context: MutableMapping[str, str], package_name: str
) -> None:
    package_path = package_name.replace(".", os.sep)
    context["package_path"] = package_path
    print(
        "Set 'package_path' cookiecutter variable:"
        f" [{{{{ cookiecutter.update({context}) }}}}]"
    )


if __name__ == "__main__":
    main()
