#############################################################################
##
#W  intersections.gd                  HERmitian Package                 Gabor P. Nagy
##
##  Declaration file for intersections of curves with the Hermitian curve
##
#Y  Copyright (C) 2019 Gabor P. Nagy (http://www.math.u-szeged.hu/~nagyg), 14/03/2019
##

#############################################################################
##
#F  PrincipalHermitian_Divisor(f)
##
##  <#GAPDoc Label="PrincipalHermitian_Divisor">
##  <ManSection>
##  <Func Name="PrincipalHermitian_Divisor" Arg='Hq,f'/>
##
##  <Returns>
##  The principal divisor of the rational function <A>f</A> of the
##  Hermitian curve <A>C</A>.
##  </Returns>
##  </ManSection>
##  <#/GAPDoc>
##
#DeclareGlobalFunction( "PrincipalHermitian_Divisor" );

DeclareGlobalFunction( "HERM_totalDegreeOfPolynomial" );
DeclareGlobalFunction( "HERM_powerSeriesAtHpt_NC" );
DeclareGlobalFunction( "HERM_hermitianIntersection" );
DeclareGlobalFunction( "HERM_isectmultAtHptOrq" );
DeclareGlobalFunction( "HERM_isectmultAtHpt_exact" );
DeclareGlobalFunction( "HERM_asGFq2Elm" );
DeclareGlobalFunction( "HERM_tracemap4vector" );
DeclareGlobalFunction( "HERM_linearConditionsForISectMult_NC" );
DeclareGlobalFunction( "HERM_rationalLinCondsISectMult_NC" );
DeclareGlobalFunction( "HERM_linearConditionsForISectMultAtInfinity_NC" );
DeclareGlobalFunction( "HERM_rationalLinCondsISectMult" );
