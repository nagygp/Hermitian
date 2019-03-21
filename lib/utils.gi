#############################################################################
##
#W  utils.gi                  HERmitian Package                 Gabor P. Nagy
##
##  Utilities for arithmetics of Hermitian AG codes
##
#Y  Copyright (C) 2019 Gabor P. Nagy (http://www.math.u-szeged.hu/~nagyg), 14/03/2019


InstallGlobalFunction( UPolCoeffsToSmallFieldNC, function(f,q)
	local fe,i;
	fe:=ShallowCopy(ExtRepPolynomialRatFun(f));
	for i in [1..Length(fe)/2] do fe[2*i]:=Z(q)^LogFFE(fe[2*i],Z(q)); od;
	return PolynomialByExtRep(FamilyObj(f),fe);
end);

InstallGlobalFunction( RestrictVectorSpace, function(V,F) 
	local FF,fr_q,U,V1,mat,gens_q;
	FF:=LeftActingDomain(V);
	if Characteristic(V)<>Characteristic(F) then 
		Error("field and vector space must have the same characteristic");
	fi;
	if Dimension(V)=0 then 
		return V; 
	fi;
	if IsCVecRep(Basis(V)[1]) then 
		V:=VectorSpace(FF,List(Basis(V),Unpack)); 
	fi;
	fr_q:=AC_FrobeniusAutomorphism(Size(F));
	while true do
		if Dimension(V)=0 then break; fi;
		V1:=VectorSpace(FF,List(Basis(V),x->x^fr_q));
		if V=V1 then break; fi;
		V:=Intersection(V1,V);
	od;
	U:=AsVectorSpace(F,V);
	mat:=List(Basis(U),x->Coefficients(Basis(U),x^fr_q));
	if mat<>[] then
		gens_q:=List(NullspaceMat(mat-One(mat)),x->x*Basis(U));
	else
		gens_q:=[];
	fi;
	return Subspace(F^Length(Zero(V)),gens_q);
end);

##################################################
#
# Commands for error vector generation
#

InstallGlobalFunction( RandomVectorOfGivenWeight, function(F,n,k)
	local i,ret;
	ret:=List([1..n],i->Zero(F));
	for i in RandomCombination([1..n],k) do
		ret[i]:=Z(Size(F))^Random(1,Size(F)-1);
	od;
	return ret;
end);

InstallGlobalFunction( RandomVectorOfGivenDensity, function(F,n,delta)
	local i,ret;
	ret:=[];
	for i in [1..n] do
		if Random(1,2^16)<Int(delta*2^16) then 
			Add(ret,Z(Size(F))^Random(1,Size(F)-1));
		else
			Add(ret,Zero(F));
		fi;
	od;
	return ret;
end);


InstallGlobalFunction( RandomBinaryVectorOfGivenWeight, function(n,k)
	local i,ret;
	ret:=List([1..n],i->0*Z(2));
	for i in RandomCombination([1..n],k) do
		ret[i]:=Z(2);
	od;
	return ret;
end);

InstallGlobalFunction( RandomBinaryVectorOfGivenDensity, function(n,delta)
	local i,ret;
	ret:=[];
	for i in [1..n] do
		if Random(1,2^16)<Int(delta*2^16) then 
			Add(ret,Z(2));
		else
			Add(ret,0*Z(2));
		fi;
	od;
	return ret;
end);

