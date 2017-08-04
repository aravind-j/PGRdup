# Version 0.2.3.2 - Second submission

* Added copyright to Authors@R along with original contributors for the C code.
* The memtest errors in the package have been corrected.

### Test environments
* local Windows 7 Ultimate install, R-release (R 3.4.1) & R-devel (R 3.5.0 Pre-release).
* local Ubuntu 16.04, R-release (R 3.4.1) & R-devel (R 3.5.0 Pre-release).

# Version 0.2.3.2 - First submission

* The memtest errors in the package have been corrected.

### Test environments
* local Windows 7 Ultimate install, R-release (R 3.4.1) & R-devel (R 3.5.0 Pre-release).
* local Ubuntu 16.04, R-release (R 3.4.1) & R-devel (R 3.5.0 Pre-release).
* win-builder, R-release (R 3.4.1) & R-devel (R 3.5.0 Pre-release).
* CLANG memtest via rocker/r-devel-ubsan-clang.
* GCC memtest via rocker/r-devel-san.

### R CMD check results
* 0 errors | 0 warnings | 0 notes

***

# Version 0.2.3.1 - First submission

### Test environments
* local Windows 7 Ultimate install, R-release (R 3.3.3) & R-devel (R 3.4.0 Pre-release).
* local Ubuntu 16.04, R-release (R 3.3.3) & R-devel (R 3.4.0 Pre-release).

### R CMD check results
* 0 errors | 0 warnings | 0 notes

***

# Version 0.2.3 - Resubmission
* This is a resubmission. In this version I have:

* Converted the non-confirming R-project URLs in README.md and other files to the canonical form (with https instead of http).

***

# Version 0.2.3 - First submission

### Test environments
* local Windows 7 Ultimate install, R-release (R 3.3.3) & R-devel.
* local Ubuntu 12.04, R-release (R 3.3.3) & R-devel.
* win-builder, R-release (R 3.3.3) & R-devel (R 3.4.0 Pre-release).

***

# Version 0.2.2 - Resubmission
* This is a resubmission. In this version I have:

* Converted the non-confirming package page URLs in README.md to the canonical form.
* Reduced the size of ‘Introduction.pdf’ under ‘inst/doc’ using `tools::compactPDF(gs_quality = "ebook")`.

***

# Version 0.2.2 - First submission

### Test environments
* local Windows 7 Ultimate install, R-release (R 3.2.3) & R-devel (R 3.3.0 Pre-release).
* local Ubuntu 12.04, R-release (R 3.2.3) & R-devel (R 3.3.0 Pre-release).
* win-builder, R-release (R 3.2.3) & R-devel (R 3.3.0 Pre-release).

### Note
* A change in the email addresses of four of the package authors including the maintainer have been made. This is due to implementation of a unified communications platform by our parent organization (ICAR) warranting a close down of our within institute (ICAR-NBPGR) mail server. A confirmation of this has been sent from the previous address of the maintainer (aravindj@nbpgr.ernet.in).

***

# Version 0.2.1 - Resubmission 2
* This is a resubmission. In this version I have:

* Regarding the (possibly) invalid URLs found:
    URL: http://www.nbpgr.ernet.in:8080/PGRPortal/
    From: man/GN1000.Rd
    Status: Error
    Message: libcurl error code 7
    Failed to connect to www.nbpgr.ernet.in port 8080: Connection timed out
    
  + These URLs were temporarily down and were active only locally when the tests were done.
  + They are now up and running.

***    

# Version 0.2.1 - Resubmission
* This is a resubmission. In this version I have:

* Compacted the vignette pdf.
* Fixed the error in rebuilding of vignette outputs.

* Used the following test environments
+ local Windows 7 Ultimate install, R-release (R 3.1.3) & R-devel (R 3.3.0 Pre-release).
+ local Ubuntu 12.04, R-release (R 3.1.3).
+ win-builder R-release (R 3.1.3) & R-devel (R 3.3.0 Pre-release).

***

# Version 0.2.1 - First submission

### Test environments
* local Windows 7 Ultimate install, R-release (R 3.1.3) & R-devel (R 3.3.0 Pre-release).
* local Ubuntu 12.04, R-release (R 3.1.3) & R-devel (R 3.3.0 Pre-release).

***

# Version 0.2.0 - Resubmission 4
* This is a resubmission. In this version I have:

* Fixed errors in the C code for successful compilation and installation of package.

***

# Version 0.2.0 - Resubmission 3
* This is a resubmission. In this version I have:

* Modified the 'Title' field in DESCRIPTION so that it is more meaningful.
 + Expanded PGR to 'Plant Genetic Resources'

* Modified the ‘Description’ field in DESCRIPTION as follows.
 + Corrected the mis-spelled words.
 + Edited the text by limiting or explaining the specialized vocabulary as far as possible to make it more intelligible for CRAN users.
 
* 'Genebank managers' are those who are responsible for curation of collections of living genetic resources such as seed or tissue and 'Passport databases' are databases with records of identity of such collections. This term has been dropped to make the description more intelligible as it was felt inessential in this context.

***

# Version 0.2.0 - Resubmission 2
* This is a resubmission. In this version I have:

* Shortened the 'Title' field in DESCRIPTION to 65 chars.
* Modified the ‘Description’ field in DESCRIPTION according to the manual.

***

# Version 0.2.0 - Resubmission
* This is a resubmission. In this version I have:

* Used the following test environments (Used R-devel according to CRAN policy)
 + local Windows 7 Ultimate (3.1.3 and R-devel).
 + local Ubuntu 12.04 (3.1.3 and R-devel).
 + win-builder (devel(3.2.0 alpha) and release(3.1.3)).
 
 + R CMD check --as-cran results
  - There were no ERRORs or WARNINGs.
  - There were no NOTES except for "checking CRAN incoming feasibility".
 
* Changed the format of author names appropriately.

* Regarding (possibly) invalid URLs:
    URL: http://www.nbpgr.ernet.in/
    From: README.md
    Status: Error
    Message: libcurl error code 6
    Could not resolve host: www.nbpgr.ernet.in

    URL: http://www.nbpgr.ernet.in/PGRPortal
    From: man/GN1000.Rd
    Status: Error
    Message: libcurl error code 6
    Could not resolve host: www.nbpgr.ernet.in
      
 + These URLs were temporarily down and were active only locally when the tests were done.
 + There is permanent redirection (HTTP/1.1 301) with the URL http://www.nbpgr.ernet.in/PGRPortal and hence it was updated to the redirected URL (http://www.nbpgr.ernet.in:8080/PGRPortal/) according to the CRAN policy. However please note that there is further temporary redirection (HTTP/1.1 302) from http://www.nbpgr.ernet.in:8080/PGRPortal/.

***

# Version 0.2.0 - First submission

### Test environments
* local Windows 7 Ultimate install, R 3.1.3
* local Ubuntu 12.04, R 3.1.3
* win-builder (devel and release)

### R CMD check results
* There were no ERRORs or WARNINGs.
* There were no NOTES except for "checking CRAN incoming feasibility".
