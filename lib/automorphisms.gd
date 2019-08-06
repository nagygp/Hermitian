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
##  algebraic function field <M>K(C)</M>. For Hermitian curves over finite fields, the algebraic function
##  field is the field <M>K(t)</M> of rational functions in one indeterminate. <M>Aut(K(t))</M> consists of
##  fractional linear mappings <M>t\mapsto \frac{a+bt}{c+dt}</M>, where <M>ad-bc\neq 0</M>. Hence,
##  <M>Aut(K(t))\cong PGL(2,K)</M>.
##  <P/>With fixed Frobenius automorphism <M>\Phi:x\mapsto x^q</M>, we can speak of <M>GF(q)</M>-rational
##  automorphisms, or, automorphisms defined over <M>GF(q)</M>. These form a subgroup isomorphic to
##  <M>PGL(2,q)</M>, having a faithful permutation representation of the set <M>GF(q)\cup \{\infty\}</M>
##  of <M>GF(q)</M>-rational places.
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
##  <Oper Name="Hermitian_CurveAutomorphism" Arg='mat'/>
##
##  <Returns>
##  the automorphism <M>t\mapsto \frac{a+bt}{c+dt}</M> of the Hermitian curve, where <A>M</A> is the
##  nonsingular <M>2\times 2</M> matrix <M>\begin{pmatrix}a &amp; c\\ b&amp; d\end{pmatrix}</M>.
##  </Returns>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation("Hermitian_CurveAutomorphism", [ IsHermitian_Curve, IsMatrix and IsFFECollColl ]);
DeclareSynonym("Hermitian_CurveAut",Hermitian_CurveAutomorphism);

#############################################################################
##
#C  MatrixGroupToHermitian_CurveAutGroup(<matgr>,<agcode>)
##
##  <#GAPDoc Label="Hermitian_CurveAutGroup">
##  <ManSection> <Heading>AutomorphismGroup</Heading>
##  <Func Name="MatrixGroupToHermitian_CurveAutGroup" Arg='matgr,C'/>
##
##  <Returns>
##  the GZ curve automorphism group $G$ corresponding to the matrix group <A>matgr</A>.
##  </Returns>
##  <Description>
##  The permutation action of <A>matgr</A> on the set of rational places of <A>C</A> is stored as
##  a nice monomorphism of $G$.
##  </Description>
##
##  <Oper Name="AutomorphismGroup" Arg='C'/>
##  <Returns>
##  the automorphism group of the Hermitian curve <A>C</A>. The elements are Hermitian automorphisms. The
##  group is isomorphic to <M>PGL(2,q)</M>, where <M>GF(q)</M> is the underlying field of <A>C</A>.
##  </Returns>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "MatrixGroupToHermitian_CurveAutGroup" );

#E  automorphisms.gd . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here#! @Arguments matgr,orb
