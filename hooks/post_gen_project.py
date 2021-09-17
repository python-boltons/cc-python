import json
import os
import subprocess
from subprocess import PIPE


PROJECT_DIRECTORY = os.path.realpath(os.path.curdir)
GITHUB_URL = "git@github.com:{{ cookiecutter.git_org_name }}/{}.git".format


def create_git_repo(package_name: str) -> None:
    if test_user := os.getenv("TEST_USER"):
        print(
            f"[TESTS ARE RUNNING | user={test_user}] We don't initialize a git"
            " repository when this function is called by a test (e.g. by"
            " running `make test`)."
        )
        return

    subprocess.run(
        ["git", "init"],
        check=True,
        cwd=PROJECT_DIRECTORY,
        stdout=PIPE,
        stderr=PIPE,
    )
    subprocess.run(
        ["git", "remote", "add", "origin", GITHUB_URL(package_name)],
        check=True,
        cwd=PROJECT_DIRECTORY,
    )


def main() -> None:
    context = json.loads("""{{ cookiecutter | jsonify }}""")
    create_git_repo(context["git_repo_name"])


if __name__ == "__main__":
    main()
