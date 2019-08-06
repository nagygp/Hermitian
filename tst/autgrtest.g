LoadPackage("HERmitian");

#################

if not IsBound(q) then 
	q:=4;
fi;

# construct the curve and the divisors
Y:=HermitianIndeterminates(GF(q^2),"Y1","Y2");
Hq:=Hermitian_Curve(Y[1]);
P_infty:=Hermitian_Place(Hq,[infinity]); 

gens := HERM_GensOfGeneralUnitaryGroup( q );
gu:=Group(gens);
Size(gu);
# hc:=Orbit(gu,[0,1,0]*Z(q)^0,OnLines);; Size(hc);
# ForAll(hc,u->u[1]^(q+1)=u[2]*u[3]^q+u[2]^q*u[3]);

pgu:=AutomorphismGroup(Hq);
Random(pgu)!.mat in gu;

h:=Stabilizer(pgu,P_infty);

hom:=NiceMonomorphism(pgu);
cc:=List(ConjugacyClassesMaximalSubgroups(Image(hom)),Representative);
List(cc,Size);

uxset:=AsList(UnderlyingExternalSet(hom));;
xs:=List(cc,x->List(Orbits(x),o->Set(uxset{o}));;
List(xs,x->List(x,Size));

List(xs,x->Stabilizer(pgu,x[1],OnSets));
