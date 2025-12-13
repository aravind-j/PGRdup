# Visualize the probable duplicate sets retrieved in a `ProbDup` object

`ViewProbDup` plots summary visualizations of accessions within the
probable duplicate sets retrieved in a `ProbDup` object according to a
grouping factor field(column) in the original database(s).

## Usage

``` r
ViewProbDup(
  pdup,
  db1,
  db2 = NULL,
  factor.db1,
  factor.db2 = NULL,
  max.count = 30,
  select,
  order = "type",
  main = NULL
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

- factor.db1:

  The `db1` column to be considered for grouping the accessions. Should
  be of class character or factor.

- factor.db2:

  The `db2` column to be considered for grouping the accessions. Should
  be of class character or factor. retrieved.

- max.count:

  The maximum count of probable duplicate sets whose information is to
  be plotted (see **Note**).

- select:

  A character vector of factor names in `factor.db1` and/or `factor.db2`
  to be considered for grouping accessions (see **Note**).

- order:

  The order of the type of sets retrieved in the plot. The default is
  `"type"` (see **Details**).

- main:

  The title of the plot.

## Value

A list containing the following objects:

|               |                                                                                                                        |
|---------------|------------------------------------------------------------------------------------------------------------------------|
| `Summary1`    | The summary `data.frame` of number of accessions per factor level.                                                     |
| `Summary2`    | The summary `data.frame` of number of accessions and sets per each type of sets classified according to factor levels. |
| `SummaryGrob` | A grid graphical object (Grob) of the summary visualization plot. Can be plotted using the `grid.arrange` function     |

## Note

When any primary ID/key records in the fuzzy, phonetic or semantic
duplicate sets are found to be missing from the original databases `db1`
and `db2`, then they are ignored and only the matching records are
considered for visualization.

This may be due to data standardization of the primary ID/key field
using the function
[`DataClean`](https://aravind-j.github.io/PGRdup/reference/DataClean.md)
before creation of the KWIC index and subsequent identification of
probable duplicate sets. In such a case, it is recommended to use an
identical data standardization operation on the databases `db1` and
`db2` before running this function. For summary and visualization of the
set information in the object of class `ProbDup` by `ViewProbDup`, the
disjoint of the retrieved sets are made use of, as they are more
meaningful than the raw sets retrieved. So it is recommended that the
disjoint of sets obtained using the `DisProbDup` be used as the input
`pdup`.

All the accession records in sets with count \> `max.count` will be
considered as being unique.

The factor levels in the `factor.db1` and/or `factor.db2` columns
corresponding to those mentioned in `select` argument alone will be
considered for visualization. All other factor levels will be grouped
together to a single level named "Others".

The argument `order` can be used to specify the order in which the type
of sets retrieved are to be plotted in the visualization. The default
`"type"` will order according to the kind of sets, `"sets"` will order
according to the number of sets in each kind and `"acc"` will order
according to the number of accessions in each kind.

The individual plots are made using
[`ggplot`](https://ggplot2.tidyverse.org/reference/ggplot.html) and then
grouped together using
[`gridExtra-package`](https://rdrr.io/pkg/gridExtra/man/gridExtra-package.html).

## See also

[`ProbDup`](https://aravind-j.github.io/PGRdup/reference/ProbDup.md),
[`DisProbDup`](https://aravind-j.github.io/PGRdup/reference/DisProbDup.md),
[`DataClean`](https://aravind-j.github.io/PGRdup/reference/DataClean.md),
[`ggplot`](https://ggplot2.tidyverse.org/reference/ggplot.html),
[`gridExtra-package`](https://rdrr.io/pkg/gridExtra/man/gridExtra-package.html)

## Examples

``` r

