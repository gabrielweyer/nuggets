# PowerShell

Every now and then I find myself writing `PowerShell`. It is infrequent enough that I have the time to fully forget the syntax and have to spend hours looking for things I've done over and over again. This guide contains the most common operations I perform in `PowerShell`.

## Contents

- [PowerShell Core](#powerShell-core)
- [Always use a Cmdlet](#always-use-a-cmdlet)
- [Verbose](#Verbose)
- [ErrorActionPreference](#erroractionpreference)
- [Get-Help](#get-help)
- [Break down long lines](#break-down-long-lines)
- [Create an Array](#create-an-array)
- Commands
  - [Pipe the output of a command into the input of another command](#pipe-the-output-of-a-command-into-the-input-of-another-command)
  - [Discard command output](#discard-command-output)
- [Working with JSON](#working-with-json)
- Objects
  - [Create a custom object](#create-a-custom-object)
  - [Selecting an object property](#selecting-an-object-property)
  - [String interpolation for object properties](#string-interpolation-for-object-properties)
- [Filtering](#filtering)
- [Require a minimum version of PowerShell](#require-a-minimum-version-of-powershell)
- File operations
  - [Read](#read-file)
  - [Write](#write-to-file)
- [Get stderr from external process](#get-stderr-from-external-process)

## PowerShell Core

Use [PowerShell Core][github-powershell-core] (e.g. starting from `6.x`). It is cross-platform (`Windows`, `macOS` and `Linux`) and has better defaults (i.e. `Out-File` now uses `UTF8` by default instead of `UTF-16` using the little-endian byte order).

## Always use a Cmdlet

```powershell
[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [string]$VpcStackName,

    [Parameter(Mandatory=$true)]
    [int]$NodeCountMax
)

$ErrorActionPreference = "Stop"
```

In this case the `Cmdlet` is taking `2` parameters (`$VpcStackName` and `$NodeCountMax`). You can also create `Cmdlets` that don't take any parameters. This approach has a few benefits:

- The expected parameters are specified explicitely
  - Parameters can be made `Mandatory`
  - Parameters are strongly-typed
- Support [Verbose](#verbose)
- Support for [ErrorActionPreference](#erroractionpreference)
- Support for [Get-Help](#get-help)

## Verbose

If I create the following `PowerShell` script named `verbose-demo.ps1`:

```powershell
[CmdletBinding()]
param (
)

Write-Verbose 'Hello from Verbose!'
```

I can execute it in the following fashion:

```bash
> ./verbose-demo.ps1
```

But if I add the the `-Verbose` `Switch`, I'll get a different output:

```bash
> ./verbose-demo.ps1 -Verbose
Hello from Verbose!
```

## ErrorActionPreference

In most of the cases I want my scripts to stop at the first encountered error. Setting `$ErrorActionPreference` to `"Stop"` does exactly this:

```powershell
$ErrorActionPreference = "Stop"
```

This only impacts the lines below `$ErrorActionPreference = "Stop"`.

## Get-Help

Create a script name `get-help.ps1`:

```powershell
<#

.SYNOPSIS
A brief title

.DESCRIPTION
A longer description

.PARAMETER VpcStackName
The name for the CloudFormation stack that deploys the VPC.

.EXAMPLE
./get-help.ps1 -VpcStackName nonprod-eks-vpc

.NOTES
Include things such as pre-requisites

.LINK
A URI where I can get more information

#>

[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [string]$VpcStackName
)
```

```plaintext
> Get-Help ./get-help.ps1

NAME
    C:\tmp\get-help.ps1

SYNOPSIS
    A brief title


SYNTAX
    C:\tmp\get-help.ps1 [-VpcStackName] <String> [<CommonParameters>]


DESCRIPTION
    A longer description


RELATED LINKS
    A URI where I can get more information

REMARKS
    To see the examples, type: "get-help C:\tmp\get-help.ps1 -examples".
    For more information, type: "get-help C:\tmp\get-help.ps1 -detailed".
    For technical information, type: "get-help C:\tmp\get-help.ps1 -full".
    For online help, type: "get-help C:\tmp\get-help.ps1 -online"
```

## Break down long lines

You can use the backtick character to split a long line over multiple lines:

```powershell
Invoke-Executable aws --region $AwsRegion cloudformation create-stack `
    --stack-name $VpcStackName `
    --role-arn $DeploymentServiceRoleArn `
    --template-body file://eks/eks-vpc.yaml
```

## Create an Array

```powershell
> @(1, 2, 3)
1
2
3
```

## Commands

### Pipe the output of a command into the input of another command

```powershell
> 'Write me to a file!' | Out-File './output.log'
```

### Discard command output

```powershell
mkdir tmp | Out-Null
```

## Working with JSON

```powershell
> '{"Greeting": "Hello!"}' | ConvertFrom-Json
Greeting
--------
Hello!
```

## Objects

### Create a custom object

```powershell
[PSCustomObject]@{
    Name = 'Balloon'
    Sum = 15
}
```

### Selecting an object property

```powershell
> '{"Greeting": "Hello!"}' | ConvertFrom-Json | Select-Object -ExpandProperty Greeting
Hello!
```

### String interpolation for object properties

```powershell
Write-Verbose "Created '$($eksAuthConfigurationMapTemporaryFile.FullName)' to store the EKS authentication configuration map"
```

## Filtering

```powershell
$phases = @(
    [PSCustomObject]@{
        Name = 'Lord'
        Sum = 9
    }
    [PSCustomObject]@{
        Name = 'Bucket'
        Sum = 3
    }
    [PSCustomObject]@{
        Name = 'Head'
        Sum = 6
    }
)

$importantPhases = $phases | Where-Object { $_.Sum -gt 5 }
```

## Require a minimum version of PowerShell

At the top of the script:

```powershell
#requires -Version 6.0
```

## File operations

### Read file

```powershell
$eksAuthConfigurationMapTemplate = Get-Content .\eks\eks-auth-configuration-map.yaml -Raw
```

### Write to file

```powershell
> 'Write me to a file!' | Out-File './output.log'
```

## Get stderr from external process

There is not yet a way to do this across platform, you will have to handle `Windows` and `Unix` differently.

The `Unix` command needs to be surrounded by single quotes.

```powershell
if ($IsWindows) {
    $deleteContextOuput = cmd /c kubectl config delete-context $kubectlContext '2>&1'
} else {
    $shellCommand = "'{ kubectl config delete-context $kubectlContext; } 2>&1'"
    $deleteContextOuput = sh -c $shellCommand
}

if ($LASTEXITCODE -ne 0) {
    Write-Warning "Could not delete context '$kubectlContext', error message was: $deleteContextOuput"
}
```

Based on an answer to the `Stack Overflow` question [PowerShell: Capture the output from external process that writes to stderr in a variable][powershell-capture-stderr].

[github-powershell-core]: https://github.com/powershell/powershell
[powershell-capture-stderr]: https://stackoverflow.com/a/45288514/57369
