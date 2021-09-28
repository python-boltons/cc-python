"""Cookiecutter pre-hooks.

### Set extra cookiecutter variables.
{{
    cookiecutter.update({
        'package_path': cookiecutter.package_name|replace('.', '/'),
        'package_module': cookiecutter.package_name|replace('.', '_'),
    })
}}
"""

import json


def main() -> None:
    """Main entry-point for this hook."""
    context = json.loads("""{{ cookiecutter | jsonify }}""")
    del context  # this entire function is just a placeholder ATM


if __name__ == "__main__":
    main()
