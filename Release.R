
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

[![minimal R version](https://img.shields.io/badge/R%3E%3D-3.0.2-6666ff.svg)](https://cran.r-project.org/)
[![packageversion](https://img.shields.io/badge/Package%20version-0.2.3.2-orange.svg?style=flat-square)](commits/master)
[![Last-changedate](https://img.shields.io/badge/last%20change-`r gsub('-', '--', Sys.Date())`-yellowgreen.svg)](/commits/master)

Update pandoc - compile

# remove empty txt2pdf
# add url to ciataion
# A link to your your github repo (if listed in the DESCRIPTION url field).
# http://kbroman.org/pkg_primer/pages/github.html

# use_github_links()

# http://rmhogervorst.nl/cleancode/blog/2016/07/08/introducing-badgecreatr-create-and-place-badges-in-readme-rmd.html
# http://www.repostatus.org/#wip
# https://www.r-bloggers.com/building-a-website-with-pkgdown-a-short-guide/

# devtools::install_github("hadley/devtools")
# devtools::install_github("MangoTheCat/goodpractice")
# devtools::install_github("RcppCore/Rcpp")
# install.packages("badgecreatr")

# badgecreatr::badgeplacer(status = "inactive",
#                          githubaccount = "aravind-j",
#                          githubrepo = "PGRdup")



detach("package:PGRdup", unload=TRUE)
toremove <- c("src/PGRdup.dll",
              "src/register.o",
              "src/fdouble_metaphone.o")
if (file.exists(toremove)) file.remove(toremove)

# Document all
devtools::document()
# Load all
devtools::load_all(".")

# Rebuild README and Vignette
rmarkdown::render("README.Rmd")
rmarkdown::render("vignettes/Introduction.Rmd")

# Style check
library(lintr)
lintr::lint_package()

# Spell check
devtools::spell_check() # for package documentaion

# for others
spell_check_text <- function(text, ignore = hunspell::en_stats, dict = "en_GB"){
  bad_words <- hunspell::hunspell(text, ignore = ignore, dict = dict)
  bad_words <- vapply(sort(unique(unlist(bad_words))), function(word) {
    line_numbers <- which(vapply(bad_words, `%in%`, x = word, logical(1)))
    paste(line_numbers, collapse = ",")
  }, character(1))
  bad_words <- data.frame(bad_words)
  bad_words$Word <- rownames(bad_words)
  bad_words$Line <- bad_words$bad_words
  bad_words$bad_words <- NULL
  rownames(bad_words) <- NULL
  return(bad_words)
}

text <- readLines("README.Rmd", warn = FALSE)
rslt <- spell_check_text(text)

text <- readLines("vignettes/Introduction.Rmd", warn = FALSE)
rslt <- spell_check_text(text)

text <- readLines("NEWS.md", warn = FALSE)
rslt <- spell_check_text(text)

text <- readLines("DESCRIPTION", warn = FALSE)
rslt <- spell_check_text(text)

# goodpractice, Advice on R Package Building
goodpractice::gp()

# Rebuild github page
pkgdown::build_site()

# Set GhostScript and qpdf env variables
Sys.getenv("R_GSCMD")
Sys.getenv("R_QPDF")
Sys.setenv(R_GSCMD="C:/Program Files/gs/gs9.16/bin/gswin32c.exe")
Sys.setenv(R_QPDF="C:/qpdf-5.1.3/bin/qpdf.exe")

# Check locally - check on both release and devel
devtools::check(build_args = '--compact-vignettes="gs+qpdf"',
                args=c('--as-cran', '--use-valgrind'),
                check_version = FALSE)

# Check on r-devel using win_builder
devtools::build_win(pkg = "C:/Users/lenovo/Dropbox/PGRdup", version = c("R-devel"),
                    args = '--compact-vignettes="gs+qpdf"')

# Check on r-release using win_builder
devtools::build_win(pkg = "C:/Users/lenovo/Dropbox/PGRdup", version = c("R-release"),
                    args = '--compact-vignettes="gs+qpdf"')





# check vignette citation info - correct version and date





devtools::release("C:/Users/lenovo/Documents/PGRdup",
                  check = F, args = '--compact-vignettes="gs+qpdf"')

