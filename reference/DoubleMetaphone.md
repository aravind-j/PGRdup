# 'Double Metaphone' phonetic algorithm

`DoubleMetaphone` converts strings to double metaphone phonetic codes.

## Usage

``` r
DoubleMetaphone(str)
```

## Arguments

- str:

  A character vector whose strings are to be encoded by double metaphone
  algorithm.

## Value

Returns a list with two character vectors of the same length as the
input vector. The first character vector contains the primary double
metaphone encodings, while the second character vector contains the
alternate encodings.

## Details

An implementation of the Double Metaphone phonetic algorithm in `R`. If
non-ASCII characters encountered in the input character vector `str`, a
warning is issued and they are transliterated so that the accented
characters are converted to their ASCII unaccented versions.

## Note

In case of non-ASCII characters in strings, a warning is issued and
accented characters are converted to their ASCII unaccented versions.

## Acknowledgement

The `C` code for the double metaphone algorithm was adapted from Maurice
Aubrey's perl module hosted at the **gitpan/Text-DoubleMetaphone**
[public github
library](https://github.com/gitpan/Text-DoubleMetaphone/blob/master/double_metaphone.c)
along with the corresponding [license
information](https://github.com/gitpan/Text-DoubleMetaphone/blob/master/README).

## References

Philips, Lawrence. 2000. "The Double Metaphone Search Algorithm." *C/C++
Users Journal* 18 (6): 38-43.
<https://dl.acm.org/doi/10.5555/349124.349132>.

## See also

[`phonetic`](https://rdrr.io/pkg/stringdist/man/phonetic.html),
[`phonetics`](https://cran.r-project.org/package=RecordLinkage)

## Examples

``` r
# Return the primary and secondary Double Metaphone encodings for a character vector.
str1 <- c("Jyothi", "Jyoti")
str2 <- c("POLLACHI", "BOLLACHI")
DoubleMetaphone(str1)
#> $primary
#> [1] "J0" "JT"
#> 
#> $alternate
#> [1] "AT" "AT"
#> 
DoubleMetaphone(str2)
#> $primary
#> [1] "PLX" "PLX"
#> 
#> $alternate
#> [1] "PLK" "PLK"
#> 
if (FALSE) { # \dontrun{
# Issue a warning in case of non-ASCII characters.
str3 <- c("J\xf5geva", "Jogeva")
DoubleMetaphone(str3) } # }
```
