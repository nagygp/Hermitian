#############################################################################
##
#W  divisors.gi                  HERmitian Package                 Gabor P. Nagy
##
##  Implementation file for arithmetics of Hermitian divisors
##
#Y  Copyright (C) 2019 Gabor P. Nagy (http://www.math.u-szeged.hu/~nagyg), 14/03/2019

#############################################################################
##  CONSTRUCTORS
##  -------------------------------------------------------------------------

#############################################################################
##
#F  Hermitian_DivisorConstruct(<curve>,<pts>,<ords>)
##
InstallGlobalFunction( Hermitian_DivisorConstruct, function(curve,pts,ords)
	local perm,i,ret,one;
	# input check
	# same length and curve?
	if not(IsHermitian_Curve(curve) and Length(pts)=Length(ords)) then
		Error("wrong input for Hermitian divisor constructor\n");
	fi;
	one := One( UnderlyingField( curve) );
	if pts<>[] then
		# divisor points on the Hermitian curve?
		if not ForAll(pts,u->IsList(u) and Length(u)=3 and u in curve) then
			Error("wrong divisor (projective) points\n");
		fi;
		# make pts projective
		for i in [1..Length(pts)] do
			if IsZero( pts[i][3] ) then
				pts[i] := one*[0,1,0];
			else 
				pts[i] := pts[i]/pts[i][3];
			fi;
		od;
		# points in increasing order?
		perm:=Sortex(pts);
		ords:=Permuted(ords,perm);
		# orders integer?
		if not ForAll(ords,IsInt) then
			Error("orders must be integers\n");
		fi;
		# same point occurs several times?
		for i in [1..Length(pts)-1] do
			if pts[i]=pts[i+1] then
				ords[i+1]:=ords[i+1]+ords[i];
				ords[i]:=0;
			fi;
		od;
		i:=1;
		while true do
			# points with zero coefficients?
			if IsZero(ords[i]) then
				Remove(pts,i);
				Remove(ords,i);
				i:=i-1;
			fi;
			if i>=Length(pts) then break; else i:=i+1; fi;
		od;
	fi;
	# object construction
	ret:=Objectify(
			NewType(Hermitian_DivisorFamily, IsHermitian_Divisor and IsHermitian_DivisorRep),
			rec(points:=pts,orders:=ords,curve:=curve)
		);
	if ords = [ 1 ] then
		SetFilterObj( ret, IsHermitian_Place );
	fi;
	return ret;
end);

#############################################################################
##
#F  IndeterminateOfHermitian_Divisor(<D>)
##
InstallGlobalFunction( IndeterminatesOfHermitian_Divisor, function(D)
	return IndeterminatesOfHermitian_Curve(D!.curve);
end);

#############################################################################
##
#F  Hermitian_Divisor(curve,[[p_1,n_1],...,[p_k,n_k]])
#F  Hermitian_Divisor(curve,[p_1,...,p_k],[n_1,...,n_k])
##
InstallMethod( Hermitian_Divisor, "for curve, points and orders", true, [IsHermitian_Curve,IsList,IsList], 0,
function(curve,pts,ords)
	return Hermitian_DivisorConstruct(curve,pts,ords);
end);

InstallMethod( Hermitian_Divisor, "for curve and list of point/order pairs", true, [IsHermitian_Curve,IsList], 0,
function(curve,pairs)
	local pts,ords;
	pts:=List(pairs,u->u[1]);
	ords:=List(pairs,u->u[2]);
	return Hermitian_DivisorConstruct(curve,pts,ords);
end);

#############################################################################
##
#F  Hermitian_Place(curve,pt)
##
InstallMethod( Hermitian_Place, "for curve and a point", true, [IsHermitian_Curve,IsList], 0,
function(curve,pt)
	local one;
	one := One( UnderlyingField( curve ) );
	if pt = [ infinity ] then
		pt := one*[0,1,0];
	else
		pt := one*pt;
		if not pt in curve then
			Error("<pt> must be a point of <curve>");
		fi;
		if Length(pt) = 2 then
			Add(pt,one);
		elif IsZero(pt[3]) then
			pt := pt/pt[2];
		else 
			pt := pt/pt[3];
		fi;
	fi;
	return Hermitian_DivisorConstruct(curve,[pt],[1]);
end);


#############################################################################
##
#F  ZeroHermitian_Divisor(curve)
##
InstallMethod( ZeroHermitian_Divisor, "for curve", true, [IsHermitian_Curve], 0,
function(curve)
	return Hermitian_Divisor(curve,[],[]);
end);

