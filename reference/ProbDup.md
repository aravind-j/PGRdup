# Identify probable duplicates of accessions

`ProbDup` identifies probable duplicates of germplasm accessions in KWIC
indexes created from PGR passport databases using fuzzy, phonetic and
semantic matching strategies.

## Usage

``` r
ProbDup(
  kwic1,
  kwic2 = NULL,
  method = c("a", "b", "c"),
  excep = NULL,
  chunksize = 1000,
  useBytes = TRUE,
  fuzzy = TRUE,
  max.dist = 3,
  force.exact = TRUE,
  max.alpha = 4,
  max.digit = Inf,
  phonetic = TRUE,
  encoding = c("primary", "alternate"),
  phon.min.alpha = 5,
  min.enc = 3,
  semantic = FALSE,
  syn = NULL
)
```

## Arguments

- kwic1:

  An object of class `KWIC`.

- kwic2:

  An object of class `KWIC`. Required for `method` `"b"` and `"c"` only
  (see **Details**).

- method:

  The method to be followed for identification of probable duplicates.
  Either `"a"`, `"b"` or `"c"`. (see **Details**).

- excep:

  A vector of the keywords in KWIC not to be used for probable duplicate
  search (see **Details**).

- chunksize:

  A value indicating the size of KWIC index keyword block to be used for
  searching for matches at a time in case of large number of
  keywords(see **Note**).

- useBytes:

  logical. If `TRUE`, performs byte-wise comparison instead of
  character-wise comparison (see **Note**).

- fuzzy:

  logical. If `TRUE` identifies probable duplicates based on fuzzy
  matching.

- max.dist:

  The maximum levenshtein distance between keyword strings allowed for a
  match. Default is 3 (see **Details**).

- force.exact:

  logical. If `TRUE`, enforces exact matching instead of fuzzy matching
  for keyword strings which match the criteria specified in arguments
  `max.alpha` and `max.digit` (see **Details**).

- max.alpha:

  Maximum number of alphabet characters present in a keyword string up
  to which exact matching is enforced rather than fuzzy matching.
  Default is 4 (see **Details**).

- max.digit:

  Maximum number of numeric characters present in a keyword string up to
  which exact matching is enforced rather than fuzzy matching. Default
  is Inf (see **Details**).

- phonetic:

  logical. If `TRUE` identifies probable duplicates based on phonetic
  matching.

- encoding:

  Double metaphone encoding for phonetic matching. The default is
  `"primary"` (see **Details**).

- phon.min.alpha:

  Minimum number of alphabet characters to be present in a keyword
  string for phonetic matching (see **Details**).

- min.enc:

  Minimum number of characters to be be present in double metaphone
  encoding of a keyword string for phonetic matching (see **Details**).

- semantic:

  logical. If `TRUE` identifies probable duplicates based on semantic
  matching.

- syn:

  A list with character vectors of synsets (see **Details**).

## Value

A list of class `ProbDup` containing the following data frames of
probable duplicate sets identified along with the corresponding keywords
and set counts:

1.  `FuzzyDuplicates`

2.  `PhoneticDuplicates`

3.  `SemanticDuplicates`

Each data frame has the following columns:

|          |                                                                                                         |
|----------|---------------------------------------------------------------------------------------------------------|
| `SET_NO` | The set number.                                                                                         |
| `TYPE`   | The type of probable duplicate set. 'F' for fuzzy, 'P' for phonetic and 'S' for semantic matching sets. |
| `ID`     | The primary IDs of records of accessions comprising a set.                                              |
| `ID:KW`  | The 'matching' keywords along with the IDs.                                                             |
| `COUNT`  | The number of elements in a set.                                                                        |

The prefix `[K*]` indicates the KWIC index of origin of the KEYWORD or
PRIM_ID.

## Details

