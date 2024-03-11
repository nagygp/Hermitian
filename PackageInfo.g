#############################################################################
##
##  PackageInfo.g for the package `HERmitian'                       Gabor P. Nagy
##
##

SetPackageInfo( rec(

PackageName := "HERmitian",
Subtitle := "HERmitian/Computing with divisors, Riemann-Roch spaces and AG-odes of Hermitian curves",
Version := "0.3",
Date := "11/03/2024",

##  Optional: if the package manual uses GAPDoc, you may duplicate the
##  version and the release date as shown below to read them while building
##  the manual using GAPDoc facilities to distibute documents across files.
##  <#GAPDoc Label="PKGVERSIONDATA">
##  <!ENTITY VERSION "0.3">
##  <!ENTITY RELEASEDATE "11 March 2024">
##  <#/GAPDoc>

PackageWWWHome := "https://github.com/nagygp/Hermitian",
ArchiveURL := Concatenation( ~.PackageWWWHome, "HERmitian-", ~.Version ),
ArchiveFormats := ".tar.gz",


##  Information about authors and maintainers is contained in the `Persons'
##  field which is a list of records, one record for each person; each
##  person's record should be as per the following example:
##
Persons := [
  rec(
    LastName      := "Nagy",
    FirstNames    := "Gábor P.",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "nagyg@math.u-szeged.hu",
    WWWHome       := "http://www.math.u-szeged.hu/~nagyg",
    PostalAddress := Concatenation( [
                       "Bolyai Institute of the University of Szeged\n",
                       "Aradi vértanúk tere 1\n",
                       "H-6720 Szeged (Hungary)" ] ),
    Place         := "Szeged",
    Institution   := "University of Szeged"
  ),
  rec(
    LastName      := "El Khalfaoui",
    FirstNames    := "Sabira",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "sabiraelkhalfaoui@gmail.com",
    WWWHome       := "https://irmar.univ-rennes.fr/",
    PostalAddress := Concatenation( [
                       "Univ Rennes\n",
                       "IRMAR - UMR 6625\n",
                       "F-35000 Rennes (France)" ] ),
    Place         := "Rennes",
    Institution   := "Université de Rennes"
  ),
# provide such a record for each author and/or maintainer ...
],

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "submitted"     for packages submitted for the refereeing
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "dev",

##  You must provide the next two entries if and only if the status is
##  "accepted" because is was successfully refereed:
# format: 'name (place)'
#CommunicatedBy := "",
# format: mm/yyyy
#AcceptDate := "",

README_URL := Concatenation( ~.PackageWWWHome, "README" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),

AbstractHTML :=
  "The <span class=\"pkgname\">HERmitian</span> package provides \
   <span class=\"pkgname\">GAP</span> styled functionalities to make \
   arithmetics with places and divisors over an algebraic function field. \
   It computes the corresponding Riemann-Roch spaces and the algebraic-geometric \
   codes.",

##  Here is the information on the help books of the package, used for
##  loading into GAP's online help and maybe for an online copy of the
##  documentation on the GAP website.
##
##  For the online help the following is needed:
##       - the name of the book (.BookName)
##       - a long title, shown by ?books (.LongTitle, optional)
##       - the path to the manual.six file for this book (.SixFile)
##
##  For an online version on a Web page further entries are needed,
##  if possible, provide an HTML- and a PDF-version:
##      - if there is an HTML-version the path to the start file,
##        relative to the package home directory (.HTMLStart)
##      - if there is a PDF-version the path to the .pdf-file,
##        relative to the package home directory (.PDFFile)
##      - give the paths to the files inside your package directory
##        which are needed for the online manual (as a list
##        .ArchiveURLSubset of names of directories and/or files which
##        should be copied from your package archive, given in .ArchiveURL
##        above (in most cases, ["doc"] or ["doc","htm"] suffices).
##
##  For links to other GAP or package manuals you can assume a relative
##  position of the files as in a standard GAP installation.
##
# in case of several help books give a list of such records here:
PackageDoc := rec(
  BookName  := "HERmitian",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Divisors, Riemann-Roch spaces and AG-odes of Hermitian curves",
),


##  Are there restrictions on the operating system for this package? Or does
##  the package need other packages to be available?
Dependencies := rec(
  GAP := "4.8.6",
  NeededOtherPackages := [["GAPDoc", "1.5"],["cvec","2.5.6"],["OnAlgClosure","0.1"]],
  SuggestedOtherPackages := [],
  ExternalConditions := [],
),
AvailabilityTest := ReturnTrue,

##  *Optional*: path relative to package root to a file which
##  shall be read immediately before the package is loaded.
#PreloadFile := "...",

##  *Optional*, but recommended: path relative to package root to a file which
##  contains as many tests of the package functionality as sensible.
##  The file can either consist of 'ReadTest' calls or it is itself read via
##  'ReadTest'; it is assumed that the latter case occurs if and only if
##  the file contains the string 'gap> START_TEST('.
##  For deposited packages, these tests are run regularly, as a part of the
##  standard GAP test suite.
TestFile := "tst/testall.tst",
Keywords := ["Hermitian", "Riemann-Roch space", "divisor", "AG-code"]

));
