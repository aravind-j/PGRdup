# Clean PGR passport data

`DataClean` cleans the data in a character vector according to the
conditions in the arguments.

## Usage

``` r
DataClean(
  x,
  fix.comma = TRUE,
  fix.semcol = TRUE,
  fix.col = TRUE,
  fix.bracket = TRUE,
  fix.punct = TRUE,
  fix.space = TRUE,
  fix.sep = TRUE,
  fix.leadzero = TRUE
)
```

## Arguments

- x:

  A character vector. If not, coerced to character by `as.character`.

- fix.comma:

  logical. If `TRUE`, all the commas are replaced by space (see
  **Details**).

- fix.semcol:

  logical. If `TRUE`, all the semicolons are replaced by space (see
  **Details**).

- fix.col:

  logical. If `TRUE`, all the colons are replaced by space (see
  **Details**).

- fix.bracket:

  logical. If `TRUE`, all the brackets are replaced by space (see
  **Details**).

- fix.punct:

  logical. If `TRUE`, all punctuation characters are removed (see
  **Details**).

- fix.space:

  logical. If `TRUE`, all space characters are replaced by space and
  multiple spaces are converted to single space (see **Details**).

- fix.sep:

  logical. If `TRUE`, space between alphabetic characters followed by
  digits is removed (see **Details**).

- fix.leadzero:

  logical. If `TRUE`, leading zeros are removed (see **Details**).

## Value

A character vector with the cleaned data converted to upper case. `NAs`
if any are converted to blank strings.

## Details

This function aids in standardization and preparation of the PGR
passport data for creation of a KWIC index with
[`KWIC`](https://aravind-j.github.io/PGRdup/reference/KWIC.md) function
and the identification of probable duplicate accessions by the
[`ProbDup`](https://aravind-j.github.io/PGRdup/reference/ProbDup.md)
function. It cleans the character strings in passport data
fields(columns) specified as the input character vector `x` according to
the conditions in the arguments in the same order. If the input vector
`x` is not of type character, it is coerced to a character vector.

This function is designed particularly for use with fields corresponding
to accession names such as accession ids, collection numbers, accession
names etc. It is essentially a wrapper around the
[`gsub`](https://rdrr.io/r/base/grep.html) base function with
[`regex`](https://rdrr.io/r/base/regex.html) arguments. It also converts
all strings to upper case and removes leading and trailing spaces.

Commas, semicolons and colons which are sometimes used to separate
multiple strings or names within the same field can be replaced with a
single space using the logical arguments `fix.comma`, `fix.semcol` and
`fix.col` respectively.

Similarly the logical argument `fix.bracket` can be used to replace all
brackets including parenthesis, square brackets and curly brackets with
space.

The logical argument `fix.punct` can be used to remove all punctuation
from the data.

`fix.space` can be used to convert all space characters such as tab,
newline, vertical tab, form feed and carriage return to spaces and
finally convert multiple spaces to single space.

`fix.sep` can be used to merge together accession identifiers composed
of alphabetic characters separated from as series of digits by a space
character. For example IR 64, PUSA 256 etc.

`fix.leadzero` can be used to remove leading zeros from accession name
fields to facilitate matching to identify probable duplicates. e.g.
IR0064 -\> IR64

## See also

[`gsub`](https://rdrr.io/r/base/grep.html),
[`regex`](https://rdrr.io/r/base/regex.html),
[`MergeKW`](https://aravind-j.github.io/PGRdup/reference/MergeKW.md),
[`KWIC`](https://aravind-j.github.io/PGRdup/reference/KWIC.md),
[`ProbDup`](https://aravind-j.github.io/PGRdup/reference/ProbDup.md)

## Examples

``` r
names <- c("S7-12-6", "ICG-3505", "U 4-47-18;EC 21127", "AH 6481", "RS   1",
           "AK 12-24", "2-5 (NRCG-4053)", "T78, Mwitunde", "ICG 3410",
           "#648-4 (Gwalior)", "TG4;U/4/47/13", "EC0021003")
DataClean(names)
#>  [1] "S7126"          "ICG3505"        "U44718 EC21127" "AH6481"        
#>  [5] "RS1"            "AK1224"         "25 NRCG4053"    "T78 MWITUNDE"  
#>  [9] "ICG3410"        "6484 GWALIOR"   "TG4 U44713"     "EC21003"       
```
