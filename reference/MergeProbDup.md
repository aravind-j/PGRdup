# Merge two objects of class `ProbDup`

`MergeProbDup` merges two objects of class `ProbDup` into a single one.

## Usage

``` r
MergeProbDup(pdup1, pdup2)
```

## Arguments

- pdup1:

  An object of class `ProbDup`.

- pdup2:

  An object of class `ProbDup`.

## Value

An object of class `ProbDup` with the merged list of fuzzy, phonetic and
semantic probable duplicate sets.

## See also

[`ProbDup`](https://aravind-j.github.io/PGRdup/reference/ProbDup.md),
[`SplitProbDup`](https://aravind-j.github.io/PGRdup/reference/SplitProbDup.md)

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
                 
# Split the probable duplicate sets
GNdupSplit <- SplitProbDup(GNdup, splitat = c(10, 10, 10))

# Merge the split sets
GNdupMerged <- MergeProbDup(GNdupSplit[[1]], GNdupSplit[[3]])

} # }

```
