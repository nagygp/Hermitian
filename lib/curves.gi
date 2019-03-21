#############################################################################
##
#W  curves.gi                   HERmitian Package                  Gabor P. Nagy
##
##  Implementation file for Hermitian curves
##
#Y  Copyright (C) 2019 Gabor P. Nagy (http://www.math.u-szeged.hu/~nagyg), 14/03/2019

#############################################################################
## GLOBAL PRIVATE VARIABLES AND FUNCTIONS 
# Returns a solution of x^q+x=c in GF(q^deg) or fail
HER_traceMapSolution:=function( q, deg, c )
	local bas, ret, tmat;
	bas := Basis( AsVectorSpace( GF( q ), GF( q^deg ) ) );
	tmat := List( List( BasisVectors( bas ), u -> u^q + u ), u -> Coefficients( bas, u ) );
	ret := SolutionMat( tmat, Coefficients( bas, c ) );
	if ret = fail then 
		return fail; 
	else 
		return LinearCombination( bas, ret ); 
	fi;
end;

#############################################################################
##  CONSTRUCTORS
##  -------------------------------------------------------------------------

#############################################################################
##
#F  Hermitian_Curve(<hratfn>)
##
InstallMethod( Hermitian_Curve, 
	"for finite field and two Hermitian indeterminates", 
	true, 
	[ IsRationalFunction ], 
	0, 
function( hratfn )
	local ret, indets, q;
	# input check
	indets := IndeterminatesOfHermitianRatFunc( hratfn );
	if indets = fail or indets = [] then
		Error("wrong input for Hermitian curve\n");
	fi;
	# object construction
	q := Sqrt( indets[1]!.herFieldSize );
	ret:=Objectify(
			NewType( Hermitian_CurveFamily, IsHermitian_Curve and IsHermitian_CurveRep ),
			rec(
				fieldsize := q^2,
				char := Characteristic( hratfn ),
				X := indets[1],
				Y := indets[2]
			)
		);
	return ret;
end);

#############################################################################
##
#F  IndeterminateOfHermitian_Curve(<Hq>)
##
InstallGlobalFunction( IndeterminatesOfHermitian_Curve, 
	Hq -> [ Hq!.X, Hq!.Y ]
);

#############################################################################
##  DISPLAYING AND COMPARING ELEMENTS
##  -------------------------------------------------------------------------

InstallMethod( ViewObj, "for a Hermitian curve",
	[ IsHermitian_Curve ],
function( Hq )
	Print( "<Hermitian curve over GF(", Hq!.fieldsize, ") with indeterminates ", IndeterminatesOfHermitian_Curve(Hq), ">" );
end );

InstallMethod( Display, "for a Hermitian curve",
	[ IsHermitian_Curve ],
function( Hq )
	Print( "<Hermitian curve over GF(", Hq!.fieldsize, ") with indeterminates ", IndeterminatesOfHermitian_Curve(Hq), ">" );
end );

InstallMethod( PrintObj, "for a Hermitian curve",
	[ IsHermitian_Curve ],
function( Hq )
	Print( "Hermitian_Curve(", Hq!.X, ")" );
end );

InstallMethod( \=, "for two Hermitian curves",
	IsIdenticalObj,
	[ IsHermitian_Curve, IsHermitian_Curve ],
function( H1q, H2q )
	return H1q!.X = H2q!.X;
end );

InstallMethod( \<, "for two Hermitian curves",
	IsIdenticalObj,
	[ IsHermitian_Curve, IsHermitian_Curve ],
function( H1q, H2q )
	return [ H1q!.fieldsize, IndeterminateNumberOfLaurentPolynomial( H1q!.X ) ] < 
		[ H2q!.fieldsize, IndeterminateNumberOfLaurentPolynomial( H2q!.X ) ];
end );

#############################################################################
##  UTILITIES
##  -------------------------------------------------------------------------

