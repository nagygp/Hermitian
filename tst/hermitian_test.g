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

UnderlyingField(Hq);
p:=RandomPlaceOfGivenDegreeOfHermitian_Curve(Hq,3);
p in Hq;
[ infinity ] in Hq;
[0,0] in Hq;
Z(q)*[0,0] in Hq;
Hermitian_Place(Hq,[0,1,0]);
Size( AllRationalPlacesOfHermitian_Curve(Hq) );

### divisors
p_infty:=Hermitian_Place(Hq,[infinity]);
d:=3*p_infty-4*p;
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


### HERM_hermitianIntersection for private usage
s1:=HERM_hermitianIntersection(Hq,Y[1],-1);
s2:=HERM_hermitianIntersection(Hq,Y[2],-1);
List(s1,pt->[pt,HERM_isectmultAtHpt_exact(Hq,pt,Y[1])]);
List(s2,pt->[pt,HERM_isectmultAtHpt_exact(Hq,pt,Y[2])]);

HERM_hermitianIntersection(Hq,One(Y[1]),-1);

d:=PrincipalHermitian_Divisor(Hq,Y[1]^2/(Y[1]+Y[2]));
Print(d);
Degree(d);

### RR spaces
a:=RandomPlaceOfGivenDegreeOfHermitian_Curve(Hq,3);
fr:=FrobeniusAutomorphismOfHermitian_Curve(Hq);
d:=Sum(AC_FrobeniusAutomorphismOrbit(fr,a));
IsRationalHermitian_Divisor(d);

bb:=Hermitian_RiemannRochSpaceBasis(5*d);
Size(bb);
ForAll(bb,x->x=x^fr);
ForAll(bb,x->PrincipalHermitian_Divisor(Hq,x)>=-5*d);

### AG codes
Hermitian_FunctionalCode(5*d);
a:=Sum(AllRationalAffinePlacesOfHermitian_Curve(Hq));
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
P_infty:=Hermitian_Place(Hq,[infinity]); 

fr:=FrobeniusAutomorphismOfHermitian_Curve(Hq);
P4:=RandomPlaceOfGivenDegreeOfHermitian_Curve(Hq,5);
P4:=Sum(AC_FrobeniusAutomorphismOrbit(fr,P4));
G:=5*P4+7*P_infty;
Degree(G);

len:=50;
affpts:=AllRationalAffinePlacesOfHermitian_Curve(Hq);;
D:=Sum(affpts{[1..len]});

# construct the AG differential code
Hermitian_DifferentialCode(G);
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

### automorphisms
aut:=AutomorphismGroup(Hq);
Random(aut);

#######################
#######################
#######################

#STOP_TEST( "testall.tst", 10000 );
#LogTo()

