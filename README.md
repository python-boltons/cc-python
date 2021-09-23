# cc-python [![CI Workflow](https://github.com/bbugyi200/cc-python/actions/workflows/ci.yml/badge.svg)](https://github.com/bbugyi200/cc-python/actions/workflows/ci.yml) [![Version](https://img.shields.io/static/v1?label=version&message=2021.09.23-2&color=4d4dff)](https://github.com/bbugyi200/cc-python/blob/master/CHANGELOG.md#20210923-2)

This repository contains the [cookiecutter] that I use for all of my Python
projects. Refer to [this link][8] for a list of all projects that were
generated using this cookiecutter.

[cookiecutter]: https://github.com/cookiecutter/cookiecutter


## Initializing a New Project using this cookiecutter

This section provides a demonstration of initializing a new cc-python project,
say `foobar`, under some github organization, say `org`, using this
cookiecutter repo.

We must first create a new repository under the [org][5] organization using
GitHub. These next few steps are needed to allow our new repository to talk to
the outside world. Namely, we need to:

* Add the `PYPI_API_TOKEN` secret to our new repository so CI is able to
  publish to PyPI. We can accomplish this by going to the following link
  (remember to replace `org` and `foobar` with the actual organization and
  repository names you have chosen). See [this guide][1] for more information
  on this step: https://github.com/org/foobar/settings/secrets/actions
* [Import](https://readthedocs.org/dashboard/) the `foobar` project from
  [readthedocs][2].

We then use [cruft][6] to initialize a new project using this cookiecutter.
Before we can do that, we need to install cruft (we recommend using [pipx][7]
for this):

```bash
# install and setup pipx
python3 -m pip install --user pipx
python3 -m pipx ensurepath

# install cruft
pipx install cruft
```

We then run the following command to generate a new project using cruft:

```bash
cruft create https://github.com/bbugyi200/cc-python
```

Answer all of the variable prompts that cruft produces (e.g. `org` for the
`git_org_name` prompt and `foobar` for the `git_repo_name` prompt) and then run
the following commands to push this new project to the repo you created earlier
via GitHub's web interface:

```bash
cd foobar

# first commit
git add -v --all
git commit -m "First commit"

# initialize project
make use-docker
make all
git add -v --all
git commit -m 'Initialize project by running `make all`'

# push project to github repo
git push -u origin master
```

Now that we have pushed some code, we can cleanup our new repository a bit:

* Add a description and tag the repository with relevant topics (at the very
  least, tag the repo with the [python][9] and [cc-python][8] topics) by
  clicking the little gear next to the "About" header (you may also want to
  uncheck all boxes in the "Include in the home page" section).


## How to Propagate Changes to All Cookiecutter Projects

Bringing a project up-to-date is generally as simple as running `cruft update`
from the root directory of that project and then submitting a new PR.  With
that said, see the [Dealing with Cruft
Conflicts](#dealing-with-cruft-conflicts) section below if cruft reports any
conflicts.

### Dealing with Cruft Conflicts

Dealing with `cruft update` conflicts can be tricky at the moment (see the note
below). When the `cruft update` command is unable to merge a subset of the new
cookiecutter changes into the current project, it reports the conflicts to
STDOUT and then either creates a merge conflict (in which case you just resolve
the conflict as you would any other) _or_ it creates a [.rej][4] file for every
file that contained unmergable changes. The latter case requires special
treatment since these changes will need to be merged manually. An example of
how I would go about merging these changes manually is shown below:

```bash
# Open up all .rej files created by the `cruft update` command.
vim $(find . -type f -name '*.rej')

# Go through each file, assess the changes, and then copy and paste them (if desirable) into
# the corresponding project files...

# Delete all .rej files created by the `cruft update` command. NOTE: This step is important
# since otherwise, next time the `cruft update` command reports conflicts, we won't know which
# .rej files are current. 
find . -type f -name '*.rej' -delete
```

> **NOTE**: There is currently a proposal (see [cruft#49][3]) to improve the way
> the `cruft update` command handles conflicts.


[1]: https://packaging.python.org/guides/publishing-package-distribution-releases-using-github-actions-ci-cd-workflows
[2]: https://docs.readthedocs.io/en/stable/
[3]: https://github.com/cruft/cruft/issues/49
[4]: https://stackoverflow.com/questions/34585865/what-are-rej-files-which-are-created-during-merge
[5]: https://github.com/bbugyi200?tab=repositories
[6]: https://github.com/cruft/cruft
[7]: https://github.com/pypa/pipx
[8]: https://github.com/topics/cc-python
[9]: https://github.com/topics/python
