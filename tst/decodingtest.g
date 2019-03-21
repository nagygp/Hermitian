LoadPackage("HERmitian");

#################

if not IsBound(q) then 
	q:=5^3;
fi;

# construct the curve and the divisors
Y:=Indeterminate(GF(q),"Y");
C:=Hermitian_Curve(GF(q),Y);
P_infty:=Hermitian_1PointDivisor(C,infinity); 

fr:=FrobeniusAutomorphismOfHermitian_Curve(C);
G0:=Sum(AC_FrobeniusAutomorphismOrbit(fr,RandomPlaceOfHermitian_Curve(C,4)));

#G:=Int(q/40+1)*G0+7*P_infty;
G:=Int(q/60+1)*G0+7*P_infty;
Degree(G);

len:=Int(0.8*q);
D:=Sum([1..len],i->Hermitian_1PointDivisor(C,Elements(GF(q))[i]));

# construct the AG differential code
agcode:=Hermitian_DifferentialCode(G,D);
DesignedMinimumDistance(agcode);
Length(agcode)-Degree(G)-1;

###
KnownAttributesOfObject(agcode);
Hermitian_DECODER_DATA(agcode); time;
KnownAttributesOfObject(agcode);
Hermitian_DECODER_DATA(agcode); time;

# test codeword generation
t:=Int((DesignedMinimumDistance(agcode)-1)/2);
sent:=Random(agcode);;
err:=RandomVectorOfGivenWeight(GF(q),Length(agcode),t);;
received:=sent+err;;

sent_decoded:=Hermitian_DecodeToCodeword(agcode,received);
sent=sent_decoded;

t:=2+Int((DesignedMinimumDistance(agcode)-1)/2);
sent:=Random(agcode);;
err:=RandomVectorOfGivenWeight(GF(q),Length(agcode),t);;
received:=sent+err;;

sent_decoded:=Hermitian_DecodeToCodeword(agcode,received);

t:=-2+Int((DesignedMinimumDistance(agcode)-1)/2);
sent:=Random(agcode);;
err:=RandomVectorOfGivenWeight(GF(q),Length(agcode),t);;
received:=sent+err;;

sent_decoded:=Hermitian_DecodeToCodeword(agcode,received);
sent=sent_decoded;


# construct the AG functional code
agcode:=Hermitian_FunctionalCode(G,D);
DesignedMinimumDistance(agcode);
Length(agcode)-Degree(G)-1;

###
KnownAttributesOfObject(agcode);
Hermitian_DECODER_DATA(agcode); time;
KnownAttributesOfObject(agcode);
Hermitian_DECODER_DATA(agcode); time;

# test codeword generation
t:=Int((DesignedMinimumDistance(agcode)-1)/2);
sent:=Random(agcode);;
err:=RandomVectorOfGivenWeight(GF(q),Length(agcode),t);;
received:=sent+err;;

sent_decoded:=Hermitian_DecodeToCodeword(agcode,received);
sent=sent_decoded;

t:=2+Int((DesignedMinimumDistance(agcode)-1)/2);
sent:=Random(agcode);;
err:=RandomVectorOfGivenWeight(GF(q),Length(agcode),t);;
received:=sent+err;;

sent_decoded:=Hermitian_DecodeToCodeword(agcode,received);

t:=-2+Int((DesignedMinimumDistance(agcode)-1)/2);
sent:=Random(agcode);;
err:=RandomVectorOfGivenWeight(GF(q),Length(agcode),t);;
received:=sent+err;;

sent_decoded:=Hermitian_DecodeToCodeword(agcode,received);
sent=sent_decoded;

