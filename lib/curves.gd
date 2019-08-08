#############################################################################
##
#W  curves.gd                   HERmitian Package                  Gabor P. Nagy
##
##  Declaration file for Hermitian curves
##
#Y  Copyright (C) 2019 Gabor P. Nagy (http://www.math.u-szeged.hu/~nagyg), 14/03/2019
##

#############################################################################
## GLOBAL PRIVATE VARIABLES AND FUNCTIONS 

#############################################################################
##  CONSTRUCTORS
##  -------------------------------------------------------------------------

#############################################################################
##
#C  IsHermitian_Curve(<obj>)
##  
##  <#GAPDoc Label="IsHermitian_Curve">
##  <ManSection>
##  <Filt Name="IsHermitian_Curve" Arg='obj' Type='Category'/>
##  
##  <Description>
##  Hermitian curve <M>H(q)</M> is an algebraic curve over an algebraically closed field,
##  having an affine equation <M>X^{q+1} = Y^q + Y</M>. The base field of <M>H(q)</M> is
##  <M>GF(q^2)</M>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHermitian_Curve", IsObject );

#############################################################################
##
#R  IsHermitian_CurveRep
##
##  <ManSection>
##  <Filt Name="IsHermitian_CurveRep" Arg='obj' Type='Representation'/>
##
##  <Description>
##  </Description>
##  </ManSection>
##  
DeclareRepresentation( 
    "IsHermitian_CurveRep", 
    IsComponentObjectRep and IsAttributeStoringRep, 
    [ "fieldsize", "char", "X", "Y" ] 
);
BindGlobal( "Hermitian_CurveFamily", NewFamily( "Hermitian_CurveFam" ) );

#############################################################################
##
#F  Hermitian_Curve(<K>,<X>,<Y>)
##
##  <#GAPDoc Label="Hermitian_Curve">
##  <ManSection>
##  <Oper Name="Hermitian_Curve" Arg='K,hratfn'/>
##
##  <Returns>
##  The corresponding Hermitian curve <M>H(q)</M> over the algebraic closure
##  of the field <A>K</A>. The indeterminates <M>X,Y</M> of <A>hratfn</A> generate 
##  the corresponding Hermitian function field <M>K(X,Y)</M> such that 
##  <M>X^{q+1} = Y^q + Y</M>. <A>K</A> must be a finite field of square order. 
##  The points of <M>H(q)</M> are either affine <M>P(a,b)</M> satisfying 
##  <M>a^{q+1}=b^q+b</M>, or the infinite point <C>[ infinity ]</C>.
##  One can use the <C>in</C> operation to test if a point lies on the Hermitian
##  curve. 
##  </Returns>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "Hermitian_Curve", [ IsRationalFunction ] );
#DeclareOperation( "Hermitian_Curve", [ IsField, IsString, IsString ] );

#############################################################################
##
#F  IndeterminateOfHermitian_Curve(C)
##
##  <#GAPDoc Label="IndeterminatesOfHermitian_Curve">
##  <ManSection>
##  <Func Name="IndeterminatesOfHermitian_Curve" Arg='Hq'/>
##
##  <Returns>
##  The indeterminates of the function field of the Hermitian curve <A>C</A>.
##  </Returns>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "IndeterminatesOfHermitian_Curve" );

#############################################################################
##  UTILITIES
##  -------------------------------------------------------------------------

#############################################################################
##  
#A  UnderlyingField(<Hq>)
##  
##  <#GAPDoc Label="Genus">
##  <ManSection>
##  <Attr Name="Genus" Arg='Hq'/>
##  
##  <Description>
##  The genus of the Hermitian curve <M>H(q)</M> is <M>q(q-1)/2</M>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Genus", IsHermitian_Curve );