InstallMethod( ZeroMutable, "for a Hermitian divisor",
	[ IsHermitian_Divisor ],
function( D )
	return ZeroHermitian_Divisor(D!.curve);
end );

#############################################################################
##  DISPLAYING AND COMPARING ELEMENTS
##  -------------------------------------------------------------------------

InstallMethod( ViewObj, "for a Hermitian place",
	[ IsHermitian_Place ], 100, 
function( D )
	Print( "<Hermitian place ", D!.points[1], " over indeterminates ", IndeterminatesOfHermitian_Divisor(D), ">" );
end );

InstallMethod( Display, "for a Hermitian place",
	[ IsHermitian_Place ], 100, 
function( D )
	Print( "<Hermitian place ", D!.points[1], " over indeterminates ", IndeterminatesOfHermitian_Divisor(D), ">" );
end );

InstallMethod( ViewObj, "for a Hermitian divisor",
	[ IsHermitian_Divisor ], 0,
function( D )
	Print( "<Hermitian divisor with support of length ", Size(D!.points), " over indeterminates ", IndeterminatesOfHermitian_Divisor(D), ">" );
end );

InstallMethod( Display, "for a Hermitian divisor",
	[ IsHermitian_Divisor ], 0,
function( D )
	Print( "<Hermitian divisor with support of length ", Size(D!.points), " over indeterminates ", IndeterminatesOfHermitian_Divisor(D), ">" );
end );

InstallMethod( PrintObj, "for a Hermitian divisor",
	[ IsHermitian_Divisor ],
function( D )
	Print( "Hermitian_Divisor(", D!.curve, ",", D!.points, ",", D!.orders, ")" );
end );

InstallMethod( \=, "for two Hermitian divisors",
	IsIdenticalObj,
	[ IsHermitian_Divisor, IsHermitian_Divisor ],
function( D1, D2 )
	return D1!.curve=D2!.curve and D1!.points=D2!.points and D1!.orders=D2!.orders;
end );

InstallMethod( \<, "for two Hermitian divisors of the same curve",
	IsIdenticalObj,
	[ IsHermitian_Divisor, IsHermitian_Divisor ],
function( D1, D2 )
	local ps, v1, v2;
	if D1!.curve <> D2!.curve then
		Error( "only Hermitian divisors of the same curve can be compared\n" );
	fi;
	ps := Union( D1!.points, D2!.points );
	v1 := List( ps, p -> Valuation( D1, p ) );
	v2 := List( ps, p -> Valuation( D2, p ) );
	return v1 > v2;
end );

#############################################################################
##  ADDITION
##  -------------------------------------------------------------------------

InstallMethod( \+, "for two Hermitian divisors",
	IsIdenticalObj,
	[ IsHermitian_Divisor, IsHermitian_Divisor ], 0,
function( D1, D2 )
	if D1!.curve<>D2!.curve then
		Error("two Hermitian divisors must belong to the same curve\n");
	else
		return Hermitian_DivisorConstruct(
				D1!.curve,
				Concatenation(D1!.points,D2!.points),
				Concatenation(D1!.orders,D2!.orders)
			);
	fi;
end );

InstallMethod( \-, "for two Hermitian divisors",
	IsIdenticalObj,
	[ IsHermitian_Divisor and IsHermitian_DivisorRep, IsHermitian_Divisor and IsHermitian_DivisorRep], 0,
function( D1, D2 )
	if D1!.curve<>D2!.curve then
		Error("two Hermitian divisors must belong to the same curve\n");
	else
		return Hermitian_DivisorConstruct(
				D1!.curve,
				Concatenation(D1!.points,D2!.points),
				Concatenation(D1!.orders,-(D2!.orders))
			);
	fi;
end );

InstallMethod( \*, "for an integer and a Hermitian divisor",
	[ IsInt, IsHermitian_Divisor ],
function( k, D )
	return Hermitian_DivisorConstruct(D!.curve,D!.points,k*D!.orders);
end );

InstallMethod( AdditiveInverseOp, "for a Hermitian divisor",
	[ IsHermitian_Divisor ],
function( D )
	return Hermitian_DivisorConstruct(D!.curve,D!.points,-D!.orders);
end );


#############################################################################
#############################################################################
##
## DIVISOR UTILITY FUNCTIONS
##
#############################################################################
#############################################################################

InstallMethod( Characteristic,
	"for a Hermitian divisor",
	[ IsHermitian_Divisor ],
function( D )
  return Characteristic(D!.curve);
end );

