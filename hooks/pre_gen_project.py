"""Cookiecutter pre-hooks.

### Set extra cookiecutter variables.
{{
    cookiecutter.update({
        'package_path': cookiecutter.package_name|replace('.', '/')
    })
}}
"""

import json


def main() -> None:
    context = json.loads("""{{ cookiecutter | jsonify }}""")
    del context  # this entire function is just a placeholder ATM


if __name__ == "__main__":
    main()
