# Getting started with Git on Windows

Install [Git][git].

## Contents

- [Configuration](#configuration)
  - [Name and email address](#name-and-email-address)
  - [Editor](#editor)
  - [Difftool and Mergetool](#difftool-and-mergetool)
- [Credentials manager](#credentials-manager)
- [Useful aliases](#useful-aliases)
- [Handy commands](#handy-commands)
- [Config](#config)
- [Main Git branching models](#main-git-branching-models)

## Configuration

### Name and email address

```bash
git config --global user.name "Your Name Here"
git config --global user.email your@email.com
```

On a specific repository, navigate to the specific repository:

```bash
git config user.name "Your Name Here"
git config user.email your@email.com
```

### Editor

The editor is used to edit commit messages. I like using `vim`, you don't need to install it as it is included in `Git Bash`.

#### Vim

Vim supports:

- Highlighting the first line of the commit in yellow and shift to grey when more than 50 characters
- You can configure it to wrap:

```bash
git config --global core.editor vim
git config --global format.commitMessageColumns 72
```

#### Notepad

```bash
git config --global core.editor notepad
```

Inside `notepad`: `View` => `Status Bar` (so you can see which column you're on currently).

#### Notepad++

If you absolutely want to you can use `Notepad++` but line wrapping will not work.

```bash
git config --global core.editor "'C:\Program Files (x86)\Notepad++\notepad++.exe' -multiInst -notabbar -nosession -noPlugin"
```

### Difftool and Mergetool

I like using [P4Merge][p4-merge].

#### Difftool

```bash
git config --global diff.tool p4merge
git config --global difftool.p4merge.path 'C:\Program Files\Perforce\p4merge.exe'
```

#### Mergetool

```bash
git config --global merge.tool p4merge
git config --global mergetool.p4merge.path 'C:\Program Files\Perforce\p4merge.exe'
git config --global mergetool.p4merge.trustExitCode false
```

When merging, configure your `mergetool` to not create any backup file:

```bash
git config --global mergetool.keepBackup false
```

## Credentials manager

The [Git Credential Manager Core][git-credential-manager-core] (GCM Core) is now included in Git for Windows.

`GCM Core` supports multi-factor authentication for `Azure DevOps`, `GitHub`, and `Bitbucket`.

If you're using multiple accounts on a provider and the accounts can't be differentiated by the hostname only you'll need to instruct Git to pass the entire repository URL, rather than just the hostname:

```bash
git config --global credential.useHttpPath true
```

This will prompt you for your credentials for each repository (see [documentation][credential-use-http-path]).

## Useful aliases

```bash
git config --global alias.st "status"
git config --global alias.lg "log --pretty='%Cred%h%Creset | %s %Cgreen(%cr)%Creset %C(cyan)[%an]%Creset'"
git config --global alias.lg-graph-s "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all"
git config --global alias.lg-graph-l "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
```

## Handy commands

### Checkout the previous branch

```bash
git checkout -
```

![Previous branch](assets/previous-branch.gif)

### Find the latest commit that modified a file

```bash
git log -1 -- <file-path>
```

**Note**: this is particularly useful when looking for the commit that deleted a file.

### Prune remote branches

```bash
git fetch origin --prune
```

Before fetching, remove any remote-tracking references that no longer exist on the remote.

## Config

You can edit your global config with the following command:

```bash
git config --global --edit
```

I recommend adding those settings:

```ini
[core]
    editor = vim -c'startinsert|norm! ggA' - vim will start in INSERT mode
[push]
    default = simple
    followTags = true - Instead of manually pushing new tags with --follow-tags, you always send your annotated tags up along with a git push.
[status]
    showUntrackedFiles = all - shows you all the files underneath that new directory during a git status
```

## Support long paths

```bash
git config --global core.longpaths true
```

Open `Edit Group Policy`:

![Enable long paths](assets/enable-long-paths.png)

## Main Git branching models

Spend some time understanding the reasoning used to design these flows. When deciding on a branching strategy, take into consideration the team's `Git` maturity level, how you're currently releasing software, and how you would like to release software.

| Name | Main characteristic |
| - | - |
| [git-flow][git-flow] | When you need to support multiple production versions. |
| [GitHub Flow][github-flow] | Once your Pull Request is approved, you branch is deployed to production **before** being merged to `main`. |
| [OneFlow][one-flow] | A simpler alternative to git-flow. |
| [Trunk based development][trunk-based-development] | Pair-programming and no Pull Request. |

Martin Fowler wrote a lengthy piece named [Patterns for Managing Source Code Branches][patterns-for-managing-source-code-branches] favouring trunk based development, it does a good job explaining the different branching strategies.

## References

- [How to Write a Git Commit Message][commit-message]
- [Flight rules for git][flight-rules]

### Talks

- :moneybag: [Git Fundamentals][git-fundamentals] (Pluralsight)
- :moneybag: [How Git Works][how-git-works] (Pluralsight)
- :moneybag: [Advanced Git Tips and Tricks][advanced-git-tips-and-tricks] (Pluralsight)
- [The Things Git Can Do (that none of the GUIs have ever told you about)][the-things-git-can-do]

### Books

- [Pro Git, Second Edition][pro-git]

[git]: https://git-scm.com/downloads
[git-credential-manager-core]: https://github.com/microsoft/Git-Credential-Manager-Core
[p4-merge]: https://www.perforce.com/products/helix-core-apps/merge-diff-tool-p4merge
[git-flow]: http://nvie.com/posts/a-successful-git-branching-model/
[trunk-based-development]: https://trunkbaseddevelopment.com/
[github-flow]: https://guides.github.com/introduction/flow/
[flight-rules]: https://github.com/k88hudson/git-flight-rules
[commit-message]: https://chris.beams.io/posts/git-commit/
[git-fundamentals]: https://www.pluralsight.com/courses/git-fundamentals
[how-git-works]: https://www.pluralsight.com/courses/how-git-works
[advanced-git-tips-and-tricks]: https://www.pluralsight.com/courses/git-advanced-tips-tricks
[the-things-git-can-do]: https://vimeo.com/171317261
[pro-git]: https://git-scm.com/book/en/v2
[one-flow]: https://www.endoflineblog.com/oneflow-a-git-branching-model-and-workflow
[patterns-for-managing-source-code-branches]: https://martinfowler.com/articles/branching-patterns.html
[credential-use-http-path]: https://github.com/microsoft/Git-Credential-Manager-Core/blob/main/docs/configuration.md#credentialusehttppath
