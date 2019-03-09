# Markdown

Stricter `Markdown` generates consistent output. Stricter `Markdown` also makes it easier for your teammates to contribute. I recommend following the [CommonMark][commonmark] specification as it was designed to be unambiguous.

## Use a linter

The easiest way to learn `Markdown` is to rely on a `linter`. I recommend the `Visual Studio Code` extension [markdownlint][markdownlint]. The extension will highlight violations and provide a link explaining why the rule was violated and how to fix it. The rules are available [here][rules].

The most commonly violated rules are:

- Surround headings, lists and code fences by blank lines
- Single top-level heading

## Link to anchor

You can link to a heading within the same page

```plaintext
[Link to title text](#a-title)

#### A title
```

The title needs to be `URL` encoded, space can be replaced by dash.

## Fenced code block language

Setting a language on a fenced code block will allow syntax highlighting.

The following `JavaScript` snippet:

~~~plaintext
```js
console.log("Hello World!");
```
~~~

Will render as:

```js
console.log("Hello World!");
```

You can use `plaintext` to prevent highlighting:

~~~plaintext
```plaintext
I'm just a text
```
~~~

Will render as:

```plaintext
I'm just a text
```

## Code span

Code span allows you to use a code fence within a sentence:

~~~plaintext
I love `PHP`.
~~~

Will render as:

I love `PHP`.

## Tables

`CommonMark` and `GitHub Flavored Markdown` support tables.

~~~plaintext
| Column 1 title | Column 2 title |
| - | - |
| Column 1 row 1 content | Column 2 row 1 content |
| Column 1 row 2 content | Column 2 row 2 content |
~~~

Will be rendered as:

| Column 1 title | Column 2 title |
| - | - |
| Column 1 row 1 content | Column 2 row 1 content |
| Column 1 row 2 content | Column 2 row 2 content |

## Use headings instead of emphasis

Sometimes headings don't render quite at the right size and developers resort to use bold instead. They then lose the ability to link to a section and the semantic meaning of a heading.

Prefer:

```plaintext
### Title
```

To:

```plaintext
**Title**
```

## Bonus

### Define reusable links

You can declutter your `Markdown` by defining the links at the bottom of the page

Usage:

```plaintext
[Text of the link][link-identifier]
```

Definition:

```plaintext
[link-identifier]: https://commonmark.org/help/
```

[commonmark]: https://commonmark.org/
[markdownlint]: https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint#overview
[rules]: https://github.com/DavidAnson/markdownlint/blob/master/doc/Rules.md
