###################################################################################
##
#W  automorphisms.gi                   HERmitian Package                  Gabor P. Nagy
##
##  Implementation file for automorphisms of Hermitian curves and their codes
##
#Y  Copyright (C) 2019 Gabor P. Nagy (http://www.math.u-szeged.hu/~nagyg), 14/03/2019
##

#############################################################################
##  CONSTRUCTORS
##  -------------------------------------------------------------------------

InstallMethod( Hermitian_CurveAutomorphism, "for a matrix over a finite field",
	[ IsMatrix and IsFFECollColl ],
function(m) 
	if Length(m)<>2 or Length(m[1])<>2 or IsZero(m[1][1]*m[2][2]-m[1][2]*m[2][1]) then
		Error("argument must be a 2x2 nonsingular matrix over a finite field\n");
	fi;
	return Objectify(
		NewType(Hermitian_CurveAutomorphismFamily,IsHermitian_CurveAutomorphism and IsHermitian_CurveAutomorphismRep),
		[m/First(m[1],x->not(IsZero(x))),Characteristic(m)]); 
end);

InstallMethod( Characteristic,
	"for a GZ curve automorphism",
	[ IsHermitian_CurveAutomorphism ],
function( x )
  return x![2];
end );


#############################################################################
##  DISPLAYING AND COMPARING ELEMENTS
##  -------------------------------------------------------------------------

InstallMethod( ViewObj, "for a GZ curve automorphism",
	[ IsHermitian_CurveAutomorphism ], 10,
function( obj )
	Print( "Hermitian_CurveAut(", obj![1], ")" );
end );

InstallMethod( Display, "for a GZ curve automorphism",
	[ IsHermitian_CurveAutomorphism ], 10,
function( obj )
	Print( "Hermitian_CurveAut(", obj![1], ")" );
end );

InstallMethod( PrintObj, "for a GZ curve automorphism",
	[ IsHermitian_CurveAutomorphism ], 10,
function( obj )
	Print( "Hermitian_CurveAut(", obj![1], ")" );
end );

InstallMethod( \=, "for two GZ curve automorphisms",
	IsIdenticalObj,
	[ IsHermitian_CurveAutomorphism, IsHermitian_CurveAutomorphism ],
function( m1,m2 )
	return m1![1] = m2![1];
end );

InstallMethod( \<, "for two GZ curve automorphisms",
	IsIdenticalObj,
	[ IsHermitian_CurveAutomorphism, IsHermitian_CurveAutomorphism ],
function( m1, m2 )
	return m1![1] < m2![1];;
end );


#############################################################################
##  MULTIPLICATION
##  -------------------------------------------------------------------------

InstallMethod( \*, "for two GZ curve automorphisms",
	IsIdenticalObj,
	[ IsHermitian_CurveAutomorphism, IsHermitian_CurveAutomorphism ],
function( m1, m2 )
	if m1![2]=m2![2] then 
		return Hermitian_CurveAutomorphism(m1![1]*m2![1]);
	else
		Error("two GZ curve automorphisms must have the same characteristic\n");
	fi;
end );

InstallMethod( InverseMutable, "for a GZ curve automorphism and a positive integer",
	[ IsHermitian_CurveAutomorphism ],
function( m )
	return Hermitian_CurveAutomorphism(m![1]^(-1));
end );

InstallMethod( OneMutable, "for a GZ curve automorphism",
	[ IsHermitian_CurveAutomorphism ],
function( m )
	return Hermitian_CurveAutomorphism(One(m![1])); 
end );

InstallMethod( \^, "for a GZ curve automorphism and a positive integer",
	[ IsHermitian_CurveAutomorphism, IsPosInt ],
function( m, k )
	return Hermitian_CurveAutomorphism(m![1]^k);
end );

#############################################################################
##  AC-FROBENIUS ACTIONS
##  -------------------------------------------------------------------------

InstallOtherMethod( \^, "for infinity and an AC-Frobenius automorphism",
	[ IsInfinity, IsAC_FrobeniusAutomorphism ],
function( x, fr )
	return x;
end );

InstallOtherMethod( \^, "for singleton list with infinity and an AC-Frobenius automorphism",
	[ IsList, IsAC_FrobeniusAutomorphism ],
	0,
function( x, fr )
	if x = [ infinity ] then 
		return x;
	else
		TryNextMethod();
	fi;
end );

InstallOtherMethod( \^, "for a Hermitian divisor and an AC-Frobenius automorphism",
	[ IsHermitian_Divisor, IsAC_FrobeniusAutomorphism ],
function( D, fr )
	local pts;
	if Characteristic(D)<>Characteristic(fr) then Error("the arguments must have the same characteristic\n"); fi;
	pts:=List(D!.points,u->u^fr);
	return Hermitian_DivisorConstruct(D!.curve,pts,D!.orders);
end );