if (FALSE) { # \dontrun{

# Method "b and c"
#=================

# Load PGR passport databases
GN1 <- GN1000[!grepl("^ICG", GN1000$DonorID), ]
GN1$DonorID <- NULL
GN2 <- GN1000[grepl("^ICG", GN1000$DonorID), ]
GN2 <- GN2[!grepl("S", GN2$DonorID), ]
GN2$NationalID <- NULL

GN1$SourceCountry <- toupper(GN1$SourceCountry)
GN2$SourceCountry <- toupper(GN2$SourceCountry)

GN1$SourceCountry <- gsub("UNITED STATES OF AMERICA", "USA", GN1$SourceCountry)
GN2$SourceCountry <- gsub("UNITED STATES OF AMERICA", "USA", GN2$SourceCountry)

# Specify as a vector the database fields to be used
GN1fields <- c("NationalID", "CollNo", "OtherID1", "OtherID2")
GN2fields <- c("DonorID", "CollNo", "OtherID1", "OtherID2")

# Clean the data
GN1[GN1fields] <- lapply(GN1[GN1fields], function(x) DataClean(x))
GN2[GN2fields] <- lapply(GN2[GN2fields], function(x) DataClean(x))
y1 <- list(c("Gujarat", "Dwarf"), c("Castle", "Cary"), c("Small", "Japan"),
           c("Big", "Japan"), c("Mani", "Blanco"), c("Uganda", "Erect"),
           c("Mota", "Company"))
y2 <- c("Dark", "Light", "Small", "Improved", "Punjab", "SAM")
y3 <- c("Local", "Bold", "Cary", "Mutant", "Runner", "Giant", "No.",
        "Bunch", "Peanut")
GN1[GN1fields] <- lapply(GN1[GN1fields], function(x) MergeKW(x, y1, delim = c("space", "dash")))
GN1[GN1fields] <- lapply(GN1[GN1fields], function(x) MergePrefix(x, y2, delim = c("space", "dash")))
GN1[GN1fields] <- lapply(GN1[GN1fields], function(x) MergeSuffix(x, y3, delim = c("space", "dash")))
GN2[GN2fields] <- lapply(GN2[GN2fields], function(x) MergeKW(x, y1, delim = c("space", "dash")))
GN2[GN2fields] <- lapply(GN2[GN2fields], function(x) MergePrefix(x, y2, delim = c("space", "dash")))
GN2[GN2fields] <- lapply(GN2[GN2fields], function(x) MergeSuffix(x, y3, delim = c("space", "dash")))

# Remove duplicated DonorID records in GN2
GN2 <- GN2[!duplicated(GN2$DonorID), ]

# Generate KWIC index
GN1KWIC <- KWIC(GN1, GN1fields)
GN2KWIC <- KWIC(GN2, GN2fields)

# Specify the exceptions as a vector
exep <- c("A", "B", "BIG", "BOLD", "BUNCH", "C", "COMPANY", "CULTURE",
          "DARK", "E", "EARLY", "EC", "ERECT", "EXOTIC", "FLESH", "GROUNDNUT",
          "GUTHUKAI", "IMPROVED", "K", "KUTHUKADAL", "KUTHUKAI", "LARGE",
          "LIGHT", "LOCAL", "OF", "OVERO", "P", "PEANUT", "PURPLE", "R",
          "RED", "RUNNER", "S1", "SAM", "SMALL", "SPANISH", "TAN", "TYPE",
          "U", "VALENCIA", "VIRGINIA", "WHITE")

# Specify the synsets as a list
syn <- list(c("CHANDRA", "AH114"), c("TG1", "VIKRAM"))

GNdupc <- ProbDup(kwic1 = GN1KWIC, kwic2 = GN2KWIC, method = "c",
                  excep = exep, fuzzy = TRUE, phonetic = TRUE,
                  encoding = "primary", semantic = TRUE, syn = syn)

GNdupcView <- ViewProbDup(GNdupc, GN1, GN2, "SourceCountry", "SourceCountry",
                         max.count = 30, select = c("INDIA", "USA"), order = "type",
                         main = "Groundnut Probable Duplicates")

library(gridExtra)                                                    
grid.arrange(GNdupcView$SummaryGrob)                          

} # }   

    
```