InstallMethod( Genus, 
	"for a Hermitian curve",
    [ IsHermitian_Curve ],
function( Hq )
	local q;
	q := Sqrt( Hq!.fieldsize );
	return q*(q-1)/2;
end );

InstallMethod( Characteristic,
        "for a Hermitian curve",
        [ IsHermitian_Curve ],
function( Hq )
	return Hq!.char;
end );

InstallMethod( UnderlyingField,
	"for a Hermitian curve",
	[ IsHermitian_Curve ],
function( Hq )
	return GF(Hq!.fieldsize);
end );

InstallMethod( FrobeniusAutomorphismOfHermitian_Curve,
        "for a Hermitian curve",
        [ IsHermitian_Curve ],
function( Hq )
	return AC_FrobeniusAutomorphism(Hq!.fieldsize);
end );

#############################################################################
##  PLACES
##  -------------------------------------------------------------------------

InstallOtherMethod( \in, 
        "for a list and a Hermitian curve",
        [ IsList, IsHermitian_Curve ],
function( pt, Hq )
	local q;
	if pt = [ infinity ] then 
		return true;
	fi;
	if not ( Length( pt ) = 2 
			and ForAll( pt, IsRingElement ) 
			and ForAll( pt, u->Characteristic(u) = Characteristic( Hq ) ) 
			) then
		#Error( "wrong format for 2nd argument\n" );
		return false;
	fi;
	q := Sqrt( Hq!.fieldsize );
	return pt[1]^(q+1)=pt[2]+pt[2]^q;
end );

InstallOtherMethod( \in, 
        "for a place and a Hermitian curve",
        [ IsHermitian_Place, IsHermitian_Curve ],
function( pt, Hq )
	return pt!.points[1] in Hq;
end );

InstallMethod( RandomPlaceOfGivenDegreeOfHermitian_Curve,
        "for a Hermitian curve",
        [ IsHermitian_Curve, IsPosInt ],
function( Hq, d )
	local qq,q,a,b,c;
	qq := Hq!.fieldsize;
	q := Sqrt(qq);
	a := Random( [ 0..qq^d ] );
	if a=0 then 
		return Hermitian_Place( Hq, [ infinity ] ); 
	fi;
	while true do
		a := Random( GF(qq^d) );
		c := a^(q+1);
		c := Trace( GF(qq^d), GF(qq), c - c^q );
		if IsZero( c ) then break; fi;
	od;
	b := HER_traceMapSolution( q, 2*d, a^(q+1) );
	return Hermitian_Place( Hq, [ a, b ] );
end );

InstallMethod( RandomRationalPlaceOfHermitian_Curve,
        "for a Hermitian curve",
        [ IsHermitian_Curve ],
function( Hq )
	return RandomPlaceOfGivenDegreeOfHermitian_Curve(Hq,1);
end );

InstallMethod( AllRationalAffinePlacesOfHermitian_Curve,
        "for a Hermitian curve",
        [ IsHermitian_Curve ],
function( Hq )
	local qq, q, a, b, c, li, i;
	qq := Hq!.fieldsize;
	q := Sqrt(qq);
	li := [ ];
	for a in GF(qq) do
		b := HER_traceMapSolution( q, 2, a^(q+1) );
		Add( li, [ a, b ] );
		if IsEvenInt(q) then
			for i in [0..q-2] do
				Add( li, [a,b+Z(qq)^((1+2*i)*(q+1))] );
			od;
		else
			for i in [0..q-2] do
				Add( li, [a,b+Z(qq)^((1+2*i)*(q+1)/2)] );
			od;
		fi;
	od;
	li := Set( li );
	return List( li, u -> Hermitian_Place( Hq, u ) );
end );

InstallMethod( AllRationalPlacesOfHermitian_Curve,
        "for a Hermitian curve",
        [ IsHermitian_Curve ],
function( Hq )
	return Concatenation( 
		[ Hermitian_Place( Hq, [ infinity ] ) ],
		AllRationalAffinePlacesOfHermitian_Curve( Hq )
	);
end );
