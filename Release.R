
# http://kbroman.org/pkg_primer/pages/github.html

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
#autolink_html
              

# Set GhostScript and qpdf env variables
Sys.getenv("R_GSCMD")
Sys.getenv("R_QPDF")
Sys.setenv(R_GSCMD="C:/Program Files/gs/gs9.16/bin/gswin32c.exe")
Sys.setenv(R_QPDF="C:/qpdf-6.0.0/bin/qpdf.exe")

# Check locally - check on both release and devel
devtools::check(build_args = '--compact-vignettes="gs+qpdf"',
                args=c('--as-cran', '--use-valgrind'),
                check_version = FALSE)

# Check on r-devel using win_builder
devtools::build_win(pkg = "C:/Users/lenovo/Dropbox/PGRdup", version = c("R-devel"),
                    args = '--compact-vignettes="gs+qpdf"')

devtools::build_win(pkg = "C:/Users/J. Aravind/Dropbox/PGRdup", version = c("R-devel"),
                    args = '--compact-vignettes="gs+qpdf"')

# Check on r-release using win_builder
devtools::build_win(pkg = "C:/Users/lenovo/Dropbox/PGRdup", version = c("R-release"),
                    args = '--compact-vignettes="gs+qpdf"')

devtools::build_win(pkg = "C:/Users/J. Aravind/Dropbox/PGRdup", version = c("R-release"),
                    args = '--compact-vignettes="gs+qpdf"')

# R-hub check
library(rhub)
platforms()
check(platform = c("debian-gcc-devel", "debian-gcc-patched", 
                   "debian-gcc-release", "fedora-clang-devel", "fedora-gcc-devel", 
                   "linux-x86_64-centos6-epel", "linux-x86_64-centos6-epel-rdt", 
                   "linux-x86_64-rocker-gcc-san", "macos-elcapitan-release", "macos-mavericks-oldrel", 
                   "solaris-x86-patched", "ubuntu-gcc-devel", "ubuntu-gcc-release", 
                   "ubuntu-rchk", "windows-x86_64-devel", "windows-x86_64-oldrel", 
                   "windows-x86_64-patched", "windows-x86_64-release"))

# check vignette citation info - correct version and date
devtools::release("C:/Users/lenovo/Documents/PGRdup",
                  check = F, args = '--compact-vignettes="gs+qpdf"')

devtools::release("C:/Users/J. Aravind/Dropbox/PGRdup",
                  check = F, args = '--compact-vignettes="gs+qpdf"')





################################################################################
library(rvest)
pkg <- "PGRdup"
link <- paste0("http://cran.r-project.org/src/contrib/Archive/", pkg)
xml <- read_html(link)
hn <- html_nodes(xml, xpath='/html/body/table')
ht <- html_table(hn)

VerHistory <- ht[[1]]

VerHistory <- VerHistory[VerHistory$Name != "Parent Directory",
                         c("Name", "Last modified")]
VerHistory <- VerHistory[VerHistory$Name != "", ]

VerHistory$Version <- gsub("PGRdup_", "", VerHistory$Name)
VerHistory$Version <- gsub(".tar.gz", "", VerHistory$Version)
VerHistory$Date <- as.Date(VerHistory$`Last modified`)

VerHistory <- VerHistory[order(VerHistory$Date), c("Version", "Date")]
rownames(VerHistory) <- NULL

knitr::kable(VerHistory)
################################################################################