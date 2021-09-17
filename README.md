# cc-python [![CI Workflow](https://github.com/bbugyi200/cc-python/actions/workflows/ci.yml/badge.svg)](https://github.com/bbugyi200/cc-python/actions/workflows/ci.yml)

This repository contains the [cookiecutter] that I use for all of my Python
projects.

[cookiecutter]: https://github.com/cookiecutter/cookiecutter

## Initializing a New Project using this cookiecutter

This section provides a demonstration of initializing a new cc-python project,
say `foobar`, using this cookiecutter repo.

We must first create a new repo under the [bbugyi200] organization using
GitHub. We then use [cruft] to initialize a new project using this
cookiecutter. Before we can do that, we need to install cruft (we recommend
using [pipx] for this):

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

Answer all of the variable prompts that cruft produces (e.g. `foobar` for the
`git_repo_name` prompt) and then run the following commands to push this new
project to the repo you created earlier via GitHub's web interface:

```bash
cd foobar
make use-docker
make all
git add -v --all
git commit -m "First commit."
git push -u origin master
```

[bbugyi200]: https://github.com/bbugyi200?tab=repositories
[cruft]: https://github.com/cruft/cruft
[pipx]: https://github.com/pypa/pipx

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
the conflict as you would any other) _or_ it creates a [.rej] file for every
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

> **NOTE**: There is currently a proposal (see [cruft#49]) to improve the way
> the `cruft update` command handles conflicts.

[cruft#49]: https://github.com/cruft/cruft/issues/49
[.rej]: https://stackoverflow.com/questions/34585865/what-are-rej-files-which-are-created-during-merge
