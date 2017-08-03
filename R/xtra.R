
wlcm <- paste0("\n",
               "--------------------------------------------------------------------------------\n",
               "Welcome to PGRdup version ", utils::packageDescription("PGRdup")$Version, "\n",
               "\n", "\n",
               "# To know how to use this package type:", "\n",
               "  browseVignettes(package = 'PGRdup')", "\n", "  for the package vignette.", "\n",
               "\n",
               "# To know whats new in this version type:", "\n",
               "  news(package='PGRdup')", "\n", "  for the NEWS file.", "\n",
               "\n",
               "# To cite the methods in the package type:", "\n",
               "  citation(package='PGRdup')","\n",
               "\n",
               "# To suppress this message use:", "\n",
               "  suppressPackageStartupMessages(library(PGRdup))", "\n",
               "--------------------------------------------------------------------------------\n")

.onAttach <- function(lib, pkg,...){
  packageStartupMessage(wlcm)

}
