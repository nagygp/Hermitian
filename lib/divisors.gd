#############################################################################
##
#W  divisors.gd                  HERmitian Package                 Gabor P. Nagy
##
##  Declaration file for arithmetics of Hermitian divisors
##
#Y  Copyright (C) 2019 Gabor P. Nagy (http://www.math.u-szeged.hu/~nagyg), 14/03/2019
##

#############################################################################
##
#C  IsHermitian_Divisor(<obj>)
##
##  <#GAPDoc Label="IsHermitian_Divisor">
##  <ManSection>
##  <Filt Name="IsHermitian_Divisor" Arg='obj' Type='Category'/>
##
##  <Description>
##  A Hermitian divisor is a divisor of an algebraic function field of the Hermitian 
##  curve <M>H(q):X^{q+1}=Y^q+Y</M>. Hermitian divisors form an additive commutative group.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHermitian_Divisor", IsAdditiveElementWithInverse and IsExtLElement );

#############################################################################
##
#R  IsHermitian_DivisorRep
##
##  <ManSection>
##  <Filt Name="IsHermitian_DivisorRep" Arg='obj' Type='Representation'/>
##
##  <Description>
##  </Description>
##  </ManSection>
##
DeclareRepresentation( 
    "IsHermitian_DivisorRep", 
    IsAdditiveElement and IsComponentObjectRep and IsAttributeStoringRep, 
    ["curve","char","indnr"]
);
BindGlobal("Hermitian_DivisorFamily",NewFamily("Hermitian_DivisorFam",IsAdditivelyCommutativeElementFamily));

#############################################################################
##
#F  Hermitian_DivisorConstruct(<Hq>,<pts>,<ords>)
##
##  <#GAPDoc Label="Hermitian_DivisorConstruct">
##  <ManSection>
##  <Func Name="Hermitian_DivisorConstruct" Arg='Hq,pts,ords'/>
##
##  <Description>
##  returns the Hermitian divisor over <A>Hq</A> with points from <A>pts</A>
##  and corresponding orders from <A>ords</A>. It checks the input.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "Hermitian_DivisorConstruct" );

#############################################################################
##
#F  IndeterminatesOfHermitian_Divisor(D)
##
##  <#GAPDoc Label="IndeterminatesOfHermitian_Divisor">
##  <ManSection>
##  <Func Name="IndeterminatesOfHermitian_Divisor" Arg='D'/>
##
##  <Description>
##  returns the pair of indeterminates of the function field of the Hermitian divisor <A>D</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "IndeterminatesOfHermitian_Divisor" );

#############################################################################
##
#F  Hermitian_Divisor(<Hq>,<pts>,<ords>)
#F  Hermitian_Divisor(<Hq>,<pairs>)
##
##  <#GAPDoc Label="Hermitian_Divisor">
##  <ManSection>
##  <Oper Name="Hermitian_Divisor" Arg='Hq,pts,ords'/>
##  <Oper Name="Hermitian_Divisor" Arg='Hq,pairs'/>
##
##  <Description>
##  returns the corresponding Hermitian divisor over the Hermitian curve
##  <A>Hq</A>. The list <A>pts</A> must be points of <A>Hq</A>; the infinite
##  point is <C>[ infinity ]</C>. The list <A>ords</A> contains the respective
##  orders. The elements of the list <A>pairs</A> are the point-order pairs.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "Hermitian_Divisor", [IsHermitian_Curve,IsList] );
DeclareOperation( "Hermitian_Divisor", [IsHermitian_Curve,IsList,IsList] );

#############################################################################
##
#F  ZeroHermitian_Divisor(<Hq>)
##
##  <#GAPDoc Label="ZeroHermitian_Divisor">
##  <ManSection>
##  <Oper Name="ZeroHermitian_Divisor" Arg='Hq'/>
##
##  <Description>
##  returns the zero divisor over the Hermitian curve <A>Hq</A>. 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "ZeroHermitian_Divisor", [IsHermitian_Curve] );

#############################################################################
##
#F  1PointHermitian_Divisor(<Hq>, <pt>)
#F  1PointHermitian_Divisor(<Hq>, <pt>, <m>)
##
##  <#GAPDoc Label="1PointHermitian_Divisor">
##  <ManSection>
##  <Oper Name="1PointHermitian_Divisor" Arg='Hq,pt'/>
##  <Oper Name="1PointHermitian_Divisor" Arg='Hq,pt,m'/>
##
##  <Description>
##  returns the one-point divisor over the Hermitian curve <A>Hq</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "1PointHermitian_Divisor", [IsHermitian_Curve,IsList] );

