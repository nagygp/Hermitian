#############################################################################
##
#A  testall.tst                 HERmitian package                   Gabor P. Nagy
##
##  To create a test file, place GAP prompts, input and output exactly as
##  they must appear in the GAP session. Do not remove lines containing 
##  START_TEST and STOP_TEST statements.
##
##  The first line starts the test. START_TEST reinitializes the caches and 
##  the global random number generator, in order to be independent of the 
##  reading order of several test files. Furthermore, the assertion level 
##  is set to 2 by START_TEST and set back to the previous value in the 
##  subsequent STOP_TEST call.
##
##  The argument of STOP_TEST may be an arbitrary identifier string.
## 
gap> START_TEST("HERmitian package: testall.tst");
gap> SizeScreen([72]);
[ 72, 40 ]
gap> LoadPackage("HERmitian",false);
true
gap> 
gap> ### curves
gap> Y:=Indeterminate(GF(9),"Y");
Y
gap> C:=Hermitian_Curve(GF(9),Y);
<GZ curve over GF(9) with indeterminate Y>
gap> aut:=AutomorphismGroup(C);
<group of GZ curve automorphisms of size 720>
gap> Random(aut);
Hermitian_CurveAut([ [ Z(3)^0, Z(3)^0 ], [ Z(3^2), Z(3^2)^7 ] ])
gap> 
gap> ### divisors
gap> p1:=Hermitian_1PointDivisor(C,infinity);
<GZ divisor with support of length 1 over indeterminate Y>
gap> p2:=Hermitian_1PointDivisor(C,Z(3));  
<GZ divisor with support of length 1 over indeterminate Y>
gap> d:=3*p1-4*p2;
<GZ divisor with support of length 2 over indeterminate Y>
gap> Support(d);
[ infinity, Z(3) ]
gap> UnderlyingField(d);
GF(3^2)
gap> Zero(d);
<GZ divisor with support of length 0 over indeterminate Y>
gap> Characteristic(d);
3
gap> 
gap> d:=Hermitian_Divisor(C,[Z(27)^2,Z(3),infinity],[5,-1,2]);
<GZ divisor with support of length 3 over indeterminate Y>
gap> Valuation(Z(3),d);
-1
gap> Valuation(Z(3)^2,d);
0
gap> 
gap> fr:=AC_FrobeniusAutomorphism(9);
AC_FrobeniusAutomorphism(3^2)
gap> d^fr;
<GZ divisor with support of length 3 over indeterminate Y>
gap> Support(d^fr);
[ infinity, Z(3), Z(3^3)^18 ]
gap> Support(d);
[ infinity, Z(3), Z(3^3)^2 ]
gap> 
gap> rf:=Y^8-1;
Y^8-Z(3)^0
gap> List(GF(9),u->Valuation(u,rf));
[ 0, 1, 1, 1, 1, 1, 1, 1, 1 ]
gap> List(GF(9),u->Valuation(u,One(Y)));
[ 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
gap> List(GF(9),u->Valuation(u,Zero(Y)));
[ -infinity, -infinity, -infinity, -infinity, -infinity, -infinity, 
  -infinity, -infinity, -infinity ]
gap> 
gap> 
gap> List(GF(3),u->Valuation(u,One(Y)));
[ 0, 0, 0 ]
gap> List(GF(3),u->Valuation(u,Zero(Y)));
[ -infinity, -infinity, -infinity ]
gap> 
gap> ### RR spaces
gap> a:=RandomPlaceOfHermitian_Curve(C,4);
<GZ divisor with support of length 1 over indeterminate Y>
gap> fr:=FrobeniusAutomorphismOfHermitian_Curve(C);
AC_FrobeniusAutomorphism(3^2)
gap> d:=Sum(AC_FrobeniusAutomorphismOrbit(fr,a));
<GZ divisor with support of length 4 over indeterminate Y>
gap> IsRationalHermitian_Divisor(d);
true
gap> 
gap> Hermitian_RiemannRochSpaceBasis(3*d);
[ Z(3)^0/(Y^12+Z(3^2)^6*Y^9+Z(3^2)*Y^6+Z(3^2)^6*Y^3+Z(3)^0), 
  Y/(Y^12+Z(3^2)^6*Y^9+Z(3^2)*Y^6+Z(3^2)^6*Y^3+Z(3)^0), 
  Y^2/(Y^12+Z(3^2)^6*Y^9+Z(3^2)*Y^6+Z(3^2)^6*Y^3+Z(3)^0), 
  Y^3/(Y^12+Z(3^2)^6*Y^9+Z(3^2)*Y^6+Z(3^2)^6*Y^3+Z(3)^0), 
  Y^4/(Y^12+Z(3^2)^6*Y^9+Z(3^2)*Y^6+Z(3^2)^6*Y^3+Z(3)^0), 
  Y^5/(Y^12+Z(3^2)^6*Y^9+Z(3^2)*Y^6+Z(3^2)^6*Y^3+Z(3)^0), 
  Y^6/(Y^12+Z(3^2)^6*Y^9+Z(3^2)*Y^6+Z(3^2)^6*Y^3+Z(3)^0), 
  Y^7/(Y^12+Z(3^2)^6*Y^9+Z(3^2)*Y^6+Z(3^2)^6*Y^3+Z(3)^0), 
  Y^8/(Y^12+Z(3^2)^6*Y^9+Z(3^2)*Y^6+Z(3^2)^6*Y^3+Z(3)^0), 
  Y^9/(Y^12+Z(3^2)^6*Y^9+Z(3^2)*Y^6+Z(3^2)^6*Y^3+Z(3)^0), 
  Y^10/(Y^12+Z(3^2)^6*Y^9+Z(3^2)*Y^6+Z(3^2)^6*Y^3+Z(3)^0), 
  Y^11/(Y^12+Z(3^2)^6*Y^9+Z(3^2)*Y^6+Z(3^2)^6*Y^3+Z(3)^0), 
  Y^12/(Y^12+Z(3^2)^6*Y^9+Z(3^2)*Y^6+Z(3^2)^6*Y^3+Z(3)^0) ]
gap> ForAll(last,x->x=x^fr);
true
gap> 
gap> ### AG codes
gap> code:=Hermitian_FunctionalCode(d);
<[9,5] Hermitian AG-code over GF(3^2)>
gap> DesignedMinimumDistance(code);
5
gap> 
gap> ### decoding
gap> q:=5^3;
125
gap> # construct the curve and the divisors
gap> Y:=Indeterminate(GF(q),"Y");
Y
gap> C:=Hermitian_Curve(GF(q),Y);
<GZ curve over GF(125) with indeterminate Y>
gap> P_infty:=Hermitian_1PointDivisor(C,infinity); 
<GZ divisor with support of length 1 over indeterminate Y>
gap> 
gap> fr:=FrobeniusAutomorphismOfHermitian_Curve(C);
AC_FrobeniusAutomorphism(5^3)
gap> P4:=Sum(AC_FrobeniusAutomorphismOrbit(fr,RandomPlaceOfHermitian_Curve(C,4)));
<GZ divisor with support of length 4 over indeterminate Y>
gap> G:=5*P4+7*P_infty;
<GZ divisor with support of length 5 over indeterminate Y>
gap> Degree(G);
27
gap> 
gap> len:=90;
90
gap> D:=Sum([1..len],i->Hermitian_1PointDivisor(C,Elements(GF(q))[i]));
<GZ divisor with support of length 90 over indeterminate Y>
gap> 
gap> # construct the AG differential code
gap> agcode:=Hermitian_DifferentialCode(G,D);
<[90,62] Hermitian AG-code over GF(5^3)>
gap> DesignedMinimumDistance(agcode);
29
gap> Length(agcode)-Degree(G)-1;
62
gap> 
gap> # test codeword generation
gap> t:=Int((DesignedMinimumDistance(agcode)-1)/2);
14
gap> sent:=Random(agcode);;
gap> err:=RandomVectorOfGivenWeight(GF(q),Length(agcode),t);;
gap> received:=sent+err;;
gap> 
gap> # decoding
gap> sent_decoded:=Hermitian_DecodeToCodeword(agcode,received);
<cvec over GF(5,3) of length 90>
gap> sent=sent_decoded;
true
gap> 
gap> ### Example: BCH code construct
gap> my_BCH:=function(n,l,delta,F)
> 	local q,m,r,s,beta,Y,C,D_beta,P_0,P_infty,agcode;
> 	#
> 	q:=Size(F);
> 	m:=OrderMod(q,n);
> 	beta:=Z(q^m)^((q^m-1)/n);
> 	#
> 	Y:=Indeterminate(F,"Y");
> 	C:=Hermitian_Curve(GF(q^m),Y);
> 	D_beta:=Sum([0..n-1],i->Hermitian_1PointDivisor(C,beta^i));
> 	P_0:=Hermitian_1PointDivisor(C,0);
> 	P_infty:=Hermitian_1PointDivisor(C,infinity);
> 	#
> 	r:=l-1;
> 	s:=n+1-delta-l;
> 	agcode:=Hermitian_FunctionalCode(r*P_0+s*P_infty,D_beta);
> 	#
> 	return RestrictVectorSpace(agcode,F);
> end;
function( n, l, delta, F ) ... end
gap> 
gap> ####
gap> q:=2;
2
gap> n:=35;
35
gap> l:=1;
1
gap> delta:=5;
5
gap> 
gap> C0:=BCHCode(n,l,delta,GF(q)); 
a cyclic [35,11,5]8..13 BCH code, delta=5, b=1 over GF(2)
gap> C1:=my_BCH(n,l,delta,GF(q)); 
<vector space over GF(2), with 11 generators>
gap> 
gap> Collected(List(C0,x->Number(x,y->IsOne(y))));
[ [ 0, 1 ], [ 5, 7 ], [ 7, 5 ], [ 10, 56 ], [ 13, 105 ], [ 14, 10 ], 
  [ 15, 105 ], [ 16, 385 ], [ 17, 350 ], [ 18, 350 ], [ 19, 385 ], 
  [ 20, 105 ], [ 21, 10 ], [ 22, 105 ], [ 25, 56 ], [ 28, 5 ], 
  [ 30, 7 ], [ 35, 1 ] ]
gap> Collected(List(C1,x->Number(x,y->IsOne(y))));
[ [ 0, 1 ], [ 5, 7 ], [ 7, 5 ], [ 10, 56 ], [ 13, 105 ], [ 14, 10 ], 
  [ 15, 105 ], [ 16, 385 ], [ 17, 350 ], [ 18, 350 ], [ 19, 385 ], 
  [ 20, 105 ], [ 21, 10 ], [ 22, 105 ], [ 25, 56 ], [ 28, 5 ], 
  [ 30, 7 ], [ 35, 1 ] ]
gap> 
gap> SetDesignedMinimumDistance(C1,delta);
gap> DesignedMinimumDistance(C1);
5
gap> STOP_TEST( "testall.tst", 10000 );
## The first argument of STOP_TEST should be the name of the test file.
## The number is a proportionality factor that is used to output a 
## "GAPstone" speed ranking after the file has been completely processed.
## For the files provided with the distribution this scaling is roughly 
## equalized to yield the same numbers as produced by the test file 
## tst/combinat.tst. For package tests, you may leave it unchnaged. 

#############################################################################
##
#E
