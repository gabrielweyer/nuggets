# SQL conventions

Using a convention when writing `SQL` allow us to be more productive as a team.

## Table of contents

- [Naming](#naming)
  - [Singular table name](#singular-table-name)
  - [Avoid using product names](#avoid-using-product-names)
  - [Avoid using abbreviations](#avoid-using-abbreviations)
  - [Primary key as Id and Code](#primary-key-as-id-and-code)
- [Favour natural keys over surrogate keys](#favour-natural-keys-over-surrogate-keys)
- [Use the most appropriate type](#use-the-most-appropriate-type)
  - [numeric over money](#numeric-over-money)
  - [varchar over char for variable length columns](#varchar-over-char-for-variable-length-columns)
  - [datetime2 over datetime](#datetime2-over-datetime)
  - [exact-number or uniqueidentifier for Primary Keys](#exact-number-or-uniqueidentifier-for-primary-keys)
- [Avoid square brackets](#avoid-square-brackets)
- [Do not play with fire](#do-not-play-with-fire)
  - [Always use AS when defining an alias](#always-use-as-when-defining-an-alias)
  - [Always use WITH when using a table hint](#always-use-as-when-defining-an-alias)
- [Use two-part object names](#use-two-part-object-names)

## Naming

### Singular table name

We use singular table names and not plural.

Prefer:

```sql
Invoice
```

Avoid:

```sql
Invoices
```

### Avoid using product names

Products get renamed and get acquired by other vendors. Instead try to convey the business meaning.

### Avoid using abbreviations

Abbreviations can sometimes be confusing. It is acceptable to use well-known acronyms.

### Primary key as Id and Code

Primary keys should be named `Id` when they are an exact-number type or a `uniqueidentifier` type.

In the expression `Entity.Id`, the `Entity` table has `Id` as a Primary Key. Another table referencing the entity Id as a Foreign Key could name the column as `EntityId`.

When the primary key is an alphanumeric (often provided by another system), use the term `Code`. For example a `Product` could be designed by its `Code`.

## Favour natural keys over surrogate keys

If you already have a unique identifier provided by another system, use it instead of introducing a surrogate key. For example if a `Product` is identified by a `Code`, use the `Code` as a natural key instead of introducing a surrogate key in the form of an exact-number Primary Key.

On the other end, if an entity does not have a natural key, introduce a surrogate key so that you can identify each row uniquely and easily.

## Use the most appropriate type

### numeric over money

Favour `numeric` instead of `money` to [avoid unintentional loss of precision due to rounding errors during calculations][avoid-use-of-money-and-smallmoney-datatypes].

### varchar over char for variable length columns

Favour `varchar` instead of `char` when the [column data entries vary in length][char-and-varchar].

### datetime2 over datetime

`datetime2` is more precise than `datetime` and you can decide how much precision you want. Read [On the Advantages of DateTime2(n) over DateTime][advantages-of-datetime2] for more details.

### exact-number or uniqueidentifier for Primary Keys

Primary keys should preferably use an exact-number type. The exact-number type (`bigint`, `int`, `smallint` or `tinyint`) should be selected based on the expected number of rows in the table.

Alternatively a `uniqueidentifier` type can be used when multiple providers are inserting rows concurrently. Keep in mind that exact-number types make for shorter and more readable `URI`s.

## Avoid square brackets

Do not use square brackets when they're not required.

Prefer:

```sql
SELECT
    TOP (1)
    Id
FROM dbo.Entity;
```

Avoid:

```sql
SELECT
    TOP (1)
    [Id]
FROM [dbo].[Entity];
```

Use square brackets when the identifier is a reserved word.

Prefer:

```sql
SELECT
    TOP (1)
    [date]
FROM dbo.legacytable;
```

## Do not play with fire

### Always use AS when defining an alias

The query below will display the column `bad_name` as the alias `other_bad_name`.

Avoid:

```sql
SELECT
    TOP (1)
    bad_name
    other_bad_name
FROM dbo.legacytable;
```

Prefer:

```sql
SELECT
    TOP (1)
    bad_name AS BetterName,
    other_bad_name AS OtherBetterName
FROM dbo.legacytable;
```

### Always use WITH when using a table hint

The table `legacytable` has been aliased to `NOLOCK` in the following query.

Avoid:

```sql
SELECT
    TOP (1)
    NOLOCK.bad_name
FROM dbo.legacytable NOLOCK;
```

It's very likely the developer meant to use the [NOLOCK table hint][nolock] instead.

Prefer:

```sql
SELECT
    TOP (1)
    bad_name
FROM dbo.legacytable WITH (NOLOCK);
```

## Use two-part object names

Include the schema when referencing a table.

Avoid:

```sql
SELECT
    TOP (1)
    Id
FROM Entity;
```

Prefer:

```sql
SELECT
    TOP (1)
    Id
FROM dbo.Entity;
```

This assists with query plan caching as explained by [Greg Low][two-part-names].

## Query in style

The query below is of no value aside of illustrating different clauses:

```sql
SELECT
    -- Avoid using reserved keywords as an alias but if you do use double quotes
    -- See: https://www.red-gate.com/hub/product-learning/sql-prompt/sql-prompt-code-analysis-avoid-non-standard-column-aliases
    CONVERT(varchar(10), char_date, 23) AS "Date",
    -- Put each selected expression on its own line
    COUNT(*) AS SomeCount
-- FROM goes on its own line
FROM dbo.Entity
    -- Sample JOINs, I'm just demonstrating how towe join
    INNER JOIN dbo.RelatedTable ON Entity.RelatedTableId = RelatedTable.Id
    LEFT OUTER JOIN dbo.OtherRelatedTable ON Entity.OtherRelatedTableId = OtherRelatedTable.Id
-- WHERE goes on its own line
WHERE
    char_date BETWEEN '2019-05-05' AND '2020-05-05'
    -- Each clause goes on its own line
    AND [type] <> 'OHHI'
-- GROUP BY goes on its own line
GROUP BY CONVERT(varchar(10), char_date, 23)
-- ORDER BY goes on its own line
-- We use square brackets around `Date` because it's a reserved keyword
ORDER BY [Date];
```

## References

- [SQL Server Name Convention and T-SQL Programming Style][sql-server-conventions]

[avoid-use-of-money-and-smallmoney-datatypes]: https://www.red-gate.com/hub/product-learning/sql-prompt/avoid-use-money-smallmoney-datatypes
[char-and-varchar]: https://docs.microsoft.com/en-us/sql/t-sql/data-types/char-and-varchar-transact-sql?view=sql-server-ver15#remarks
[advantages-of-datetime2]: https://www.sqltact.com/2012/12/on-advantages-of-datetime2n-over.html
[nolock]: https://docs.microsoft.com/en-us/sql/t-sql/queries/hints-transact-sql-table?view=sql-server-ver15
[two-part-names]: https://blog.greglow.com/2019/04/22/t-sql-101-14-using-two-part-names-for-sql-server-tables-and-other-objects/
[sql-server-conventions]: https://github.com/ktaranov/sqlserver-kit/blob/master/SQL%20Server%20Name%20Convention%20and%20T-SQL%20Programming%20Style.md#sql-server-name-convention-and-t-sql-programming-style