#############################################################################
#############################################################################
##
## DIVISOR UTILITY FUNCTIONS
##
#############################################################################
#############################################################################

#############################################################################
##
#F  SupremumHermitian_Divisor(<D1>,<D2>)
##
##  <#GAPDoc Label="SupremumHermitian_Divisor">
##  <ManSection>
##  <Func Name="SupremumHermitian_Divisor" Arg='D1,D2'/>
##
##  <Description>
##  returns the place-wise maximum of the orders of <A>D1</A> and <A>D2</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "SupremumHermitian_Divisor" );

#############################################################################
##
#F  InfimumHermitian_Divisor(<D1>,<D2>)
##
##  <#GAPDoc Label="InfimumHermitian_Divisor">
##  <ManSection>
##  <Func Name="InfimumHermitian_Divisor" Arg='D1,D2'/>
##
##  <Description>
##  returns the place-wise minimum of the orders of <A>D1</A> and <A>D2</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "InfimumHermitian_Divisor" );

#############################################################################
##
#F  PositivePartOfHermitian_Divisor(<D>)
##
##  <#GAPDoc Label="PositivePartOfHermitian_Divisor">
##  <ManSection>
##  <Func Name="PositivePartOfHermitian_Divisor" Arg='D'/>
##
##  <Description>
##  returns the positive part of the divisor <A>D</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "PositivePartOfHermitian_Divisor" );

#############################################################################
##
#F  NegativePartOfHermitian_Divisor(<D>)
##
##  <#GAPDoc Label="NegativePartOfHermitian_Divisor">
##  <ManSection>
##  <Func Name="NegativePartOfHermitian_Divisor" Arg='D'/>
##
##  <Description>
##  returns the negative part of the divisor <A>D</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "NegativePartOfHermitian_Divisor" );

#############################################################################
##
#A  UnderlyingField(<D>)
##
##  <#GAPDoc Label="UnderlyingField_Div">
##  <ManSection>
##  <Attr Name="UnderlyingField" Arg='D'/>
##
##  <Description>
##  The underlying field of a Hermitian divisor is the field of coefficients
##  of the corresponding Hermitian curve.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "UnderlyingField", IsHermitian_Divisor );

#############################################################################
##
#A  Support(<D>)
##
##  <#GAPDoc Label="Support">
##  <ManSection>
##  <Attr Name="Support" Arg='D'/>
##
##  <Description>
##  The support of a Hermitian divisor is the set of points with nonzero orders.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Support", IsHermitian_Divisor );

#############################################################################
##
#F  Valuation(<D>,<pt>)
##
##  <#GAPDoc Label="Valuation">
##  <ManSection>
##  <Oper Name="Valuation" Arg='D,pt'/>
##
##  <Description>
##  The valuation of a Hermitian divisor <A>D</A> at the point <A>pt</A> is
##  its corresponding order. 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "Valuation", [IsHermitian_Divisor,IsList] );

#############################################################################
##
#A  IsRationalHermitian_Divisor(<D>)
##
##  <#GAPDoc Label="IsRationalHermitian_Divisor">
##  <ManSection>
##  <Attr Name="IsRationalHermitian_Divisor" Arg='D'/>
##
##  <Description>
##  Returns true if <A>D</A> is invariant under the Frobenius automorphism of the 
##  underlying Hermitian curve.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "IsRationalHermitian_Divisor", IsHermitian_Divisor );

#############################################################################
##
#F  PrincipalHermitian_Divisor(f)
##
##  <#GAPDoc Label="PrincipalHermitian_Divisor">
##  <ManSection>
##  <Oper Name="PrincipalHermitian_Divisor" Arg='Hq,f'/>
##
##  <Description>
##  returns the principal divisor of the rational function <A>f</A> of the
##  Hermitian curve <A>Hq</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "PrincipalHermitian_Divisor", [ IsHermitian_Curve, IsRationalFunction ] );

#############################################################################
##
#F  MultiplicityOfRoot_NotNeeded(<pol>,<t>)
##
##  Returns the multiplicity of the root <t> in the polynomial <pol>.
##
#DeclareGlobalFunction( "MultiplicityOfRoot_NotNeeded" );

#############################################################################
##
#F  ValuationAtPlace_NotNeeded(<t>,<ratfun>)
##
##  Returns the valuation of the rational function <ratfun> at the place <t>.
##  Taking no care of the indeterminate and other arguments.
##
#DeclareGlobalFunction( "ValuationAtPlace_NotNeeded" );
