# Update Angular

This guide is specific to my setup (I use [Angular ESLint](https://github.com/angular-eslint/angular-eslint))

```powershell
ng update @angular/cli @angular/core @angular-eslint/schematics
```

This works both for minor and major updates.

After commiting the changes:

1. Run every script to ensure they still work
1. Launch the app and have a quick browse through

## Major updates

Before embarking on a major upgrade:

1. Check that [ESLint is supporting the new Angular version](https://github.com/angular-eslint/angular-eslint/releases)
1. Check the [Angular update guide](https://angular.dev/update-guide).

Once you're done with the update, you'll want to create a brand new project to see if common files have been updated.

Install the latest version of the Angular CLI globally:

```powershell
npm install -g @angular/cli
```

Create the Angular app (this will create an Angular app in the `my-app` directory):

```powerhshell
ng new my-app --package-manager yarn
```

Pick

1. Sass (SCSS) _not the default_
1. Don't enable SSR/SSG

Add ESLint:

```powershell
cd my-app
ng add @angular-eslint/schematics
```

Compare the below files with the project you're working on:

- `.vscode\extensions.json`
- `angular.json`
- `package.json`
- `tsconfig.app.json`
- `tsconfig.json`
- `tsconfig.spec.json`
