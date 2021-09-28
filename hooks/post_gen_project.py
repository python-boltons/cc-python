"""Cookiecutter post-hooks."""

import json
import os
from pathlib import Path
import shutil
import subprocess
from subprocess import PIPE


PROJECT_DIRECTORY = os.path.realpath(os.path.curdir)
GITHUB_URL = "git@github.com:{{ cookiecutter.git_org_name }}/{}.git".format


def main() -> None:
    """Main entry-point for this hook."""
    context = json.loads("""{{ cookiecutter | jsonify }}""")
    create_git_repo(context["git_repo_name"])
    normalize_namespace_path(context["package_name"], context["package_path"])
    delete_package_type_files(context["package_type"])


def create_git_repo(git_repo_name: str) -> None:
    """Initializes a new git repository."""
    if Path(".git").exists():
        print("[WARNING | create_git_repo]: The .git directory already exists.")
        return

    subprocess.run(
        ["git", "init"],
        check=True,
        cwd=PROJECT_DIRECTORY,
        stdout=PIPE,
        stderr=PIPE,
    )
    subprocess.run(
        ["git", "remote", "add", "origin", GITHUB_URL(git_repo_name)],
        check=True,
        cwd=PROJECT_DIRECTORY,
    )


def normalize_namespace_path(package_name: str, package_path: str) -> None:
    """Ensures no directories have a period in their name.

    This can happen, for example, when a namespace package is provided for the
    'package_name' cookiecutter variable (e.g. 'bugyi.lib').
    """
    src = Path("src")
    old_dir = src / package_name
    new_dir = src / package_path
    if old_dir.exists() and old_dir != new_dir:
        if new_dir.exists():
            shutil.rmtree(new_dir)

        new_dir.parent.mkdir(parents=True, exist_ok=True)
        shutil.move(str(old_dir), new_dir)


def delete_package_type_files(package_type: str) -> None:
    """Deletes unnecessary files based on the selected package type."""
    files_to_delete = []

    src = Path("src")
    tests = Path("tests")
    full_package_path = src / "{{ cookiecutter.package_path }}"

    if package_type == "application":
        module = full_package_path / "{{ cookiecutter.package_module }}.py"
        test_module = tests / "test_{{ cookiecutter.package_module }}.py"
    else:
        assert package_type == "library"
        module = full_package_path / "cli.py"
        test_module = tests / "test_cli.py"

    files_to_delete.extend([module, test_module])

    for f2d in files_to_delete:
        os.unlink(f2d)


if __name__ == "__main__":
    main()
