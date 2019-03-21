# Test(Filename(DirectoriesPackageLibrary("HERmitian"),"../tst/testall.tst"));
#LogTo("/tmp/HERmitiantest.log");
#START_TEST("HERmitian package: testall.tst");
#SizeScreen([72]);
#LoadPackage("HERmitian",false);

LoadPackage("HERmitian");

### curves
q:=5;
Y:=HermitianIndeterminates(GF(q^2),"Y1","Y2");
Hq:=Hermitian_Curve(Y[1]);
#aut:=AutomorphismGroup(C);
#Random(aut);

UnderlyingField(Hq);
p:=RandomPlaceOfGivenDegreeOfHermitian_Curve(Hq,3);
p in Hq;
[ infinity ] in Hq;
[0,0] in Hq;
Z(q)*[0,0] in Hq;
AllRationalPlacesOfHermitian_Curve(Hq);

### divisors
p1:=1PointHermitian_Divisor(Hq,[infinity]);
p2:=1PointHermitian_Divisor(Hq,p);  
d:=3*p1-4*p2;
Support(d);
UnderlyingField(d);
Zero(d);
Characteristic(d);

Valuation(d,p);
Valuation(d,[1,2]);

fr:=FrobeniusAutomorphismOfHermitian_Curve(Hq);
d^fr;
Support(d^fr);
Support(d);

s1:=HERM_hermitianIntersection(Hq,Y[1],-1);
s2:=HERM_hermitianIntersection(Hq,Y[2],-1);
List(s1,pt->[pt,HERM_isectmultAtHpt_exact(Hq,pt,Y[1])]);
List(s2,pt->[pt,HERM_isectmultAtHpt_exact(Hq,pt,Y[2])]);

HERM_hermitianIntersection(Hq,One(Y[1]),-1);

d:=PrincipalHermitian_Divisor(Hq,Y[1]^2/(Y[1]+Y[2]));
Print(d);
Degree(d);

### RR spaces
pt:=RandomPlaceOfGivenDegreeOfHermitian_Curve(Hq,3);
a:=1PointHermitian_Divisor(Hq,pt);
fr:=FrobeniusAutomorphismOfHermitian_Curve(Hq);
d:=Sum(AC_FrobeniusAutomorphismOrbit(fr,a));
IsRationalHermitian_Divisor(d);

bb:=Hermitian_RiemannRochSpaceBasis(5*d);
Size(bb);
ForAll(bb,x->x=x^fr);
ForAll(bb,x->PrincipalHermitian_Divisor(Hq,x)>=-5*d);

### AG codes
Hermitian_FunctionalCode(5*d);
a:=Sum(Difference(AllRationalPlacesOfHermitian_Curve(Hq),[[infinity]]),p->1PointHermitian_Divisor(Hq,p));
code:=Hermitian_FunctionalCode(8*d,a);
Print(code);
DesignedMinimumDistance(code);
LeftActingDomain(code);
UnderlyingField(code);

### decoding
q:=4;
# construct the curve and the divisors
Y:=HermitianIndeterminates(GF(q^2),"Y1","Y2");
Hq:=Hermitian_Curve(Y[1]);
P_infty:=1PointHermitian_Divisor(Hq,[infinity]); 

fr:=FrobeniusAutomorphismOfHermitian_Curve(Hq);
P4:=RandomPlaceOfGivenDegreeOfHermitian_Curve(Hq,5);
P4:=1PointHermitian_Divisor(Hq,P4);
P4:=Sum(AC_FrobeniusAutomorphismOrbit(fr,P4));
G:=5*P4+7*P_infty;
Degree(G);

len:=50;
affpts:=Difference( AllRationalPlacesOfHermitian_Curve(Hq), [[infinity]]);;
D:=Sum([1..len],i->1PointHermitian_Divisor(Hq,affpts[i]));

# construct the AG differential code
agcode:=Hermitian_DifferentialCode(G,D);
DesignedMinimumDistance(agcode);
Length(agcode)-Degree(G)-1;

# test codeword generation
t:=Int((DesignedMinimumDistance(agcode)-1-Genus(G!.curve))/2);
sent:=Random(agcode);;
err:=RandomVectorOfGivenWeight(GF(q),Length(agcode),t);;
received:=sent+err;;

# decoding
sent_decoded:=Hermitian_DecodeToCodeword(agcode,received);
sent=sent_decoded;

#######################
#######################
#######################

#STOP_TEST( "testall.tst", 10000 );
#LogTo();

