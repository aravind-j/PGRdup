# Add probable duplicate sets fields to the PGR passport database

`AddProbDup` adds the fuzzy, phonetic and semantic probable duplicates
sets data fields from an object of class `ProbDup` to the original PGR
passport database.

## Usage

``` r
AddProbDup(pdup, db, addto = c("I", "II"), max.count = 30)
```

## Arguments

- pdup:

  An object of class `ProbDup`.

- db:

  A data frame of the PGR passport database.

- addto:

  Either `"I"` or `"II"` indicating the database to which the
  data.fields are to be added (see **Details**).

- max.count:

  The maximum count of probable duplicate sets whose information is to
  be retrieved.

## Value

A data frame of the PGR passport database with the probable duplicate
sets fields added.

## Details

This function helps to add information associated with identified fuzzy,
phonetic and semantic probable duplicate sets using the
[`ProbDup`](https://aravind-j.github.io/PGRdup/reference/ProbDup.md)
function to the original PGR passport database. Associated data fields
such as `SET_NO`, `ID` and `IDKW` are added based on the `PRIM_ID`
field(column).

In case more than one KWIC index was used to generate the object of
class `ProbDup`, the argument `addto` can be used to specify to which
database the data fields are to be added. The default `"I"` indicates
the database from which the first KWIC index was created and `"II"`
indicates the database from which the second index was created.

## Note

When any primary ID/key records in the fuzzy, phonetic or semantic
duplicate sets are found to be missing from the original database `db`,
then they are ignored and only the matching records are considered for
adding the information with a warning.

This may be due to data standardization of the primary ID/key field
using the function
[`DataClean`](https://aravind-j.github.io/PGRdup/reference/DataClean.md)
before creation of the KWIC index and subsequent identification of
probable duplicate sets. In such a case, it is recommended to use an
identical data standardization operation on the database `db` before
running this function.

## See also

[`DataClean`](https://aravind-j.github.io/PGRdup/reference/DataClean.md),
[`KWIC`](https://aravind-j.github.io/PGRdup/reference/KWIC.md),
[`ProbDup`](https://aravind-j.github.io/PGRdup/reference/ProbDup.md)

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

# Add the duplicates sets to the original database                 
GNwithdup <-  AddProbDup(pdup = GNdup, db = GN1000, addto = "I")                  

} # }

```
