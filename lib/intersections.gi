#############################################################################
##
#W  intersections.gi                  HERmitian Package                 Gabor P. Nagy
##
##  Implementation file for intersections of curves with the Hermitian curve
##
#Y  Copyright (C) 2019 Gabor P. Nagy (http://www.math.u-szeged.hu/~nagyg), 14/03/2019

#############################################################################
##  CONSTRUCTORS
##  -------------------------------------------------------------------------

#############################################################################
##
#F  Hermitian_DivisorConstruct(<curve>,<pts>,<ords>)
##

# returns the total degree of the polynomial <pol>
InstallGlobalFunction( HERM_totalDegreeOfPolynomial, 
function(pol)
	local ret;
    if IsZero(pol) then Error("zero polynomial has no total degree\n"); fi;
    if IsFFE(pol) then return 0; fi;
	ret:=LeadingMonomialOfPolynomial(pol,MonomialGrlexOrdering());
	ret:=ExtRepPolynomialRatFun(ret)[1];
	ret:=Sum(2*[1..Length(ret)/2],i->ret[i]);
	return ret;
end );

# returns a power series expansion in indeterminate <u> of X^(Sqrt(qq)+1)=Y^Sqrt(qq)+Y at <pt> modulo x^k (up to degree <k>)
InstallGlobalFunction( HERM_powerSeriesAtHpt_NC, 
function(Hq,pt,k) 
	local a,ret,t,q,u;
	q:=Sqrt(Hq!.fieldsize); 
	a:=pt[1];
    u:=Hq!.X;
	ret:=a^q*u; 
	t:=(a-a^(q^2)+u)*u^q;
	while DegreeIndeterminate(t,IndeterminateNumberOfUnivariateRationalFunction(u))<=k do
		ret:=ret+t;
		t:=-t^q;
	od;
	return ret; 
end );

# returns those points of intersection of Hq with pol=0, whose degree is <=deglim.
# Each point occurs once. 
InstallGlobalFunction( HERM_hermitianIntersection, 
function(Hq,pol,deglim)
	local XY,xy,q,resx,fs,ys,xs,ret;
    if IsZero(pol) then 
        Error("zero polynomial has no intersection with the curve\n"); 
    fi;
    if HERM_totalDegreeOfPolynomial(pol)=0 then 
        return [];
    fi;
	XY:=IndeterminatesOfHermitian_Curve(Hq);
	xy:=List(XY,IndeterminateNumberOfUnivariateRationalFunction);
	if HERM_totalDegreeOfPolynomial(pol)>DegreeIndeterminate(pol,xy[2]) then 
        ret:=[[infinity]]; 
    else 
        ret:=[]; 
    fi;
	q:=Sqrt(Hq!.fieldsize);
	resx:=Resultant(pol,XY[1]^(q+1)-XY[2]^q-XY[2],xy[1]);
    if IsZero(resx) then 
        Error("zero polynomial has no intersection with the curve\n"); 
    fi;
    if DegreeIndeterminate(resx,xy[2])=0 then
        return [];
    fi;
	for fs in Factors(PolynomialRing(GF(q^2)),resx) do
		if deglim<=0 or Degree(fs)<=deglim then 
			for ys in RootsOfUPol("split",fs) do
				for xs in RootsOfUPol("split",Gcd(One(XY[1])*Value(pol,[xy[2]],[ys]),XY[1]^(q+1)-ys^q-ys)) do
					Add(ret,[xs,ys]);
				od;
			od;
		fi;
	od;
	ret:=Set(ret);
	return ret;
end );

# Let i.m. be the intersection multiplicity of f=0 with X^(Sqrt(qq)+1)=Y^Sqrt(qq)+Y at the affine point <pt>.
# returns min(Sqrt(qq),i.m.)
InstallGlobalFunction( HERM_isectmultAtHptOrq, 
function(Hq,pt,f)
	local u,xy,q,pt0,f0;
	if not(pt in Hq) then Error("point <pt> not on the Hermitian curve\n"); fi;
	q:=Sqrt(Hq!.fieldsize);
	xy:=IndeterminatesOfHermitian_Curve(Hq);
	if pt=[infinity] then 
		f0:=(xy[2]^HERM_totalDegreeOfPolynomial(f))*Value(f,xy,[xy[1]/xy[2],1/xy[2]]);
		f0:=AsPolynomial(f0);
		pt0:=Z(q)*[0,0];
	else
		f0:=f;
		pt0:=ShallowCopy(pt);
	fi;
	u:=Value(f0,xy,[pt0[1]+xy[1],pt0[2]+pt0[1]^q*xy[1]]);
	return Minimum(q,CoefficientsOfLaurentPolynomial(u)[2]);
end );


