LoadPackage("HERmitian");

if not IsBound(q) then q:=4; fi;

Y:=HermitianIndeterminates(GF(q^2),"Y1","Y2");
Hq:=Hermitian_Curve(Y[1]);
P_infty:=1PointHermitian_Divisor(Hq,[infinity]); 

for s in [1..q^3] do
    hcode:=Hermitian_FunctionalCode(s*P_infty);
    rcode:=RestrictVectorSpace(hcode,GF(2));
    Print(s,"\t",Dimension(hcode),"\t",Dimension(rcode),"\t", DesignedMinimumDistance(hcode),"\n");
od;

pt:=RandomPlaceOfGivenDegreeOfHermitian_Curve(Hq,3);
a:=1PointHermitian_Divisor(Hq,pt);
fr:=FrobeniusAutomorphismOfHermitian_Curve(Hq);
d:=Sum(AC_FrobeniusAutomorphismOrbit(fr,a));
IsRationalHermitian_Divisor(d);

for s in [1..Int(q^3/3)] do
    hcode:=Hermitian_DifferentialCode(s*d);
#    hcode:=Hermitian_FunctionalCode(s*d);
    rcode:=RestrictVectorSpace(hcode,GF(2));
    Print(s,"\t",Dimension(hcode),"\t",Dimension(rcode),"\t", DesignedMinimumDistance(hcode),"\n");
od;
