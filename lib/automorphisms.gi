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
	[ IsHermitian_Curve, IsMatrix and IsFFECollColl ],
function( hc, m) 
	if Length(m)<>3 or Length(m[1])<>3 or IsZero(DeterminantMat(m)) then
		Error("argument must be a 3x3 nonsingular matrix over a finite field\n");
	fi;
	return Objectify(
		NewType(Hermitian_CurveAutomorphismFamily,IsHermitian_CurveAutomorphism and IsHermitian_CurveAutomorphismRep),
		#[m/First(m[1],x->not(IsZero(x))),Characteristic(m)]); 
		rec(
			mat := m/First(m[1],x->not(IsZero(x))),
			curve := hc
		)
	);
end);

InstallMethod( Characteristic,
	"for a Hermitian curve automorphism",
	[ IsHermitian_CurveAutomorphism ],
function( x )
  return Characteristic( x!.curve );
end );


#############################################################################
##  DISPLAYING AND COMPARING ELEMENTS
##  -------------------------------------------------------------------------

InstallMethod( ViewObj, "for a Hermitian curve automorphism",
	[ IsHermitian_CurveAutomorphism ], 10,
function( obj )
	Print( "Hermitian_CurveAut(", obj!.mat, ")" );
end );

InstallMethod( Display, "for a Hermitian curve automorphism",
	[ IsHermitian_CurveAutomorphism ], 10,
function( obj )
	Print( "Hermitian_CurveAut(", obj!.mat, ")" );
end );

InstallMethod( PrintObj, "for a Hermitian curve automorphism",
	[ IsHermitian_CurveAutomorphism ], 10,
function( obj )
	Print( "Hermitian_CurveAut(", obj!.mat, ")" );
end );

InstallMethod( \=, "for two Hermitian curve automorphisms",
	IsIdenticalObj,
	[ IsHermitian_CurveAutomorphism, IsHermitian_CurveAutomorphism ],
function( m1,m2 )
	return m1!.curve = m2!.curve and m1!.mat = m2!.mat;
end );

InstallMethod( \<, "for two Hermitian curve automorphisms",
	IsIdenticalObj,
	[ IsHermitian_CurveAutomorphism, IsHermitian_CurveAutomorphism ],
function( m1, m2 )
	return m1!.mat < m2!.mat;;
end );


#############################################################################
##  MULTIPLICATION
##  -------------------------------------------------------------------------

InstallMethod( \*, "for two Hermitian curve automorphisms",
	IsIdenticalObj,
	[ IsHermitian_CurveAutomorphism, IsHermitian_CurveAutomorphism ],
function( m1, m2 )
	if m1!.curve=m2!.curve then 
		return Hermitian_CurveAutomorphism(m1!.curve, m1!.mat*m2!.mat);
	else
		Error("two Hermitian curve automorphisms must have the same characteristic\n");
	fi;
end );

InstallMethod( InverseMutable, "for a Hermitian curve automorphism and a positive integer",
	[ IsHermitian_CurveAutomorphism ],
function( m )
	return Hermitian_CurveAutomorphism(m!.curve, m!.mat^(-1));
end );

InstallMethod( OneMutable, "for a Hermitian curve automorphism",
	[ IsHermitian_CurveAutomorphism ],
function( m )
	return Hermitian_CurveAutomorphism(m!.curve, One(m!.mat)); 
end );

InstallMethod( \^, "for a Hermitian curve automorphism and a positive integer",
	[ IsHermitian_CurveAutomorphism, IsPosInt ],
function( m, k )
	return Hermitian_CurveAutomorphism(m!.curve, m!.mat^k);
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
	pts:=List(D!.points,u->List(u,uu->uu^fr));
	#pts:=List(D!.points,u->u^fr);
	return Hermitian_DivisorConstruct(D!.curve,pts,D!.orders);
end );

InstallOtherMethod( \^, "for a Hermitian curve automorphism and an AC-Frobenius automorphism",
	[ IsHermitian_CurveAutomorphism, IsAC_FrobeniusAutomorphism ],
function( m, fr )
	return Hermitian_CurveAutomorphism(m!.curve, m!.mat^fr);
end );



