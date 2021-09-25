import json
import os
from pathlib import Path
import shutil
import subprocess
from subprocess import PIPE


PROJECT_DIRECTORY = os.path.realpath(os.path.curdir)
GITHUB_URL = "git@github.com:{{ cookiecutter.git_org_name }}/{}.git".format


def main() -> None:
    context = json.loads("""{{ cookiecutter | jsonify }}""")
    create_git_repo(context["git_repo_name"])
    normalize_namespace_path(context["package_name"], context["package_path"])


def create_git_repo(git_repo_name: str) -> None:
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
    src = Path("src")
    old_dir = src / package_name
    new_dir = src / package_path
    if old_dir.exists() and old_dir != new_dir:
        if new_dir.exists():
            shutil.rmtree(new_dir)

        new_dir.parent.mkdir(parents=True, exist_ok=True)
        shutil.move(str(old_dir), new_dir)


if __name__ == "__main__":
    main()
