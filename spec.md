---
title: Common Command Line Interface Tool Specification
author: Nathan Martindale
created: 2022-06-17
modified: 2022-06-17
version: 0.1.0
---

# Introduction

The goal of this project is to aid in building robust, comprehensible, and
flexible tools that both I and others can use. This entails rigor and adherence
to effective standards and best practices for tooling, which will be formalized
for my use in this specification.

Adhering to principles by sheer will power is subject to laziness and
forgetfullness, and so this specification is intended to inform this
repository's tools to help build tools, because additional meta levels of
abstraction always lead to good things. (\s)

# Ideals

* Clean, consistent formatting and documentation.
* As small and minimal as possible while remaining effective and robust.
* Use common or well defined standards where available.
* Subtractive-based or snippet-based programming where possible.


# Conventions

## Note-Taking

Taking notes is critical to help understand previous work, decisions, and for
getting back into the right mindset for working on a problem. Notes can be 
written at different levels for different levels of "consumer".

TODO: spec docs?

### Engineering Notes

A research or engineering log is really useful for stream-of-consciousness
thoughts while working. This is useful to keep track of trivial TODOs that
you're working on as well as immediate notes for what you think the problem is
when you're debugging/things you're trying to investigate - it makes it easier
to get back into the flow of what you were doing if you get interrupted and
provides a traceable log of what you've done/if you've encountered an issue
before.

### Decision Log/Architecture Decision Records

Significant architecture decisions should be documented using a ADR format,
detailing the context/problem, the proposed decision and why, the alternatives 
considered and why they weren't chosen, and consequences.

Each decision should go in its own file, probably under a `/docs/adr` directory.


## CLI Flags

These are flags that should be available to most (if not all) tools:

* `-h, --help` (prints usage text)
* `-V, --version` (prints current version number of tool)
* `-v, --verbose` (print more stuff, may not always be applicable)
* `--no-color` (print without rendering ansi color sequences)

## Language Specific

### Bash

NOTE: subtractive but also put each part in a snippet and throw into nix-config

## Conventional Output Directories

There are commonly observed standards for where stuff goes. XDG specification
should be adhered to:

[https://wiki.archlinux.org/title/XDG_Base_Directory](https://wiki.archlinux.org/title/XDG_Base_Directory)

[https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)

If these variables are set in env, use them, otherwise default to provided:

* `XDG_CONFIG_HOME` (`$HOME/.config`) - configuration files.
* `XDG_CACHE_HOME` (`$HOME/.cache`) - non-essential cached data.
* `XDG_DATA_HOME` (`$HOME/.local/share`) - data files.
* `XDG_STATE_HOME` (`$HOME/.local/state`) - state files. (unsure if this is
  really used much)
* `XDG_RUNTIME_DIR` - used for ephemeral stuff like sockets and pipes, see arch
  wiki above for more details

There are also system directories `XDG_DATA_DIRS`
(`/usr/local/share:/usr/share`) and `XDG_CONFIG_DIRS` (`/etc/xdg`), which are
lists of other locations to look for configs/data files etc.

Note that for all of these, it's assumed your application makes its own
directory within them.

There are additinoal rules for how you combine looking at the system directories
and the user ones, but I'm not sure if I'm going to be using those for now.

## Misc

### Status indicators

TODO: not sure if I agree this is really necessary.

When a script involves status checks, and potentially a significant amount of
log lines are output between the check and the end of the script, these should
be recorded into a single status indicators string to be printed at the end of
the process in a summary view.

ex:

```
$ some_process
[PASS] dependency 1 exists
various log messages
[PASS] dependency 2 exists
other long running process messages...
things
more things
so many things
> setup complete!

Summary:
[PASS] dependency 1 exists
[PASS] dependency 2 exists
```

This of course is unnecessary for low output or small scripts. Note that
diagnostic messages like this should be output over stderr, if actual output is
ever expected from the script.

## Tool Project

TODO: tests

### CHANGELOG.md

A record of changes following
[https://keepachangelog.com/en/1.0.0/](https://keepachangelog.com/en/1.0.0/).
Note that we do not need to use the tag differences at the bottom.

### flake.nix

A flake to install the tool.

### README.md

A basic structured description of the tool, setup process/instructions, and so
on.

### setup.sh

A "manual" setup file, assuming no package management is used. This setup file
should run any dependency checks, attempt to install dependencies if possible,
or allow user override, or fail with a suggested fix. It should allow for a
number of arguments like overriding where it's installed, whether the install is
interactive or not, and so on.

TODO: what flags should setup standardly have?

### todo.txt

The tool's project todo-list should be managed through a `todo.txt` file. The
formatting for this file should use a combination of standards from todo.txt
[https://github.com/todotxt/todo.txt](https://github.com/todotxt/todo.txt) and
org mode TODO items
[https://orgmode.org/manual/TODO-Items.html](https://github.com/todotxt/todo.txt)

#### Format

TODO: describe format

```
keyword: (optional-priority-letter) (optional-due-date) text [+tag] ...
```

#### TODO Keywords

TODO: look up common patterns. (I personally normally use TODO, STRT, WAIT,
DONE, CANC, BUG, FIXD, IDEA

The advantage in using common keywords both among source code as well as in a
top level todo.txt is the ability to grep for all todos in a project.
