#############################################################################
##
#W  functions.gi                HERmitian Package               Gabor P. Nagy
##
##  Implementation file for Hermitian function fields 
##  The underlying Hermitian curve has equation x^(q+1) = y^q + y
##
#Y  Copyright (C) 2019 Gabor P. Nagy (http://www.math.u-szeged.hu/~nagyg), 14/03/2019

#############################################################################
## GLOBAL PRIVATE VARIABLES AND FUNCTIONS 

#############################################################################
##
#F  HERM_INDET_DICT
##
InstallValue( HERM_INDET_DICT, NewDictionary( [0,0], true) );

#############################################################################
##
#F  HERM_IndeterminateNumbersOfRationalFunctions
##
InstallGlobalFunction( HERM_IndeterminateNumbersOfRationalFunctions, 
function( ratfn )
	local c, i, j, ret;
	ret := [];
	c := ExtRepNumeratorRatFun( ratfn );
	if not IsPolynomial( ratfn ) then 
		c := Concatenation( c, ExtRepDenominatorRatFun( ratfn ) );
	fi;
	for i in [1..Length(c)/2] do 
		for j in [1..Length(c[2*i-1])/2] do
			Add(ret,c[2*i-1][2*j-1]);
		od; 
	od;
	return Set(ret);
end );

#############################################################################
##
#F  HERM_IndeterminateNumbersOfHermitianRatFunc
##
##  returns: fail if not Hermitian, [] if constant polynomial, [n1,n2] if Hermitian
##
InstallGlobalFunction( HERM_IndeterminateNumbersOfHermitianRatFunc, 
function( ratfn )
	local n, x;
	n := HERM_IndeterminateNumbersOfRationalFunctions( ratfn );
	if Length( n ) > 2 then 
		return fail; 
	fi;
	if Length( n ) = 0 then 
		return []; 
	fi;
	x := List( n, i -> 	LookupDictionary( HERM_INDET_DICT, [ Characteristic( ratfn ), i ] ) );
	if fail in x then
		return fail;
	fi;
	if Length( n ) = 2 and ( n[1] <> x[2]!.nrAssocHermIndet ) then
		return fail;
	fi;
	if Length( n ) = 1 then 
		Add( n, x[1]!.nrAssocHermIndet );
		Add( x, LookupDictionary( HERM_INDET_DICT, [ Characteristic( ratfn ), n[2] ] ) );
	fi;
	if IsHermitianYIndeterminate( x[1] ) then 
		n := n{[2,1]};
	fi;
	return n;
end );

#############################################################################
##
#F  HERM_PolynomialReduction_NC
##
InstallGlobalFunction( HERM_PolynomialReduction_NC, 
function( pol, x, y, q )
	local cpol, cH;
	cpol := PolynomialCoefficientsOfPolynomial( pol, x );
	cH := PolynomialCoefficientsOfPolynomial( x^(q+1)-y^q-y, x );
	ReduceCoeffs( cpol, cH );
	return ValuePol( cpol, x );
end );


#############################################################################
##  HERMITIAN VARIABLES AND RATIONAL FUNCTIONS

InstallTrueMethod( IsHermitianIndeterminate, IsHermitianXIndeterminate );
InstallTrueMethod( IsHermitianIndeterminate, IsHermitianYIndeterminate );

#############################################################################
##
#F  HermitianIndeterminates
##
InstallMethod( HermitianIndeterminates, "for finite field and two strings", true, [ IsField, IsString, IsString ], 0,
function( field, name1, name2 )
	local x, y, nx, ny;
	if not ( IsFinite( field ) and IsSquareInt( Size( field ) ) ) then 
		Error("field must be finite of square order\n");
	fi;
	x := Indeterminate( field, name1 );
	y := Indeterminate( field, name2 );
	nx := IndeterminateNumberOfUnivariateRationalFunction( x );
	ny := IndeterminateNumberOfUnivariateRationalFunction( y );
	AddDictionary( HERM_INDET_DICT, [ Characteristic( field ), nx ], x );
	AddDictionary( HERM_INDET_DICT, [ Characteristic( field ), ny ], y );
	SetFilterObj( x, IsHermitianXIndeterminate );
	SetFilterObj( y, IsHermitianYIndeterminate );
	x!.nrAssocHermIndet := ny;
	y!.nrAssocHermIndet := nx;
	x!.herFieldSize := Size( field );
	y!.herFieldSize := Size( field );
	return [x,y];
end );

#############################################################################
##
#F  IsHermitianRationalFunction
##
InstallMethod( IsHermitianRationalFunction, "", true, [ IsRationalFunction ], 0, 
function( ratfn )
	local n;
	n := HERM_IndeterminateNumbersOfHermitianRatFunc( ratfn );
	if n = fail then 
		return false; 
	else
		return true;
	fi;
end );

#############################################################################
##
#F  IsHermitianPolynomial
##
InstallMethod( IsHermitianPolynomial, "for a rational function", true, [ IsRationalFunction ], 0, 
	pol -> IsPolynomial( pol ) and IsHermitianRationalFunction( pol )
);

#############################################################################
##
#F  IndeterminatesOfHermitianRatFunc
##
InstallMethod( IndeterminatesOfHermitianRatFunc, "for a rational function", true, [ IsRationalFunction ], 0, 
function( ratfn )
	local n;
	n := HERM_IndeterminateNumbersOfHermitianRatFunc( ratfn );
	if n = fail then 
		Error( "argument must be a Hermitian rational function\n" );
	fi;
	return List( n, i -> LookupDictionary( HERM_INDET_DICT, [ Characteristic( ratfn ), i ] ) );
end );

#############################################################################
##
#F  HermitianReductionOfRatFunc
##
InstallMethod( HermitianReductionOfRatFunc, true, [ IsRationalFunction ], 0,
function( ratfn )
	local denom, numer, q, xy;
	xy := IndeterminatesOfHermitianRatFunc( ratfn );
	if xy = [] then	
		return ratfn;
	fi;
	q := Sqrt( xy[1]!.herFieldSize );
	numer := NumeratorOfRationalFunction( ratfn );
	numer := HERM_PolynomialReduction_NC(numer,xy[1],xy[2],q);
	denom := DenominatorOfRationalFunction( ratfn );
	denom := HERM_PolynomialReduction_NC(denom,xy[1],xy[2],q);
	return numer/denom;
end );

#############################################################################
#############################################################################

# returns the polynomial in x,y with coefficients given by <vec>
HERM_polyModHByCoefficients:=function(qq,vec,x,y)
	local q,deg,ret;
	if not(IsUnivariatePolynomial(x) and IsUnivariatePolynomial(y)) then
	   Error("wrong input, arguments 2 and 3 must be indeterminates\n"); 
	fi;
	if vec = [] then return Zero( x ); fi;
	if not( IsFFECollection( vec ) ) then 
		Error("wrong input, argument 1 must be a list of finite field elements\n"); 
	fi;
	q := Sqrt( qq );
	while 0 <> Length( vec ) mod (q+1) do 
		Add( vec, Zero( x ) ); 
	od;
	deg := Length( vec ) / (q+1) - 1;
	ret := List( [0..deg], i -> ValuePol( vec{ [ i*(q+1)+1..(i+1)*(q+1) ] }, x ) );
	ret := ValuePol( ret, y );
	return ret;
end;


	