#############################################################################
##
#W  functions.gd                HERmitian Package              Gabor P. Nagy
##
##  Declaration file for Hermitian function fields
##  The underlying Hermitian curve has equation x^(q+1) = y^q + y
##
#Y  Copyright (C) 2019 Gabor P. Nagy (http://www.math.u-szeged.hu/~nagyg), 14/03/2019
##


#############################################################################
## GLOBAL PRIVATE VARIABLES AND FUNCTIONS 
DeclareGlobalVariable( "HERM_INDET_DICT" );
DeclareGlobalFunction( "HERM_IndeterminateNumbersOfRationalFunctions" );
DeclareGlobalFunction( "HERM_IndeterminateNumbersOfHermitianRatFunc" );
DeclareGlobalFunction( "HERM_PolynomialReduction_NC" );


#############################################################################
##
#C  IsHermitianIndeterminate(<obj>)
##  
##  <#GAPDoc Label="IsHermitianIndeterminate">
##  <ManSection>
##  <Filt Name="IsHermitianIndeterminate" Arg='obj' Type='Category'/>
##  <Filt Name="IsHermitianXIndeterminate" Arg='obj'/>
##  <Filt Name="IsHermitianYIndeterminate" Arg='obj'/>
##  
##  <Description>
##  The indeterminates <M>X,Y</M> are Hermitian with base field <M>GF(q^2)</M>
##  if <M>X^(q+1) = Y^q + Y</M> holds.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareFilter( "IsHermitianXIndeterminate" );
DeclareFilter( "IsHermitianYIndeterminate" );
DeclareCategory( "IsHermitianIndeterminate", IsPolynomial );

#############################################################################
##
#C  HermitianIndeterminate(<field>, <string>, <string>)
##  
##  <#GAPDoc Label="HermitianIndeterminate">
##  <ManSection>
##  <Oper Name="HermitianIndeterminate" Arg='F,s1,s2'/>
##  
##  <Returns>
##  A pair of indeterminates which are algebraically dependent by the
##  equation <M>X^(q+1) = Y^q + Y</M>. <A>F</A> must be a finite field of
##  square order.
##  </Returns>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "HermitianIndeterminates", [ IsField, IsString, IsString ] );

#############################################################################
##
#C  IsHermitianRationalFunction(<ratfn>)
##  
##  <#GAPDoc Label="IsHermitianRationalFunction">
##  <ManSection>
##  <Prop Name="IsHermitianRationalFunction" Arg='ratfn'/>
##  
##  <Description>
##  Checks if <A>ratfn> is a rational function in two Hermitian indeterminates.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsHermitianRationalFunction", IsRationalFunction );

#############################################################################
##
#C  IsHermitianRationalFunction(<ratfn>)
##  
##  <#GAPDoc Label="IsHermitianRationalFunction">
##  <ManSection>
##  <Prop Name="IsHermitianRationalFunction" Arg='ratfn'/>
##  
##  <Description>
##  Checks if <A>ratfn</A> is a rational function in two Hermitian indeterminates.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsHermitianPolynomial", IsRationalFunction );

#############################################################################
##
#C  IndeterminatesOfHermitianRatFunc(<ratfn>)
##  
##  <#GAPDoc Label="IndeterminatesOfHermitianRatFunc">
##  <ManSection>
##  <Attr Name="IndeterminatesOfHermitianRatFunc" Arg='ratfn'/>
##  
##  <Returns>
##  The Hermitian indeterminates of the rational function <A>ratfn</A>.
##  Returns <C>fail</C> for non Hermitian input, and <C>[]</C> for constant polynomial.
##  This operation can be used to obtain the associated indeterminate of a
##  Hermitian indeterminate.
##  </Returns>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "IndeterminatesOfHermitianRatFunc", IsRationalFunction );

#############################################################################
##
#C  HermitianReductionOfRatFunc(<ratfn>)
##  
##  <#GAPDoc Label="HermitianReductionOfRatFunc">
##  <ManSection>
##  <Oper Name="HermitianReductionOfRatFunc" Arg='ratfn'/>
##  
##  <Description>
##  If <A>ratfn</A> is a Hermitian polynomial over <M>GF(q^2)</M>, then it returns 
##  its reduction modulo <M>X^(q+1) = Y^q + Y</M>. If <A>ratfn</A> is a Hermitian
##  rational function then it returns the quotient of the reduced numerator and
##  denominator.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "HermitianReductionOfRatFunc", [ IsRationalFunction ] );


