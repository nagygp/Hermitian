##  This builds the documentation of the HERmitian package
##  Needs: GAPDoc package, latex, pdflatex, mkindex
##
LoadPackage( "GAPDoc" );

doc_path := "/home/nagyg/MyGAP/pkg/HERmitian/doc";
xml_path := "/home/nagyg/MyGAP/pkg/HERmitian/xml";

Exec( Concatenation( "cp ", xml_path, "/*.xml", " ", doc_path ) );
Exec( Concatenation( "cp ", xml_path, "/*.bib", " ", doc_path ) );

opts:=GAPDoc2LaTeXProcs.DefaultOptions;
Append(opts.FontPackages,"\\usepackage{amsmath}\n");
SetGapDocLaTeXOptions(opts);

MakeGAPDocDoc( doc_path,     # path to the directory containing the main file
    "main",   # the name of the main file (without extension)
              # list of (probably source code) files relative
              # to path which contain pieces of documentation
              # which must be included in the document
    [ "../PackageInfo.g", "../lib/curves.gd", "../lib/divisors.gd",
      "../lib/riemannroch.gd", "../lib/agcodes.gd",
      "../lib/automorphisms.gd", "../lib/utils.gd" ],
    "HERmitian",                  # the name of the book used by GAP's online help
    "../../../../opt/gap4/",  # optional: relative path to the main GAP root
                              # directory to produce HTML files with relative
                              # paths to external books.
    "MathJax"                 # optional: use "MathJax", "Tth" and/or "MathML"
                              # to produce additional variants of HTML files
);;

Exec( Concatenation( "rm -f ", doc_path, "/*.xml") );

# Copy the *.css and *.js files from the styles directory of the GAPDoc
# package into the directory containing the package manual.
CopyHTMLStyleFiles( doc_path );

# Create the manual.lab file which is needed if the main manuals or another
# package is referring to your package
GAPDocManualLab( "HERmitian" );;

# Create VERSION file for packaging
PrintTo( "VERSION", GAPInfo.PackagesInfo.hermitian[1].Version );

QUIT;
