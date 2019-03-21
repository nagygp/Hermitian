#############################################################################
##
#W    init.g                  The HERmitian package                 Gabor P. Nagy
##

#############################################################################
##  Starting from GAP 4.4 and having  a  PackageInfo.g  file  available,  the
##  commands  `DeclarePackage'  and   `DeclarePackageAutoDocumentation'   are
##  ignored. They are substituted by the entries:
##   .PackageName, .Version, .PackageDoc, .Dependencies and .AvailabilityTest
##  specified in the PackageInfo.g file.
##
##  Since GAP 4.4, commands with `Pkg' in their name have `Package'  instead,
##  e.g. `ReadPkg' became `ReadPackage'.
##

#############################################################################
##
#R  Read the declaration files.
##
ReadPackage( "HERmitian", "lib/functions.gd" );
ReadPackage( "HERmitian", "lib/curves.gd" );
ReadPackage( "HERmitian", "lib/intersections.gd" );
ReadPackage( "HERmitian", "lib/divisors.gd" );
ReadPackage( "HERmitian", "lib/automorphisms.gd" );
ReadPackage( "HERmitian", "lib/riemannroch.gd" );
ReadPackage( "HERmitian", "lib/agcodes.gd" );
ReadPackage( "HERmitian", "lib/utils.gd" );

#E  init.g . . . . . . . . . . . . . . . . . . . . . . . . . . . .  ends here