#############################################################################
## HERMITIAN CURVE AUTOMORPHISM ACTIONS
##  -------------------------------------------------------------------------

HERM_OnPointNC:=function( x, m )
	local ff, v;
	ff := UnderlyingField( m!.curve );
	v := x*(m!.mat);
	if IsZero(v[3]) then 
		v := v/v[2];
	else
		v := v/v[3];
	fi;
	return v;
end;

InstallOtherMethod( \^, "for a Hermitian divisor and a curve automorphism", 
	[ IsHermitian_Divisor, IsHermitian_CurveAutomorphism ],
function( D, m )
	return Hermitian_DivisorConstruct(D!.curve,List(D!.points,p->HERM_OnPointNC(p,m)),D!.orders);
end );

InstallOtherMethod( \^, "for a Hermitian AG-code and a curve automorphism", 
	[ IsHermitian_Code, IsHermitian_CurveAutomorphism ],
function( C, m )
	local fr;
	fr:=FrobeniusAutomorphismOfHermitian_Curve(C!.gzcurve);
	if m<>m^fr then
		Error("curve automorphism must be rational");
	fi;
	if IsHermitian_FunctionalCode(C) then 
		return Hermitian_FunctionalCode(C!.gendivs[1]^m,C!.gendivs[2]^m); 
	else
		return Hermitian_DifferentialCode(C!.gendivs[1]^m,C!.gendivs[2]^m);
	fi;	
end );

InstallOtherMethod( \^, "for a Hermitian rational function and a curve automorphism", 
	[ IsRationalFunction, IsHermitian_CurveAutomorphism ],
function(f,a)
    local y, b;
	if not IsHermitianRationalFunction( f ) then 
		TryNextMethod();
	fi;
    y := IndeterminatesOfHermitianRatFunc( f );
    if y = [] then return f; fi;
    b := [ y[1], y[2], 1 ] * (a!.mat^(-1));
    return Value( f, y, [ b[1]/b[3], b[2]/b[3] ] );
end );

#############################################################################
##  HERMITIAN CURVE AUTOMORPHISM GROUPS
##  -------------------------------------------------------------------------
InstallGlobalFunction( UnitaryGroupToHermitian_CurveAutGroup, 
function(matgr,C)
	local xset,projgr;
	projgr:=GroupWithGenerators(List(GeneratorsOfGroup(matgr),g->Hermitian_CurveAutomorphism(C,g)));
	xset:=ExternalSet(projgr,AllRationalPlacesOfHermitian_Curve(C));
	SetNiceMonomorphism(projgr,ActionHomomorphism(xset));
	SetIsHandledByNiceMonomorphism(projgr,true);
	SetName(projgr,Concatenation("<group of Hermitian curve automorphisms of size ",String(Size(projgr)),">"));
	projgr!.curve:=C;
	return projgr;
end );

HERM_GensOfGeneralUnitaryGroup := function(q) 
	local gens;
	gens:=[
		[[1,0,0],[0,0,1],[0,1,0]],
		[[Z(q^2),0,0],[0,Z(q^2)^(q+1),0],[0,0,1]]
	];
	if IsOddInt(q) then 
		Add(gens, [[1,0,0],[0,1,Z(q^2)^((q+1)/2)],[0,0,1]]);
		Add(gens, [[1,0,1],[1,1,1/2],[0,0,1]]);
	else
		Add(gens, [[1,0,0],[0,1,Z(q^2)^(q+1)],[0,0,1]]);
		Add(gens, [[1,0,1],[1,1,First(GF(q^2),t->t+t^q=Z(q)^0)],[0,0,1]]);
	fi;
	return gens*Z(q)^0;
end;

InstallOtherMethod( AutomorphismGroup, "for a Hermitian curve", 
	[ IsHermitian_Curve ],
function( C )
	local q, gu;
	q := Sqrt( Size( UnderlyingField( C ) ) );
	gu := GroupWithGenerators( HERM_GensOfGeneralUnitaryGroup( q ) );
	return UnitaryGroupToHermitian_CurveAutGroup(gu,C);
end );



























#E  automorphisms.gi . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
