###################################################################################
##
#W  automorphisms.gd                   HERmitian Package                  Gabor P. Nagy
##
##  Declaration file for automorphisms of Hermitian curves and their codes
##
#Y  Copyright (C) 2019 Gabor P. Nagy (http://www.math.u-szeged.hu/~nagyg), 14/03/2019
##

#############################################################################
##
#C  IsHermitian_CurveAutomorphism(<obj>)
##
##  <#GAPDoc Label="IsHermitian_CurveAutomorphism">
##  <ManSection>
##  <Filt Name="IsHermitian_CurveAutomorphism" Arg='obj' Type='Category'/>
##
##  <Description>
##  With automorphisms of an algebraic curve <M>C</M> one means the automorphisms of the corresponding
##  algebraic function field <M>K(C)</M>. For a Hermitian curve <M>H(q)</M> over a finite field, 
##  <M>Aut(GF(q)(H(q)))</M> is isomorphic to the projective general linear group <M>PGU(3,q)</M>.
##  In particular, an automorphism of <M>H(q)</M> can be represented by a <M>3\times 3</M> unitary
##  matrix over <M>GF(q^2)</M>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHermitian_CurveAutomorphism", IsMultiplicativeElementWithInverse );
DeclareRepresentation( "IsHermitian_CurveAutomorphismRep", IsComponentObjectRep and IsMultiplicativeElement, [ "mat", "curve" ] );
Hermitian_CurveAutomorphismFamily:=NewFamily("Hermitian_CurveAutomorphismFam");

#############################################################################
##
#C  Hermitian_CurveAutomorphism(<obj>)
##
##  <#GAPDoc Label="Hermitian_CurveAutomorphism">
##  <ManSection>
##  <Oper Name="Hermitian_CurveAutomorphism" Arg='Hq,mat'/>
##
##  <Returns>
##  The automorphism of the Hermitian curve <M>H(q)</M>, given by the unitary matrix <A>mat</A>.
##  </Returns>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation("Hermitian_CurveAutomorphism", [ IsHermitian_Curve, IsMatrix and IsFFECollColl ]);
DeclareSynonym("Hermitian_CurveAut",Hermitian_CurveAutomorphism);

#############################################################################
##
#C  UnitaryGroupToHermitian_CurveAutGroup(<matgr>,<agcode>)
##
##  <#GAPDoc Label="Hermitian_CurveAutGroup">
##  <ManSection> <Heading>AutomorphismGroup</Heading>
##  <Func Name="UnitaryGroupToHermitian_CurveAutGroup" Arg='matgr,Hq'/>
##
##  <Returns>
##  the group <M>G</M> of automorphisms of the Hermitian curve <A>Hq</A>, which correspond to the unitary group <A>matgr</A>.
##  </Returns>
##  
##  <Description>
##  The permutation action of <A>matgr</A> on the set of rational places of <A>Hq</A> is stored as
##  a nice monomorphism of <M>G</M>.
##  </Description>
##
##  <Oper Name="AutomorphismGroup" Arg='Hq'/>
##  <Returns>
##  The automorphism group of the Hermitian curve <A>Hq</A>. The elements are Hermitian curve automorphisms. The
##  group is isomorphic to <M>PPG(3,q)</M>, where <M>GF(q^2)</M> is the underlying field of <A>Hq</A>.
##  </Returns>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "UnitaryGroupToHermitian_CurveAutGroup" );

#E  automorphisms.gd . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here#! @Arguments matgr,orb