This function performs fuzzy, phonetic and semantic matching of keywords
in KWIC indexes of PGR passport databases (created using
[`KWIC`](https://aravind-j.github.io/PGRdup/reference/KWIC.md) function)
to identify probable duplicates of germplasm accessions. The function
can execute matching according to either of the following three methods
as specified by the `method` argument.

- Method `a`::

  Perform string matching of keywords in a single KWIC index to identify
  probable duplicates of accessions in a single PGR passport database.

- Method `b`::

  Perform string matching of keywords in the first KWIC index (query)
  with that of the keywords in the second index (source) to identify
  probable duplicates of accessions of the first PGR passport database
  among the accessions in the second database.

- Method `c`::

  Perform string matching of keywords in two different KWIC indexes
  jointly to identify probable duplicates of accessions from among two
  PGR passport databases.

**Fuzzy matching** or approximate string matching of keywords is carried
out by computing the generalized levenshtein (edit) distance between
them. This distance measure counts the number of deletions, insertions
and substitutions necessary to turn one string to the another. A
distance of up to `max.dist` are considered for a match.

Exact matching will be enforced when the argument `force.exact` is
`TRUE`. It can be used to avoid fuzzy matching when the number of
alphabet characters in keywords is lesser than a critical value
(`max.alpha`). Similarly, the value of `max.digit` can also be set
according to the requirements. The default value of `Inf` avoids fuzzy
matching and enforces exact matching for all keywords having any
numerical characters. If `max.digit` and `max.alpha` are both set to
`Inf`, exact matching will be enforced for all the keywords.

When exact matching is enforced, for keywords having both alphabet and
numeric characters and with the number of alphabet characters greater
than `max.digit`, matching will be carried out separately for alphabet
and numeric characters present.

**Phonetic matching** of keywords is carried out using the Double
Metaphone phonetic algorithm
([`DoubleMetaphone`](https://aravind-j.github.io/PGRdup/reference/DoubleMetaphone.md))
to identify keywords that have the similar pronunciation. Either the
`primary` or `alternate` encodings can be used by specifying the
`encoding` argument. The argument `phon.min.alpha` sets the limits for
the number of alphabet characters to be present in a string for
executing phonetic matching. Similarly `min.enc` sets the limits for the
number of characters to be present in the encoding of a keyword for
phonetic matching.

**Semantic matching** matches keywords based on a list of accession name
synonyms supplied as list with character vectors of synonym sets
(synsets) to the `syn` argument. Synonyms in this context refers to
interchangeable identifiers or names by which an accession is
recognized. Multiple keywords specified as members of the same synset in
`syn` are merged together. To facilitate accurate identification of
synonyms from the KWIC index, identical data standardization operations
using the
[`MergeKW`](https://aravind-j.github.io/PGRdup/reference/MergeKW.md) and
[`DataClean`](https://aravind-j.github.io/PGRdup/reference/DataClean.md)
functions for both the original database fields and the synset list are
recommended.

The probable duplicate sets identified initially here may be
intersecting with other sets. To get the disjoint sets after the union
of all the intersecting sets use the
[`DisProbDup`](https://aravind-j.github.io/PGRdup/reference/DisProbDup.md)
function.

The function
[`AddProbDup`](https://aravind-j.github.io/PGRdup/reference/AddProbDup.md)
can be used to add the information associated with the identified sets
in an object of class `ProbDup` as fields(columns) to the original PGR
passport database.

All of the string matching operations here are executed through the
[`stringdist-package`](https://rdrr.io/pkg/stringdist/man/stringdist-package.html)
functions.

## Note

As the number of keywords in the KWIC indexes increases, the memory
consumption by the function also increases. For string matching, this
function relies upon creation of a \\n\\\*\\m\\ matrix of all possible
keyword pairs for comparison, where \\n\\ and \\m\\ are the number of
keywords in the query and source indexes respectively. This can lead to
`cannot allocate vector of size` errors in case very large KWIC indexes
where the comparison matrix is too large to reside in memory. In such a
case, try to adjust the `chunksize` argument to get the appropriate size
of the KWIC index keyword block to be used for searching for matches at
a time. However a smaller chunksize may lead to longer computation time
due to the memory-time trade-off.

The progress of matching is displayed in the console as number of blocks
completed out of total (e.g. 6 / 30), the percentage of achievement
(e.g. 30%) and a text-based progress bar.

In case of multi-byte characters in keywords, the matching speed is
further dependent upon the `useBytes` argument as described in
**Encoding issues** for the
[`stringdist`](https://rdrr.io/pkg/stringdist/man/stringdist.html)
function, which is made use of here for string matching.

## References

van der Loo, M. P. J. 2014. "The Stringdist Package for Approximate
String Matching." *R Journal* 6 (1):111-22.
<https://journal.r-project.org/articles/RJ-2014-011/index.html>.

## See also

[`KWIC`](https://aravind-j.github.io/PGRdup/reference/KWIC.md),
[`DoubleMetaphone`](https://aravind-j.github.io/PGRdup/reference/DoubleMetaphone.md)
[`stringdistmatrix`](https://rdrr.io/pkg/stringdist/man/stringdist.html),
[`adist`](https://rdrr.io/r/utils/adist.html),
[`print.ProbDup`](https://aravind-j.github.io/PGRdup/reference/print.ProbDup.md)

## Examples

``` r

if (FALSE) { # \dontrun{

# Method "a"
#===========

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
GNdup

# Method "b and c"
#=================

# Load PGR passport databases
GN1 <- GN1000[!grepl("^ICG", GN1000$DonorID), ]
GN1$DonorID <- NULL
GN2 <- GN1000[grepl("^ICG", GN1000$DonorID), ]
GN2 <- GN2[!grepl("S", GN2$DonorID), ]
GN2$NationalID <- NULL

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

# Fetch probable duplicate sets
GNdupb <- ProbDup(kwic1 = GN1KWIC, kwic2 = GN2KWIC, method = "b",
                  excep = exep, fuzzy = TRUE, phonetic = TRUE,
                  encoding = "primary", semantic = TRUE, syn = syn)
GNdupb

GNdupc <- ProbDup(kwic1 = GN1KWIC, kwic2 = GN2KWIC, method = "c",
                  excep = exep, fuzzy = TRUE, phonetic = TRUE,
                  encoding = "primary", semantic = TRUE, syn = syn)
GNdupc

} # }

```
