# Layout of a `.NET Core` project

```text
$/
  artifacts/
  build/
  docs/
  lib/
  samples/
  scripts/
  src/
  tests/
  tools/
    packages.config
  .editorconfig
  .gitattributes
  .gitignore
  build.cake
  build.ps1
  build.sh
  initial-setup.ps1
  LICENSE
  NuGet.Config
  README.md
  {solution}.sln
```

- `artifacts` - Build outputs go here. Doing a `build.ps1` / `build.sh` generates artifacts here
- `build` (optional) - Build scripts
- `docs` - Documentation: Markdown files, help files etc.
- `lib` (very optional) - Things that can **NEVER** exist in a `NuGet` package
- `samples` (optional) - Sample projects
- `scripts` - Small tools for developers, such as `LINQPad` scripts
- `src` - Main projects (the product code)
- `tests` - Test projects
- `tools` - Tools used by the local build or to setup a developer's machine
  - `packages.config` - To pin the version of `Cake`
- `.editorconfig` - x-plat `IDE` [settings][editorconfig]
- `build.cake` - `Cake` build
- `build.ps1` - Bootstrap the build for windows
- `build.sh` - Bootstrap the build for nix
- `initial-setup.ps1` (optional) - Will configure a developer's machine to be able to run the code
- `LICENSE` - License of the project
- `NuGet.Config` (optional) - Custom feeds configuration
- `README.md` - Documentation explaining at least how to get started

## .editorconfig

Sample of `.editorconfig`:

```text
root = true

[*]
end_of_line = CRLF
insert_final_newline = true

[*.ps1]
indent_style = space
indent_size = 2

[*.cs]
indent_style = space
indent_size = 4

[*.cake]
indent_style = space
indent_size = 4

[*.json]
indent_style = space
indent_size = 2

[tools/packages.config]
end_of_line = LF
```

## .gitattributes

```text
# Some files will only run on Linux, we should force line feed
build.sh eol=lf
```

## .gitignore

Keep it simple. Sample file:

```text
# Rider

.idea/

# Build detritus

bin/
obj/

# Cake

tools/*
!tools/packages.config
artifacts/

# Visual Studio

.vs/
*.csproj.user
```

[editorconfig]: https://editorconfig.org/