InstallOtherMethod( \^, "for a GZ curve automorphism and an AC-Frobenius automorphism",
	[ IsHermitian_CurveAutomorphism, IsAC_FrobeniusAutomorphism ],
function( m, fr )
	return Hermitian_CurveAutomorphism(m![1]^fr);
end );


#############################################################################
##  GZ CURVE AUTOMORPHISM ACTIONS
##  -------------------------------------------------------------------------

InstallOtherMethod( \^, "for an AC-Frobenius automorphism and infinity",
	[ IsInfinity, IsAC_FrobeniusAutomorphism ],
function( x, fr )
	return x;
end );

InstallOtherMethod( \^, "for a Hermitian divisor and an AC-Frobenius automorphism",
	[ IsHermitian_Divisor, IsAC_FrobeniusAutomorphism ],
function( D, fr )
	local pts;
	if Characteristic(D)<>Characteristic(fr) then Error("the arguments must have the same characteristic\n"); fi;
	pts:=List(D!.points,u->List(u,uu->uu^fr));
	#pts:=List(D!.points,u->u^fr);
	return Hermitian_DivisorConstruct(D!.curve,pts,D!.orders);
end );

InstallOtherMethod( \^, "for normed row vector and a GZ curve automorphism", 
	[ IsFFECollection, IsHermitian_CurveAutomorphism ],
function( x, m )
	local y;
	if Characteristic(x)<>Characteristic(m) then 
		Error("the arguments must have the same characteristic");
	fi;
	y:=First(x,u->not(IsZero(u)));
	if y=fail or not(IsOne(y)) then
		Error("action only defined for normed row vectors");
	fi;
	y:=OnLines(x,m![1]);
	if IsCVecRep(x) then
		return CVec(y,CVecClass(x));
	else
		return y;
	fi;
end );

InstallOtherMethod( \^, "for a finite field element and a GZ curve automorphism", 
	[ IsFFE, IsHermitian_CurveAutomorphism ],
function( x, m )
	m:=m![1];
	if IsZero(m[1][1]+x*m[2][1]) then
		return infinity;
	else
		return (m[1][2]+x*m[2][2])/(m[1][1]+x*m[2][1]);
	fi;
end );

InstallOtherMethod( \^, "for infinity and a GZ curve automorphism", 
	[ IsInfinity, IsHermitian_CurveAutomorphism ],
function( x, m )
	m:=m![1];
	if IsZero(m[2][1]) then
		return infinity;
	else
		return m[2][2]/m[2][1];
	fi;
end );

InstallOtherMethod( \^, "for a Hermitian divisor and a GZ curve automorphism", 
	[ IsHermitian_Divisor, IsHermitian_CurveAutomorphism ],
function( D, m )
	return Hermitian_DivisorConstruct(D!.curve,OnTuples(D!.points,m),D!.orders);
end );

InstallOtherMethod( \^, "for a Hermitian AG-code and a GZ curve automorphism", 
	[ IsHermitian_Code, IsHermitian_CurveAutomorphism ],
function( C, m )
	local fr;
	fr:=FrobeniusAutomorphismOfHermitian_Curve(C!.gzcurve);
	if m<>m^fr then
		Error("curve automorphism must be rational");
	fi;
	if IsHermitian_FunctionalCode(C) then 
		return Hermitian_FunctionalCode(C!.gendivs[1]^fr,C!.gendivs[2]^fr); 
	else
		return Hermitian_DifferentialCode(C!.gendivs[1]^fr,C!.gendivs[2]^fr);
	fi;	
end );

#############################################################################
##  GZ CURVE AUTOMORPHISM GROUPS
##  -------------------------------------------------------------------------
InstallGlobalFunction( MatrixGroupToHermitian_CurveAutGroup, 
function(matgr,C)
	local xset,projgr;
	projgr:=GroupWithGenerators(List(GeneratorsOfGroup(matgr),Hermitian_CurveAutomorphism));
	xset:=ExternalSet(projgr,Concatenation(Elements(UnderlyingField(C)),[infinity]));
	SetNiceMonomorphism(projgr,ActionHomomorphism(xset));
	SetIsHandledByNiceMonomorphism(projgr,true);
	SetName(projgr,Concatenation("<group of GZ curve automorphisms of size ",String(Size(projgr)),">"));
	projgr!.curve:=C;
	return projgr;
end );

InstallOtherMethod( AutomorphismGroup, "for a Hermitian curve", 
	[ IsHermitian_Curve ],
function( C )
	return MatrixGroupToHermitian_CurveAutGroup(GL(2,Size(UnderlyingField(C))),C);
end );



























#E  automorphisms.gi . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