# returns the intersection multiplicity of f=0 with X^(Sqrt(qq)+1)=Y^Sqrt(qq)+Y at the affine point <pt>
InstallGlobalFunction( HERM_isectmultAtHpt_exact, 
function(Hq,pt,f)
	local u,xy,q,pt0,f0;
	if not(pt in Hq) then Error("point <pt> not on the Hermitian curve\n"); fi;
	q:=Sqrt(Hq!.fieldsize);
	xy:=IndeterminatesOfHermitian_Curve(Hq);
	if pt=[infinity] then 
		f0:=(xy[2]^HERM_totalDegreeOfPolynomial(f))*Value(f,xy,[xy[1]/xy[2],1/xy[2]]);
		f0:=AsPolynomial(f0);
		pt0:=Z(q)*[0,0];
	else
		f0:=f;
		pt0:=ShallowCopy(pt);
	fi;
	u:=HERM_powerSeriesAtHpt_NC(Hq,pt0,(q+1)*HERM_totalDegreeOfPolynomial(f0));
	u:=Value(f0,xy,pt0+[xy[1],u]);
	return CoefficientsOfLaurentPolynomial(u)[2];
end );

#############################################################################
#############################################################################

# returns elm as an element of GF(q^2) or fail
# This is needed by some stupid bug in AsInternalFFE()
InstallGlobalFunction( HERM_asGFq2Elm, 
function(qq,elm)
	elm:=AsInternalFFE(elm);
	if elm=fail then 
		return fail;
	fi;
	if IsZero(elm) then 
		return 0*Z(qq); 
	else 
		return Z(qq)^LogFFE(elm,Z(qq)); 
	fi; 
end );

# returns Tr_{k/GF(qq)}(v) where v is a FF vector and k is the closure field of v
InstallGlobalFunction( HERM_tracemap4vector, 
function(qq,vec)
	local L;
	L:=Field(Concatenation([Z(qq)],vec));
	return List(vec,u->HERM_asGFq2Elm(qq,Trace(L,GF(qq),u)));
end );

#############################################################################
#############################################################################

# Returns the system of linear conditions for the coefficients of the curves C 
# such that deg(C)=deg and I(pt;C,H(q))>=k.
# Works only for k<=q.
InstallGlobalFunction( HERM_linearConditionsForISectMult_NC, 
function(qq,pt,deg,k)
	local M,q,vj,uivj,i,j,nrow,zp;
	M:=[];
	q:=Sqrt(qq);
	# Computing the conditions for <pt>
	vj:=[Z(q)^0];
	for j in [0..deg] do
		uivj:=ShallowCopy(vj);
		for i in [0..q] do
			if i+j<=deg then 
				Add(M,Concatenation(uivj,[Length(uivj)+1..k]*0*Z(q)));
			else
				Add(M,[1..k]*0*Z(q));
			fi;
			uivj:=ProductCoeffs(uivj,[pt[1],Z(q)^0]);
			if Length(uivj)>k then uivj:=uivj{[1..k]}; fi;
		od;
		vj:=ProductCoeffs(vj,[pt[2],pt[1]^q]);
		if Length(vj)>k then vj:=vj{[1..k]}; fi;
	od;
	# Adding the conditions for degree <= deg
	if q>deg then 
		zp:=(q+1)*(deg+1)-(deg+1)*(deg+2)/2; 
	else 
		zp:=q*(q+1)/2; 
	fi;
	nrow:=0*Z(q)*[1..zp];
	Apply(M,u->Concatenation(u,nrow));
	zp:=1;
	for j in [0..deg] do
		for i in [0..q] do
			if i+j>deg then 
				M[i+1+j*(q+1)][k+zp]:=Z(q)^0;
				zp:=zp+1;
			fi;
		od;
	od;
	return M;
end );