#############################################################################
##  
#A  UnderlyingField(<Hq>)
##  
##  <#GAPDoc Label="UnderlyingField_Curve">
##  <ManSection>
##  <Attr Name="UnderlyingField" Arg='Hq'/>
##  
##  <Description>
##  The underlying field of a Hermitian curve is the field of coefficients
##  of the corresponding algebraic function field, it is a finite field of square order.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "UnderlyingField", IsHermitian_Curve );

#############################################################################
##
#F  FrobeniusAutomorphismOfHermitian_Curve(Hq)
##
##  <#GAPDoc Label="FrobeniusAutomorphismOfHermitian_Curve">
##  <ManSection>
##  <Attr Name="FrobeniusAutomorphismOfHermitian_Curve" Arg='Hq'/>
##
##  <Returns>
##  The Frobenius automorphism of the underlying field of the Hermitian curve <A>Hq</A>.
##  More precisely, the output is an AC-Frobenius automorphism in the sense of the package <Package>OnAlgClosure</Package>,
##  acting on the algebraic closure of the underlying finite field.
##  </Returns>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "FrobeniusAutomorphismOfHermitian_Curve", IsHermitian_Curve );

#############################################################################
##  PLACES
##  -------------------------------------------------------------------------

#############################################################################
##
#F  AllRationalAffinePlacesOfHermitian_Curve(Hq)
##
##  <#GAPDoc Label="AllRationalAffinePlacesOfHermitian_Curve">
##  <ManSection>
##  <Oper Name="AllRationalAffinePlacesOfHermitian_Curve" Arg='Hq'/>
##
##  <Returns>
##  All rational affine places of the Hermitian curve <A>Hq</A>. 
##  The number of rational affine places of  <M>H(q)</M> is <M>q^3</M>.
##  </Returns>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "AllRationalAffinePlacesOfHermitian_Curve", [ IsHermitian_Curve ] );

#############################################################################
##
#F  AllRationalPlacesOfHermitian_Curve(Hq)
##
##  <#GAPDoc Label="AllRationalPlacesOfHermitian_Curve">
##  <ManSection>
##  <Oper Name="AllRationalPlacesOfHermitian_Curve" Arg='Hq'/>
##
##  <Returns>
##  All rational places of the Hermitian curve <A>Hq</A>. Here,
##  a place is a 1-point divisor of degree one, that is, defined over <M>GF(q^2)</M>. 
##  Notice that the place at infinity is rational. The number of rational places of
##  <M>H(q)</M> is <M>q^3+1</M>.
##  </Returns>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "AllRationalPlacesOfHermitian_Curve", [ IsHermitian_Curve ] );

#############################################################################
##
#F  RandomRationalPlaceOfHermitian_Curve(Hq)
##
##  <#GAPDoc Label="RandomRationalPlaceOfHermitian_Curve">
##  <ManSection>
##  <Oper Name="RandomRationalPlaceOfHermitian_Curve" Arg='Hq'/>
##
##  <Returns>
##  A random rational place of the Hermitian curve <A>Hq</A>. Here,
##  a place is a 1-point divisor of degree one, that is, defined over <M>GF(q^2)</M>. 
##  Notice that the place at infinity is rational.
##  </Returns>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "RandomRationalPlaceOfHermitian_Curve", [ IsHermitian_Curve ] );

#############################################################################
##
#F  RandomPlaceOfGivenDegreeOfHermitian_Curve(Hq,d)
##
##  <#GAPDoc Label="RandomPlaceOfGivenDegreeOfHermitian_Curve">
##  <ManSection>
##  <Oper Name="RandomPlaceOfGivenDegreeOfHermitian_Curve" Arg='Hq,d'/>
##
##  <Returns>
##  A random place of degree <A>d</A> of the Hermitian curve <A>Hq</A>,
##  that is, a place defined over the field <M>GF(q^{2d})</M>. Notice that the 
##  place at infinity is has degree 1.
##  </Returns>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "RandomPlaceOfGivenDegreeOfHermitian_Curve", [ IsHermitian_Curve, IsPosInt ] );


