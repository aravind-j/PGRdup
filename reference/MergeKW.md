# Merge keyword strings

These functions merge keyword strings separated by delimiters such as
space, period or dash in a character vector into single keyword strings.

## Usage

``` r
MergeKW(x, y, delim = c("space", "dash", "period"))

MergePrefix(x, y, delim = c("space", "dash", "period"))

MergeSuffix(x, y, delim = c("space", "dash", "period"))
```

## Arguments

- x:

  A character vector. If not, coerced to character by `as.character`.

- y:

  A list of character vectors with pairs of strings that are to be
  merged (for `MergeKW`) or a character vector of strings which are to
  be merged to succeeding string (for `MergePrefix`) or the preceding
  string (for `MergeSuffix`). If not of type character, coerced by
  `as.character`.

- delim:

  Delimiting characters to be removed between keywords.

## Value

A character vector of the same length as `x` with the required keyword
strings merged.

## Details

These functions aid in standardization of relevant data fields(columns)
in PGR passport data for creation of a KWIC index with
[`KWIC`](https://aravind-j.github.io/PGRdup/reference/KWIC.md) function
and subsequent identification of probable duplicate accessions by the
[`ProbDup`](https://aravind-j.github.io/PGRdup/reference/ProbDup.md)
function.

It is recommended to run this function before using the
[`DataClean`](https://aravind-j.github.io/PGRdup/reference/DataClean.md)
function on the relevant data fields(columns) of PGR passport databases.

`MergeKW` merges together pairs of strings specified as a list in
argument `y` wherever they exist in a character vector. The second
string in the pair is merged even when it is followed by a number.

`MergePrefix` merges prefix strings specified as a character vector in
argument `y` to the succeeding root word, wherever they exist in a
character vector.

`MergeSuffix` merges suffix strings specified as a character vector in
argument `y` to the preceding root word, wherever they exist in a
character vector. The suffix strings which are followed by numbers are
also merged.

## See also

[`DataClean`](https://aravind-j.github.io/PGRdup/reference/DataClean.md),
[`KWIC`](https://aravind-j.github.io/PGRdup/reference/KWIC.md),
[`ProbDup`](https://aravind-j.github.io/PGRdup/reference/ProbDup.md)

## Examples

``` r
names <- c("Punjab Bold", "Gujarat- Dwarf", "Nagpur.local", "SAM COL 144",
           "SAM COL--280", "NIZAMABAD-LOCAL", "Dark Green Mutant",
           "Dixie-Giant", "Georgia- Bunch", "Uganda-erect", "Small Japan",
           "Castle  Cary", "Punjab erect", "Improved small japan",
           "Dark Purple")

# Merge pairs of strings
y1 <- list(c("Gujarat", "Dwarf"), c("Castle", "Cary"), c("Small", "Japan"),
           c("Big", "Japan"), c("Mani", "Blanco"), c("Uganda", "Erect"),
           c("Mota", "Company"))
names <- MergeKW(names, y1, delim = c("space", "dash", "period"))

# Merge prefix strings
y2 <- c("Light", "Small", "Improved", "Punjab", "SAM")
names <- MergePrefix(names, y2, delim = c("space", "dash", "period"))

# Merge suffix strings
y3 <- c("Local", "Bold", "Cary", "Mutant", "Runner", "Giant", "No.",
        "Bunch", "Peanut")
names <- MergeSuffix(names, y3, delim = c("space", "dash", "period"))
```
