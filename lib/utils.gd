#############################################################################
##
#W  utils.gd                  HERmitian Package                 Gabor P. Nagy
##
##  Utilities for arithmetics of Hermitian AG codes
##
#Y  Copyright (C) 2019 Gabor P. Nagy (http://www.math.u-szeged.hu/~nagyg), 14/03/2019
##

#############################################################################
##
#C  UPolCoeffsToSmallFieldNC(f,q)
##
##  <#GAPDoc Label="UPolCoeffsToSmallFieldNC">
##  <ManSection>
##  <Func Name="UPolCoeffsToSmallFieldNC" Arg='f,q'/>
##
##  <Description>
##  This non-checking function returns the same polynomial as <A>f</A>,
##  making sure that the coefficients are in <M>GF(q)</M>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "UPolCoeffsToSmallFieldNC" );

#############################################################################
##
#C  RestrictVectorSpace(V,F)
##
##  <#GAPDoc Label="RestrictVectorSpace">
##  <ManSection>
##  <Func Name="RestrictVectorSpace" Arg='V,F'/>
##
##  <Description>
##  Let <M>K</M> be a field and <M>V</M> a linear subspace of <M>K^n</M>. The restriction of <A>V</A>
##  to the field <A>F</A> is the intersection <M>V\cap F^n</M>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "RestrictVectorSpace" );

#############################################################################
##
#C  RandomVectorOfGivenWeight(F,n,k)
#C  RandomVectorOfGivenDensity(F,n,delta)
#C  RandomBinaryVectorOfGivenWeight(n,k)
#C  RandomBinaryVectorOfGivenDensity(n,delta)
##
##  <#GAPDoc Label="RandomErrorVectors">
##  <ManSection>
##
##  <Func Name="RandomVectorOfGivenWeight" Arg='F,n,k' />
##  <Description>
##  returns a random vector of <M>F^n</M> of Hamming weight <M>k</M>.
##  </Description>
##
##  <Func Name="RandomVectorOfGivenDensity" Arg='F,n,delta' />
##  <Description>
##  returns a random vector of <M>F^n</M> in which the density of nonzero elements is approximatively <M>\delta</M>.
##  </Description>
##
##  <Func Name="RandomBinaryVectorOfGivenWeight" Arg='n,k' />
##  <Description>
##  returns a random vector of <M>GF(2)^n</M> of Hamming weight <M>k</M>.
##  </Description>
##
##  <Func Name="RandomBinaryVectorOfGivenDensity" Arg='n,delta' />
##  <Description>
##  returns a random vector of <M>GF(2)^n</M> in which the density of nonzero elements is approximatively <M>\delta</M>.
##  </Description>
##

##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "RandomVectorOfGivenWeight" );
DeclareGlobalFunction( "RandomVectorOfGivenDensity" );
DeclareGlobalFunction( "RandomBinaryVectorOfGivenWeight" );
DeclareGlobalFunction( "RandomBinaryVectorOfGivenDensity" );

#############################################################################
##
#C  InfoHermitian
##
##  <#GAPDoc Label="InfoHermitian">
##  <ManSection>
##  <InfoClass Name="InfoHermitian">
##
##  <Description>
##  An infoclass for the package. Its default value is $0$. 
##  With <C>SetInfoLevel(InfoHermitian,2)</C> one can get some additional 
##  messages about the ongoing computation of Hermitian curves and their codes.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareInfoClass( "InfoHermitian" );