InstallMethod( UnderlyingField,
	"for a Hermitian divisor",
	[ IsHermitian_Divisor ],
function( D )
	return UnderlyingField(D!.curve);
end );

InstallMethod( Support,
	"for a Hermitian divisor",
	[ IsHermitian_Divisor ],
function( D )
  return D!.points;
end );

InstallMethod( Degree,
	"for a Hermitian divisor",
	[ IsHermitian_Divisor ],
function( D )
  return Sum(D!.orders);
end );

# We do not check it pt is on the Hermitian curve; we simply return 0.
InstallMethod( Valuation, "for a Hermitian divisor and a projective point",
	[ IsHermitian_Divisor, IsList ],
function( D, pt )
	local pos;
	pos:=Position(D!.points,pt);
	if pos=fail then
		return 0;
	else
		return D!.orders[pos];
	fi;
end );

InstallMethod( Valuation, "for a Hermitian divisor and a place",
	[ IsHermitian_Divisor, IsHermitian_Place ],
function( D, pt )
	return Valuation( D, pt!.points[1] );
end );

InstallGlobalFunction( HERM_polValueAtInfinitePlace,
function( f )
    local Y; # d, num, den, tdeg_num, tdeg_den, erep_num, erep_den, i_num, i_den;
    if IsZero( f ) then 
        return 0*Z( Characteristic( f ) );
    fi;
	Y := IndeterminatesOfHermitianRatFunc( f );
	if Y = [] then
		return ExtRepPolynomialRatFun( f )[2];
	else 
		return Value(Value(f,Y,[Y[1]/Y[2],1/Y[2]]),Y,[0,0]);
	fi;
end );

InstallMethod( Value, "for a Hermitian rational function and a Hermitian place",
	[ IsRationalFunction, IsHermitian_Place ],
function( f, pt )
	local fnum, fden;
	if not IsHermitianRationalFunction( f ) then
		TryNextMethod();
	fi;
	fnum := NumeratorOfRationalFunction( f );
	fden := DenominatorOfRationalFunction( f );
    if IsInfiniteHermitian_Place( pt ) then 
        return HERM_polValueAtInfinitePlace( f );
	elif IndeterminatesOfHermitianRatFunc( f ) = [ ] then
		return ExtRepPolynomialRatFun( fnum )[2];
    else
		pt := pt!.points[1]{[1,2]};
        fnum := Value( fnum, IndeterminatesOfHermitianRatFunc( f ), pt );
        fden := Value( fden, IndeterminatesOfHermitianRatFunc( f ), pt );
    fi;
    if not IsZero( fden ) then 
    	return fnum/fden;
    elif not IsZero( fnum ) then
        return infinity; 
    else 
        Error( "Evaluation map not implemented for 0/0\n" );
    fi;
end );


#############################################################################
#############################################################################

InstallGlobalFunction( InfimumHermitian_Divisor, function( D1, D2 )
	local sup,ord;
	if D1!.curve<>D2!.curve then
		Error("two Hermitian divisors must belong to the same function field\n");
	else
		sup:=Union(Support(D1),Support(D2));
		ord:=List(sup,p->Minimum(Valuation(D1,p),Valuation(D2,p)));
		return Hermitian_DivisorConstruct(D1!.curve,sup,ord);
	fi;
end );

InstallGlobalFunction( SupremumHermitian_Divisor, function( D1, D2 )
	local sup,ord;
	if D1!.curve<>D2!.curve then
		Error("two Hermitian divisors must belong to the same function field\n");
	else
		sup:=Union(Support(D1),Support(D2));
		ord:=List(sup,p->Maximum(Valuation(D1,p),Valuation(D2,p)));
		return Hermitian_DivisorConstruct(D1!.curve,sup,ord);
	fi;
end );

InstallGlobalFunction( PositivePartOfHermitian_Divisor, function( D )
	return SupremumHermitian_Divisor(D,Zero(D));
end );

InstallGlobalFunction( NegativePartOfHermitian_Divisor, function( D )
	return SupremumHermitian_Divisor(-D,Zero(D));
end );

InstallMethod( IsRationalHermitian_Divisor,
	"for a Hermitian divisor",
	[ IsHermitian_Divisor ],
function( D )
	local fr;
	fr:=FrobeniusAutomorphismOfHermitian_Curve(D!.curve);
	return D=D^fr;
end );

#############################################################################
#############################################################################

