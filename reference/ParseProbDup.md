# Parse an object of class `ProbDup` to a data frame.

`ParseProbDup` converts an object of class `ProbDup` to a data frame for
export.

## Usage

``` r
ParseProbDup(pdup, max.count = 30, insert.blanks = TRUE)
```

## Arguments

- pdup:

  An object of class `ProbDup`.

- max.count:

  The maximum count of probable duplicate sets which are to be parsed to
  a data frame.

- insert.blanks:

  logical. If `TRUE`, inserts a row of `NAs` after each set.

## Value

A data frame of the long/narrow form of the probable duplicate sets data
with the following core columns:

|           |                                                                                                                              |
|-----------|------------------------------------------------------------------------------------------------------------------------------|
| `SET_NO`  | The set number.                                                                                                              |
| `TYPE`    | The type of probable duplicate set. 'F' for fuzzy, 'P' for phonetic and 'S' for semantic matching sets.                      |
| `K`       | The KWIC index or database of origin of the record. The `method` is specified within the square brackets in the column name. |
| `PRIM_ID` | The primary ID of the accession record from which the set could be identified.                                               |
| `IDKW`    | The 'matching' keywords along with the IDs.                                                                                  |
| `COUNT`   | The number of elements in a set.                                                                                             |

For the retrieved columns(fields) the prefix `K*` indicates the KWIC
index of origin.

## See also

[`ProbDup`](https://aravind-j.github.io/PGRdup/reference/ProbDup.md),

## Examples

``` r

if (FALSE) { # \dontrun{

#' # Load PGR passport database
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
                 
# Convert to data frame of sets               
GNdupParsed <- ParseProbDup(GNdup)

} # }

```
