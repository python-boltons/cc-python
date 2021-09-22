# Contributing


## How to submit feedback?

The best way to send feedback is to [file an issue][1].

If you are reporting a bug, please include:

* Your operating system name and version.
* Any details about your local setup that might be helpful in troubleshooting.
* Detailed steps to reproduce the bug.

If you are proposing a feature:

* Explain in detail how it would work.
* Keep the scope as narrow as possible, to make it easier to implement.
* Remember that this is a volunteer-driven project, and that contributions are
  welcome :).


## Deploying

A reminder for the maintainers on how to deploy. Make sure all your changes are
committed and that you have [bumpversion][2] installed. Then run:

```console
bumpversion patch  # possible values: major / minor / patch
git push
git push --tags
```

A new version of `{{ cookiecutter.package_name }}` will then deploy to PyPI if
tests pass.


[1]: https://github.com/{{ cookiecutter.git_org_name }}/{{ cookiecutter.git_repo_name }}/issues/new/choose
[2]: https://github.com/c4urself/bump2version
