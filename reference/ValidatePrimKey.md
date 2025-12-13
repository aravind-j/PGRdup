# Validate if a data frame column confirms to primary key/ID constraints

`ValidatePrimKey` checks if a column in a data frame confirms to the
primary key/ID constraints of absence of duplicates and NULL values.
Aberrant records if encountered are returned in the output list.

## Usage

``` r
ValidatePrimKey(x, prim.key)
```

## Arguments

- x:

  A data frame.

- prim.key:

  A character vector indicating the name of the data frame column to be
  validated for primary key/ID constraints (see **Details**).

## Value

A list with containing the following components:

|               |                                                                                                            |
|---------------|------------------------------------------------------------------------------------------------------------|
| `message1`    | Indicates whether duplicated values were encountered in `prim.key` field(column) of data frame `x` or not. |
| `Duplicates`  | A data frame of the records with duplicated prim.key values if they were encountered.                      |
| `message2`    | Indicates whether NULL values were encountered in `prim.key` field(column) of data frame `x` or not.       |
| `NullRecords` | A data frame of the records with NULL prim.key values if they were encountered.                            |

## Details

The function checks whether a field(column) in a data frame of PGR
passport database confirms to the primary key/ID constraints of absence
of duplicates and NULL values. If records with nonconforming values in
the column are encountered, they are returned in the output list for
rectification.

If multiple fields(columns) are given as a character vector in
`prim.key` field, only the first element will be considered as the
primary key/ID field(column).

Cleaning of the data in the input field(column) using the
[`DataClean`](https://aravind-j.github.io/PGRdup/reference/DataClean.md)
function with appropriate arguments is suggested before running this
function.

It is recommended to run this function and rectify aberrant records in a
PGR passport database before creating a KWIC index using the
[`KWIC`](https://aravind-j.github.io/PGRdup/reference/KWIC.md) function.

## See also

[`DataClean`](https://aravind-j.github.io/PGRdup/reference/DataClean.md),
[`KWIC`](https://aravind-j.github.io/PGRdup/reference/KWIC.md)

## Examples

``` r
GN <- GN1000
ValidatePrimKey(x=GN, prim.key="NationalID")
#> OK: No duplicated records found in prim.key field
#> OK: No NULL records found in prim.key field
#> $message1
#> [1] "OK: No duplicated records found in prim.key field"
#> 
#> $Duplicates
#> NULL
#> 
#> $message2
#> [1] "OK: No NULL records found in prim.key field"
#> 
#> $NullRecords
#> NULL
#> 
if (FALSE) { # \dontrun{
# Show error in case of duplicates and NULL values 
# in the primary key/ID field "NationalID"
GN[1001:1005,] <- GN[1:5,]
GN[1001,3] <- ""
ValidatePrimKey(x=GN, prim.key="NationalID")} # }
```
