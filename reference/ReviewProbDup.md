# Retrieve probable duplicate set information from PGR passport database for review

`ReviewProbDup` retrieves information associated with the probable
duplicate sets from the original PGR passport database(s) from which
they were identified in order to facilitate manual clerical review.

## Usage

``` r
ReviewProbDup(
  pdup,
  db1,
  db2 = NULL,
  extra.db1 = NULL,
  extra.db2 = NULL,
  max.count = 30,
  insert.blanks = TRUE
)
```

## Arguments

- pdup:

  An object of class `ProbDup`.

- db1:

  A data frame of the PGR passport database.

- db2:

  A data frame of the PGR passport database. Required when `pdup` was
  created using more than one KWIC Index.

- extra.db1:

  A character vector of extra `db1` column names to be retrieved.

- extra.db2:

  A character vector of extra `db2` column names to be retrieved.

- max.count:

  The maximum count of probable duplicate sets whose information is to
  be retrieved.

- insert.blanks:

  logical. If `TRUE`, inserts a row of `NAs` after each set.

## Value

A data frame of the long/narrow form of the probable duplicate sets data
along with associated fields from the original database(s). The core
columns in the resulting data frame are as follows:

|           |                                                                                                                              |
|-----------|------------------------------------------------------------------------------------------------------------------------------|
| `SET_NO`  | The set number.                                                                                                              |
| `TYPE`    | The type of probable duplicate set. 'F' for fuzzy, 'P' for phonetic and 'S' for semantic matching sets.                      |
| `K[*]`    | The KWIC index or database of origin of the record. The `method` is specified within the square brackets in the column name. |
| `PRIM_ID` | The primary ID of the accession record from which the set could be identified.                                               |
| `IDKW`    | The 'matching' keywords along with the IDs.                                                                                  |
| `DEL`     | Column to indicate whether record has to be deleted or not.                                                                  |
| `SPLIT`   | Column to indicate whether record has to be branched and assembled into new set.                                             |
| `COUNT`   | The number of elements in a set.                                                                                             |

For the retrieved columns(fields) the prefix `K*` indicates the KWIC
index of origin.

## Details

This function helps to retrieve PGR passport information associated with
fuzzy, phonetic or semantic probable duplicate sets in an object of
class `ProbDup` from the original databases(s) from which they were
identified. The original information of accessions comprising a set,
which have not been subjected to data standardization can be compared
under manual clerical review for the validation of the set.

By default only the fields(columns) which were used initially for
creation of the KWIC indexes using the
[`KWIC`](https://aravind-j.github.io/PGRdup/reference/KWIC.md) function
are retrieved. Additional fields(columns) if necessary can be specified
using the `extra.db1` and `extra.db2` arguments.

The output data frame can be subjected to clerical review either after
exporting into an external spreadsheet using
[`write.csv`](https://rdrr.io/r/utils/write.table.html) function or by
using the [`edit`](https://rdrr.io/r/utils/edit.html) function.

The column `DEL` can be used to indicate whether a record has to be
deleted from a set or not. `Y` indicates "Yes", and the default `N`
indicates "No".

The column `SPLIT` similarly can be used to indicate whether a record in
a set has to be branched into a new set. A set of identical integers in
this column other than the default `0` can be used to indicate that they
are to be removed and assembled into a new set.

## Note

When any primary ID/key records in the fuzzy, phonetic or semantic
duplicate sets are found to be missing from the original databases `db1`
and `db2`, then they are ignored and only the matching records are
considered for retrieving the information with a warning.

This may be due to data standardization of the primary ID/key field
using the function
[`DataClean`](https://aravind-j.github.io/PGRdup/reference/DataClean.md)
before creation of the KWIC index and subsequent identification of
probable duplicate sets. In such a case, it is recommended to use an
identical data standardization operation on the databases `db1` and
`db2` before running this function.

With `R` \<= v3.0.2, due to copying of named objects by
[`list()`](https://rdrr.io/r/base/list.html),
`Invalid .internal.selfref detected and fixed...` warning can appear,
which may be safely ignored.

## See also

[`DataClean`](https://aravind-j.github.io/PGRdup/reference/DataClean.md),
[`KWIC`](https://aravind-j.github.io/PGRdup/reference/KWIC.md),
[`ProbDup`](https://aravind-j.github.io/PGRdup/reference/ProbDup.md)

## Examples

``` r

if (FALSE) { # \dontrun{

# Load PGR passport database
GN <- GN1000

# Specify as a vector the database fields to be used
GNfields <- c("NationalID", "CollNo", "DonorID", "OtherID1", "OtherID2")

# Clean the data
GN[GNfields] <- lapply(GN[GNfields], function(x) DataClean(x))
y1 <- list(c("Gujarat", "Dwarf"), c("Castle", "Cary"), c("Small", "Japan"),
c("Big", "Japan"), c("Mani", "Blanco"), c("Uganda", "Erect"),
c("Mota", "Company"))
y2 <- c("Dark", "Light", "Small", "Improved", "Punjab", "SAM")
y3 <- c("Local", "Bold", "Cary", "Mutant", "Runner", "Giant", "No.",
        "Bunch", "Peanut")
GN[GNfields] <- lapply(GN[GNfields], function(x) MergeKW(x, y1, delim = c("space", "dash")))
GN[GNfields] <- lapply(GN[GNfields], function(x) MergePrefix(x, y2, delim = c("space", "dash")))
GN[GNfields] <- lapply(GN[GNfields], function(x) MergeSuffix(x, y3, delim = c("space", "dash")))

# Generate KWIC index
GNKWIC <- KWIC(GN, GNfields)

# Specify the exceptions as a vector
exep <- c("A", "B", "BIG", "BOLD", "BUNCH", "C", "COMPANY", "CULTURE",
         "DARK", "E", "EARLY", "EC", "ERECT", "EXOTIC", "FLESH", "GROUNDNUT",
         "GUTHUKAI", "IMPROVED", "K", "KUTHUKADAL", "KUTHUKAI", "LARGE",
         "LIGHT", "LOCAL", "OF", "OVERO", "P", "PEANUT", "PURPLE", "R",
         "RED", "RUNNER", "S1", "SAM", "SMALL", "SPANISH", "TAN", "TYPE",
         "U", "VALENCIA", "VIRGINIA", "WHITE")

# Specify the synsets as a list
syn <- list(c("CHANDRA", "AH114"), c("TG1", "VIKRAM"))

# Fetch probable duplicate sets
GNdup <- ProbDup(kwic1 = GNKWIC, method = "a", excep = exep, fuzzy = TRUE,
                 phonetic = TRUE, encoding = "primary",
                 semantic = TRUE, syn = syn)

# Get disjoint probable duplicate sets of each kind
disGNdup <- DisProbDup(GNdup, combine = NULL)

# Get the data frame for reviewing the duplicate sets identified
RevGNdup <- ReviewProbDup(pdup = disGNdup, db1 = GN1000,
                          extra.db1 = c("SourceCountry", "TransferYear"),
                          max.count = 30, insert.blanks = TRUE)
# Examine and review the duplicate sets using edit function
RevGNdup <- edit(RevGNdup)

# OR examine and review the duplicate sets after exporting them as a csv file
write.csv(file="Duplicate sets for review.csv", x=RevGNdup)

} # }

```
