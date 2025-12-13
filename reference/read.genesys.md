# Convert 'Darwin Core - Germplasm' zip archive to a flat file

`read.genesys` reads PGR data in a Darwin Core - germplasm zip archive
downloaded from genesys database and creates a flat file `data.frame`
from it.

## Usage

``` r
read.genesys(zip.genesys, scrub.names.space = TRUE, readme = TRUE)
```

## Arguments

- zip.genesys:

  A character vector giving the file path to the downloaded zip file
  from Genesys.

- scrub.names.space:

  logical. If `TRUE`, all space characters are removed from name field
  in names extension (see **Details**).

- readme:

  logical. If `TRUE`, the genesys zip file readme is printed to console.

## Value

A data.frame with the flat file form of the genesys data.

## Details

This function helps to import to R environment, the PGR data downloaded
from genesys database <https://www.genesys-pgr.org/> as a Darwin Core -
germplasm (DwC-germplasm) zip archive. The different csv files in the
archive are merged as a flat file into a single `data.frame`.

All the space characters can be removed from the fields corresponding to
accession names such as acceNumb, collNumb, ACCENAME, COLLNUMB,
DONORNUMB and OTHERNUMB using the argument `scrub.names.space` to
facilitate creation of KWIC index with
[`KWIC`](https://aravind-j.github.io/PGRdup/reference/KWIC.md) function
and subsequent matching operations to identify probable duplicates with
[`ProbDup`](https://aravind-j.github.io/PGRdup/reference/ProbDup.md)
function.

The argument `readme` can be used to print the readme file in the
archive to console, if required.

## See also

[`data.table`](https://rdatatable.gitlab.io/data.table/reference/data.table.html)

## Examples

``` r

if (FALSE) { # \dontrun{
# Import the DwC-Germplasm zip archive "genesys-accessions-filtered.zip"
PGRgenesys <- read.genesys("genesys-accessions-filtered.zip",
                           scrub.names.space = TRUE, readme = TRUE)
} # }

```
