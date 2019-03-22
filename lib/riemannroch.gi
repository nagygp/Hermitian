#############################################################################
##
#W  riemannroch.gi               HERmitian Package                  Gabor P. Nagy
##
##  Implementation file for Hermitian Riemann-Roch spaches
##
#Y  Copyright (C) 2019 Gabor P. Nagy (http://www.math.u-szeged.hu/~nagyg), 14/03/2019
##

#############################################################################
#############################################################################

# D is an arbitrary rational Hermitian divisor. Let D' be the normalized divisor of D.
# Returns: The pair [bas,ellprod] where <bas> is the basis of the vector represented Riemann-Roch space of D'
# and <ellprod> is the list for computing the common denominator.
HERM_normalizedRiemannRochSpaceOfHDiv_asmatrix:=function( D )
	local qq,dn,M,Ms,u;
	qq := Size( UnderlyingField( D ) );
	dn := HERM_normalizeHermitianDivisorAsList( D );
	Ms := [];
	if dn[1] < 0 then
		return [[],[]];
	fi;
	if dn[2] = [] then 
		M := HERM_linearConditionsForISectMultAtInfinity_NC( qq, dn[1], 0 ); # we only take the conditions for deg <= dn[1]
	else 
		for u in dn[2] do
			M := HERM_rationalLinCondsISectMult( qq, u[1][1], dn[1], u[2] );
			Add( Ms, List( M, r -> r{[1..Length(u[1])*u[2]]} ) );	# we cut the conditions for deg <= dn[1]
		od;
		Add( Ms, List( M, r -> r{[u[2]+1..Length(r)]}) );  # at the end we add the conditions for deg <= dn[1]
		M := List( [1..(dn[1]+1)*(Sqrt(qq)+1)], i -> Concatenation( List( Ms, u-> u[i] ) ) ); 
	fi;
	return [ NullspaceMat(M), dn[3] ];
end;


#############################################################################
#############################################################################

InstallGlobalFunction( Hermitian_RiemannRochSpaceBasis, function( D )
	local rr,ellprod,qq,x,y;
	if not( IsRationalHermitian_Divisor( D ) ) then 
		Error( "first argument must be a rational Hermitian divisor\n" ); 
	fi;
#	q := Sqrt( Size( UnderlyingField( D ) ) );
	qq := Size( UnderlyingField( D ) );
	x := IndeterminatesOfHermitian_Divisor( D )[1];
	y := IndeterminatesOfHermitian_Divisor( D )[2];
	rr := HERM_normalizedRiemannRochSpaceOfHDiv_asmatrix( D );
	ellprod := rr[2];
	rr := rr[1];
	rr := List( rr, r -> HERM_polyModHByCoefficients( qq, r , x , y ) );
	ellprod := List( ellprod, u ->
		Product([0..u[2]-1],r->u[1][1]^(qq^r)*x+u[1][2]^(qq^r)*y+u[1][3]^(qq^r))^u[3]
#		Product([0..u[2]-1],r->u[1][1]^(q^(2*r))*x+u[1][2]^(q^(2*r))*y+u[1][3]^(q^(2*r)))^u[3]
	);
	if ellprod = [] then 
		ellprod := One(x); 
	else 
		ellprod := Product( ellprod ); 
	fi;
	ellprod := HermitianReductionOfRatFunc( ellprod );   # corrected 
	return List( rr, r -> r / ellprod );
end );

#############################################################################
#############################################################################

