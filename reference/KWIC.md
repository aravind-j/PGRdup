# Create a KWIC index

`KWIC` creates a Keyword in Context index from PGR passport database
fields.

## Usage

``` r
KWIC(x, fields, min.freq = 10)
```

## Arguments

- x:

  A data frame from which KWIC index is to be generated.

- fields:

  A character vector with the names of fields(columns) of the data frame
  from which KWIC index is to be generated. The first field is
  considered as the primary key or identifier (see **Details**).

- min.freq:

  Frequency of keywords are not computed if below `min.freq`. Default is
  10.

## Value

A list of class `KWIC` containing the following components:

|               |                                                                                                      |
|---------------|------------------------------------------------------------------------------------------------------|
| `KWIC`        | The KWIC index in the form of a data frame.                                                          |
| `KeywordFreq` | A data frame of the keywords detected with frequency greater than `min.freq`.                        |
| `Fields`      | A character vector with the names of the PGR database fields from which the keywords were extracted. |

## Details

The function generates a Keyword in Context index from a data frame of a
PGR passport database based on the fields(columns) stated in the
arguments, using
[`data.table`](https://rdatatable.gitlab.io/data.table/reference/data.table.html)
package.

The first element of vector `fields` is considered as the primary key or
identifier which uniquely identifies all rows in the data frame.

Cleaning of the data the input fields(columns) using the
[`DataClean`](https://aravind-j.github.io/PGRdup/reference/DataClean.md)
function with appropriate arguments is suggested before running this
function.

## References

Knüpffer, H. 1988. "The European Barley Database of the ECP/GR: An
Introduction." *Die Kulturpflanze* 36 (1): 135-62.
[doi:10.1007/BF01986957](https://doi.org/10.1007/BF01986957) .

Knüpffer, H., L. Frese, and M. W. M. Jongen. 1997. "Using Central Crop
Databases: Searching for Duplicates and Gaps." In *Central Crop
Databases: Tools for Plant Genetic Resources Management. Report of a
Workshop, Budapest, Hungary, 13-16 October 1996*, edited by E. Lipman,
M. W. M. Jongen, T. J. L. van Hintum, T. Gass, and L. Maggioni, 67-77.
Rome, Italy and Wageningen, The Netherlands: International Plant Genetic
Resources Institute and Centre for Genetic Resources.

## See also

[`data.table`](https://rdatatable.gitlab.io/data.table/reference/data.table.html),
[`print.KWIC`](https://aravind-j.github.io/PGRdup/reference/print.KWIC.md)

## Examples

``` r

# Load PGR passport database
GN <- GN1000

# Specify as a vector the database fields to be used
GNfields <- c("NationalID", "CollNo", "DonorID", "OtherID1", "OtherID2")

# Clean the data
GN[GNfields] <- lapply(GN[GNfields], function(x) DataClean(x))

if (FALSE) { # \dontrun{

# Generate KWIC index
GNKWIC <- KWIC(GN, GNfields)
GNKWIC

# Retrieve the KWIC index from the KWIC object
KWIC <- GNKWIC[[1]]

# Retrieve the keyword frequencies from the KWIC object
KeywordFreq <- GNKWIC[[2]]

# Show error in case of duplicates and NULL values
# in the primary key/ID field "NationalID"
GN[1001:1005,] <- GN[1:5,]
GN[1001,3] <- ""
GNKWIC <- KWIC(GN, GNfields)
} # }

```