# Returns the system of GF(q^2)-rational linear conditions for the coefficients of the curves C 
# such that deg(C)=deg and I(pt;C,H(q))>=k for all Frobenius images of <pt>.
# Works only for k<=q.
InstallGlobalFunction( HERM_rationalLinCondsISectMult_NC, 
function(qq,pt,deg,k)
	local M,Mrat,q,vj,uivj,i,j,nrow,zp,L,bas,b;
	M:=[];
	q:=Sqrt(qq);
	# Computing the conditions for <pt>
	vj:=[Z(q)^0];
	for j in [0..deg] do
		uivj:=ShallowCopy(vj);
		for i in [0..q] do
			if i+j<=deg then 
				Add(M,Concatenation(uivj,[Length(uivj)+1..k]*0*Z(q)));
			else
				Add(M,[1..k]*0*Z(q));
			fi;
			uivj:=ProductCoeffs(uivj,[pt[1],Z(q)^0]);
			if Length(uivj)>k then uivj:=uivj{[1..k]}; fi;
		od;
		vj:=ProductCoeffs(vj,[pt[2],pt[1]^q]);
		if Length(vj)>k then vj:=vj{[1..k]}; fi;
	od;
	# Rationalization
	TransposedMatDestructive(M);
	L:=Field([Z(qq),pt[1],pt[2]]);
	L:=AsField(GF(qq),L);
	bas:=NormalBase(L);
	Mrat:=[];
	for b in Elements(bas) do
		Add(Mrat,List(M,u->HERM_tracemap4vector(qq,b*u)));
	od;
	M:=Concatenation(Mrat);
	TransposedMatDestructive(M);
	# Adding the conditions for degree <= deg
	if q>deg then 
		zp:=(q+1)*(deg+1)-(deg+1)*(deg+2)/2; 
	else 
		zp:=q*(q+1)/2; 
	fi;
	nrow:=0*Z(q)*[1..zp];
	b:=Length(M[1]);
	Apply(M,u->Concatenation(u,nrow));
	zp:=1;
	for j in [0..deg] do
		for i in [0..q] do
			if i+j>deg then 
				M[i+1+j*(q+1)][b+zp]:=Z(q)^0;
				zp:=zp+1;
			fi;
		od;
	od;
	return M;
end );

# Returns the system of GF(q^2)-rational linear conditions for the coefficients of the curves C 
# such that deg(C)=deg and I(P_\infty;C,H(q^2))>=k for all Frobenius images of <pt>.
# Works only for k<=q.
InstallGlobalFunction( HERM_linearConditionsForISectMultAtInfinity_NC, 
function(qq,deg,k)
	local q,M,zp,i,j;
	q:=Sqrt(qq);
	if k>q then
		Error("k>q is not supposed to happen!\n");
	fi;
	if k>deg then 
		Info(InfoHermitian, 1, "Warning: If k>deg then ell_infty had to be a component!"); 
	fi;
	if q>deg then 
		zp:=(q+1)*(deg+1)-(deg+1)*(deg+2)/2; 
	else 
		zp:=q*(q+1)/2; 
	fi;
   	M:=List([1..(deg+1)*(q+1)],i->Z(q)*0*[1..k+zp]);
	zp:=1;
	for j in [0..deg] do
		for i in [0..q] do
			if i+j=deg and i<k then
				M[i+1+j*(q+1)][i+1]:=Z(q)^0;
			fi;
			if i+j>deg then 
				M[i+1+j*(q+1)][k+zp]:=Z(q)^0;
				zp:=zp+1;
			fi;
		od;
	od;
	return M;
end );

InstallGlobalFunction( HERM_rationalLinCondsISectMult, 
function(qq,pt,deg,k)
   	if not(IsPrimePowerInt(qq) and IsSquareInt(qq)) then Error("wrong first argument\n"); fi;
	#if not(pt=[infinity] or isHpt(qq,pt)) then Error("second argument must be a Hermitian point\n"); fi;
	if not(IsInt(deg) and deg>=0) then Error("wrong third argument\n"); fi;
	if not(IsInt(k)) then Error("fourth argument must be an integer\n"); fi;
	if k<1 or k^2>qq then Error("fourth argument must be between 1 and <q>\n"); fi; 
	if pt=[infinity] then 
		return HERM_linearConditionsForISectMultAtInfinity_NC(qq,deg,k);
	else
		return HERM_rationalLinCondsISectMult_NC(qq,pt,deg,k);
	fi;
end );