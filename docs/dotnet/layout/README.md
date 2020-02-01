# Layout of a `.NET Core` project

```text
$/
  artifacts/
  build/
  docs/
    adr/
    implementation/
  lib/
  samples/
  scripts/
  src/
    SomeProject/Properties/launchSettings.json
  tests/
  .editorconfig
  .gitattributes
  .gitignore
  build.cake
  bootstrap.ps1
  bootstrap.sh
  CONTRIBUTING.md
  LICENSE
  NuGet.Config
  README.md
  {solution}.sln
```

- `artifacts` - Build outputs go here. Doing a `dotnet cake build.cake --pack` generates artifacts here
- `build` (optional) - Build scripts
- `docs` - [Documentation][documentation]: Architecture Document Records and implementation details
- `lib` (very optional) - Things that can **NEVER** exist in a `NuGet` package
- `samples` (optional) - Sample projects
- `scripts` - Small tools for developers, such as `LINQPad` scripts
- `src` - Main projects (the product code)
  - `Properties/launchSettings.json` - Defines launch profiles
- `tests` - Test projects
- `.editorconfig` - x-plat `IDE` [settings][editorconfig]
- `build.cake` - `Cake` build
- `bootstrap.ps1` - Bootstrap the build for windows
- `bootstrap.sh` - Bootstrap the build for nix
- `CONTRIBUTING.md` - Documentation explaining the branching model
- `LICENSE` - License of the project
- `NuGet.Config` (optional) - Custom feeds configuration
- `README.md` - Documentation explaining at least how to get started

## Properties/launchSettings.json

### Console application

```json
{
  "$schema": "http://json.schemastore.org/launchsettings.json",
  "profiles": {
    "SomeProject": {
      "commandName": "Project"
    }
  }
}
```

### ASP.NET Core application

```json
{
  "$schema": "http://json.schemastore.org/launchsettings.json",
  "profiles": {
    "Kestrel": {
      "commandName": "Project",
      "applicationUrl": "https://localhost:5001",
      "environmentVariables": {
        "ASPNETCORE_ENVIRONMENT": "Development"
      }
    }
  }
}
```

## .editorconfig

Sample of `.editorconfig`:

```text
# EditorConfig is awesome: https://EditorConfig.org

# top-most EditorConfig file
root = true

# Don't use tabs for indentation.
[*]
indent_style = space

# Code files
[*.{cs}]
indent_size = 4
insert_final_newline = true
charset = utf-8-bom

# Xml project files
[*.{csproj}]
indent_size = 2

# JSON files
[*.json]
indent_size = 2

# Dotnet code style settings:
[*.{cs}]
# Sort using and Import directives with System.* appearing first
dotnet_sort_system_directives_first = true
# Avoid "this." and "Me." if not necessary
dotnet_style_qualification_for_field = false:suggestion
dotnet_style_qualification_for_property = false:suggestion
dotnet_style_qualification_for_method = false:suggestion
dotnet_style_qualification_for_event = false:suggestion

# Use language keywords instead of framework type names for type references
dotnet_style_predefined_type_for_locals_parameters_members = true:suggestion
dotnet_style_predefined_type_for_member_access = true:suggestion

# Suggest more modern language features when available
dotnet_style_object_initializer = true:suggestion
dotnet_style_collection_initializer = true:suggestion
dotnet_style_coalesce_expression = true:suggestion
dotnet_style_null_propagation = true:suggestion
dotnet_style_explicit_tuple_names = true:suggestion

# CSharp code style settings:
[*.cs]
# Indentation preferences
csharp_indent_block_contents = true
csharp_indent_braces = false
csharp_indent_case_contents = true
csharp_indent_switch_labels = true
csharp_indent_labels = flush_left

# Prefer "var" everywhere
csharp_style_var_for_built_in_types = true:suggestion
csharp_style_var_when_type_is_apparent = true:suggestion
csharp_style_var_elsewhere = true:suggestion

# Prefer method-like constructs to have a block body
csharp_style_expression_bodied_methods = false:none
csharp_style_expression_bodied_constructors = false:none
csharp_style_expression_bodied_operators = false:none

# Prefer property-like constructs to have an expression-body
csharp_style_expression_bodied_properties = true:none
csharp_style_expression_bodied_indexers = true:none
csharp_style_expression_bodied_accessors = true:none

# Suggest more modern language features when available
csharp_style_pattern_matching_over_is_with_cast_check = true:suggestion
csharp_style_pattern_matching_over_as_with_null_check = true:suggestion
csharp_style_inlined_variable_declaration = true:suggestion
csharp_style_throw_expression = true:suggestion
csharp_style_conditional_delegate_call = true:suggestion

# Newline settings
csharp_new_line_before_open_brace = all
csharp_new_line_before_else = true
csharp_new_line_before_catch = true
csharp_new_line_before_finally = true
csharp_new_line_before_members_in_object_initializers = true
csharp_new_line_before_members_in_anonymous_types = true
```

## .gitattributes

```text
# Some files will only run on Linux, we should force line feed
bootstrap.sh eol=lf
```

## .gitignore

**Keep it simple**. Sample file:

```text
# Rider

.idea/
*.DotSettings.user

# Build detritus

bin/
obj/

# Cake

tools/
artifacts/

# Visual Studio

.vs/
*.csproj.user
```

## bootstrap.sh

```sh
dotnet tool install Cake.Tool --global --version 0.31.0
dotnet cake build.cake --bootstrap
dotnet cake build.cake
```

[editorconfig]: https://editorconfig.org/
[documentation]: ../documentation/README.md