InstallMethod( PrincipalHermitian_Divisor, 
	"for a Hermitian curve and a rational function",
	[ IsHermitian_Curve, IsRationalFunction ],
	0,
function( Hq,f )
	local D,S,q;
#	if IndeterminatesOfCurve(C)<>IndeterminateOfUnivariateRationalFunction(f) then
#		Error("rational function and curve mismatch");
#	fi;
	if IsZero(f) then
		Error("second argument cannot be the zero polynomial");
	fi;
	if IsPolynomial(f) then
		D:=[f,One(f)];
	else
		D:=[NumeratorOfRationalFunction(f),DenominatorOfRationalFunction(f)];
	fi;
	q := Sqrt( Hq!.fieldsize );
	S := List( D, u -> 
		List( HERM_hermitianIntersection(Hq,u,-1), pt->[pt,HERM_isectmultAtHpt_exact(Hq,pt,u)] )
	);
	S := List( S, s -> Hermitian_Divisor( Hq, s ) );
	D := List( D, d -> HERM_totalDegreeOfPolynomial(d)*(q+1)*Hermitian_Place(Hq,[infinity]) );
	return S[1]-S[2]-(D[1]-D[2]);
end );

InstallMethod( IsInfiniteHermitian_Place,
	"for a Hermitian place",
	[ IsHermitian_Place ],
function( pt )
	return IsZero( pt!.points[1][3] );
end );

#############################################################################
##  HERMITIAN DIVISORS FOR AG-CODES
##  -------------------------------------------------------------------------

#############################################################################
# Def: The divisor 
#	D=mu*(q+1)*P_\infty-(m_0P_\infty+m_1P_1+...+m_kP_k)
# is *normalized* if for all i=0,...,k, P_i is a rational place of degree r_i and 0<=m_i<=q.

# Let D be a rational divisor. Define the integer mu and the divisor 
# E = m1*(P11+...+P1r1)+...+mk*(Pk1+...+Pkrk)
# such that 
# a) [Pi1,...,Piri] are Frobenius orbits of Hermitian points of degree ri,
# b) 0 <= mi <= q for all i,
# c) D is equivalent to mu*(q+1)*P_\infty - E. 
#############################################################################

# returns a list of entries [[P_1,...,P_d],m] where P_1+...+P_d is a rational place of degree d
# and m is its valuation.
HERM_rationalHermitianDivisorAsList:=function( D )
	local frob,pos;
	if not(IsRationalHermitian_Divisor(D)) then 
		Error("argument must be a rational Hermitian divisor\n"); 
	fi;
	frob:=FrobeniusAutomorphismOfHermitian_Curve(D!.curve);
	pos:=List(D!.points,p->PositionSorted(D!.points,p^frob));
	pos:=Orbits(Group(PermList(pos)),[1..Length(D!.points)]);
	pos:=Set(pos,Set);
	Apply(pos,u->[D!.points{u},D!.orders[u[1]]]);
	return pos;
end;

# Returns: the triple [mu,[[[P11,...,P1r1],m1],...,[[Pk,...,Pkrk],mk]],ellprod] 
HERM_normalizeHermitianDivisorAsList:=function( D )
	local q,li,mu,m1,m2,i,ret,ellprod,u,v;
	if not(IsRationalHermitian_Divisor(D)) then 
		Error("argument must be a rational Hermitian divisor\n"); 
	fi;
	q:=Sqrt(Size(UnderlyingField(D)));
	li:=HERM_rationalHermitianDivisorAsList(D);
	mu:=0;
	ret:=[];
	ellprod:=[];
	for i in [1..Length(li)] do
		m2:=(-li[i][2]) mod (q+1);
		m1:=(li[i][2]+m2)/(q+1);
		mu:=mu+m1*Length(li[i][1]);
		if m2>0 then 
			Add(ret,[li[i][1],m2]); 
		fi;
		if m1<>0 and li[i][1][1]<>Z(q)^0*[0,1,0] then 
			u:=li[i][1][1];
			Add(ellprod,[[u[1]^q,-u[3]^q,-u[2]^q],Length(li[i][1]),m1]);
		fi;
	od;
	return [mu,ret,ellprod];
end;

# Returns: The divisor D' = (q^3+q^2-q-2)P_\infty - D
HERM_linearCodeDivisorFromDifferentialCodeHermitianDivisor:=function( D )
	local q;
	if not(IsRationalHermitian_Divisor(D)) then 
		Error("argument must be a rational Hermitian divisor\n"); 
	fi;
	q:=Sqrt(Size(UnderlyingField(D)));
	return (q^3+q^2-q-2)*Hermitian_Place(q^2,[infinity]) - D;
end;

