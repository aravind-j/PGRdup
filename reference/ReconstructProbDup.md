# Reconstruct an object of class ProbDup

`ReconstructProbDup` reconstructs a data frame of probable duplicate
sets created using the function `ReviewProbDup` and subjected to manual
clerical review, back into an object of class `ProbDup`.

## Usage

``` r
ReconstructProbDup(rev)
```

## Arguments

- rev:

  A data frame with the the core columns(fields) `SET_NO`, `TYPE`, `K`,
  `PRIM_ID`, `DEL`, `SPLIT`, `COUNT` and `IDKW`

## Value

An object of class `ProbDup` with the modified fuzzy, phonetic and
semantic probable duplicate sets according to the instructions specified
under clerical review.

## Details

A data frame created using the function
[`ReviewProbDup`](https://aravind-j.github.io/PGRdup/reference/ReviewProbDup.md)
from an object of class `ProbDup` for manual clerical review of
identified probable duplicate sets can be reconstituted back to the same
object after the review using this function. The instructions for
modifying the sets entered in the appropriate format in the columns
`DEL` and `SPLIT` during clerical review are taken into account for
reconstituting the probable duplicate sets.

Any records with `Y` in column `DEL` are deleted and records with
identical integers in the column `SPLIT` other than the default `0` are
reassembled into a new set.

## See also

[`ProbDup`](https://aravind-j.github.io/PGRdup/reference/ProbDup.md),
[`ReviewProbDup`](https://aravind-j.github.io/PGRdup/reference/ReviewProbDup.md)

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

# Examine and make changes to a set
subset(RevGNdup, SET_NO==12 & TYPE=="P", select= c(IDKW, DEL, SPLIT))
RevGNdup[c(110, 112, 114, 118, 121, 122, 124), 6] <- "Y"
RevGNdup[c(111, 115, 128), 7] <- 1
RevGNdup[c(113, 117, 120), 7] <- 2
RevGNdup[c(116, 119), 7] <- 3
RevGNdup[c(123, 125), 7] <- 4
RevGNdup[c(126, 127), 7] <- 5
subset(RevGNdup, SET_NO==12 & TYPE=="P", select= c(IDKW, DEL, SPLIT))

# Reconstruct ProDup object
GNdup2 <- ReconstructProbDup(RevGNdup)
lapply(disGNdup, nrow)
lapply(GNdup2, nrow)

} # }

```
