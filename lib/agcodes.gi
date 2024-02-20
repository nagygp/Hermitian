#############################################################################
##
#W  agcodes.gi                   HERmitian Package                  Gabor P. Nagy
##
##  Implementation file for Hermitian agcodes
##
#Y  Copyright (C) 2019 Gabor P. Nagy (http://www.math.u-szeged.hu/~nagyg), 14/03/2019

#############################################################################
##
#F  IsHermitian_Code(<obj>)
##
InstallTrueMethod( IsHermitian_Code, IsHermitian_FunctionalCode );
InstallTrueMethod( IsHermitian_Code, IsHermitian_DifferentialCode );


#############################################################################
##  CONSTRUCTORS
##  -------------------------------------------------------------------------

#############################################################################
##
#F  GeneratorMatrixOfAffineFunctionalHermitian_CodeNC(<G>,<pls>)
##
InstallGlobalFunction( GeneratorMatrixOfAffineFunctionalHermitian_CodeNC, function(G,pls) 
	local  i,j,cl,rr,crr,pts,cmat,row,r,deg,q,ellprod,denom;
	rr:=HERM_normalizedRiemannRochSpaceOfHDiv_asmatrix(G);
	ellprod:=rr[2];
	rr:=rr[1];
	pts:=Difference(pls,Support(G));
	q:=Sqrt( Size( UnderlyingField( G ) ) );
	if rr=[] then 
		return CVEC_ZeroMat(0,CVecClass(GF(q^2),Length(pts)));
	fi;
	deg:=Length(rr[1])/(q+1)-1;
	# Convert to CVEC
	cl:=CVecClass(GF(q^2),(q+1)*(deg+1));
	crr:=CVEC_ZeroMat(0,cl);
	for r in rr do 
		if not IsPlistRep(r) then
			r:=Unpack(r);
		fi;
		Add(crr,CVec(r,GF(q^2)));
	od;
	cmat:=CVEC_ZeroMat(0,cl);
	# compute the matrix of monomials, modified by the values of <ellprod>
	for r in pts do
		row:=CVec(cl);
		for i in [0..q] do for j in [0..deg] do
			row[j*(q+1)+i+1]:=r[1]^i*r[2]^j;
		od; od;
		denom:=Z(q)^0*Product(ellprod,u->(u[1][1]*r[1]+u[1][2]*r[2]+u[1][3])^((q^(2*u[2])-1)/(q^2-1)*u[3]));
		if IsZero(denom) then 
			denom:=0*Z(q);
		else
			denom:=Z(q^2)^(-LogFFE(denom,Z(q^2)));
		fi;
		MultRowVector(row,denom);
		Add(cmat,row);
	od;
	cmat:=crr*TransposedMat(cmat);
	if Degree(G)<Length(pts) then
		return cmat;
	else
		return Vectors(SemiEchelonBasisMutable(cmat));
	fi;
	#MakeImmutable(ret); return ret;
end);

#############################################################################
##
#F  Hermitian_FunctionalCode(<G>,<D>)
#F  Hermitian_FunctionalCode(<G>)
##
InstallMethod( Hermitian_FunctionalCode, "for two Hermitian divisors", true, [IsHermitian_Divisor,IsHermitian_Divisor], 0, 
function(G,D)
	local genmat,code,ff,len;
	if not (IsRationalHermitian_Divisor(G) and IsRationalHermitian_Divisor(D) and Set(D!.orders)=[1]) then
		Error("wrong input\n");
	fi;
	if not Intersection(Support(G),Support(D))=[] then 
		Error("supports of divisors must be disjoint\n");
	fi;
	if One( UnderlyingField( D ) ) * [0,1,0] in Support( D ) then
		Error("support of the 2nd argument must be affine\n");
	fi;
	genmat:=GeneratorMatrixOfAffineFunctionalHermitian_CodeNC(G,Support(D));
	ff:=UnderlyingField(G);
	len:=Length(Support(D));
	code:=Subspace(ff^len,Unpack(genmat));
	SetFilterObj(code,IsHermitian_FunctionalCode);
	SetLength(code,len);
	SetGeneratorMatrixOfHermitian_Code(code,genmat);
	SetDesignedMinimumDistance( code, Maximum(0,len-Degree(G)) ); 
	code!.curve:=G!.curve;
	code!.gendivs:=[G,D];
	return code;
end);

InstallMethod( Hermitian_FunctionalCode, "for one Hermitian divisor", true, [IsHermitian_Divisor], 0, 
function(G)
	local D;
	if not (IsRationalHermitian_Divisor(G)) then
		Error("wrong input\n");
	fi;
	D := Filtered( AllRationalAffinePlacesOfHermitian_Curve( G!.curve ), 
		p -> not IsSubset( Support( G ), Support( p ) ) 
	); 
	D := Sum( D );
	return Hermitian_FunctionalCode(G,D);
end);

#############################################################################
##
#F  Hermitian_DifferentialCode(<G>,<D>)
#F  Hermitian_DifferentialCode(<G>)
##
InstallMethod( Hermitian_DifferentialCode, "for two Hermitian divisors", true, [IsHermitian_Divisor,IsHermitian_Divisor], 0, 
function(G,D)
	local genmat,code,ff,len,desmindi;
	if not (IsRationalHermitian_Divisor(G) and IsRationalHermitian_Divisor(D) and Set(D!.orders)=[1]) then
		Error("wrong input\n");
	fi;
	if not Intersection(Support(G),Support(D))=[] then 
		Error("supports of divisors must be disjoint\n");
	fi;
	if One( UnderlyingField( D ) ) * [0,1,0] in Support( D ) then
		Error("support of the 2nd argument must be affine\n");
	fi;
	genmat:=GeneratorMatrixOfAffineFunctionalHermitian_CodeNC(G,Support(D));
	genmat:=NullspaceMat(TransposedMat(genmat));
	ff:=UnderlyingField(G);
	len:=Length(Support(D));
	code:=Subspace(ff^len,List(genmat,Unpack));
	SetFilterObj(code,IsHermitian_DifferentialCode);
	SetLength(code,len);
	SetGeneratorMatrixOfHermitian_Code(code,genmat);
	desmindi:=Maximum(0,Degree(G)-2*Genus(G!.curve)+2);
	SetDesignedMinimumDistance(code,desmindi); 
	code!.curve:=G!.curve;
	code!.gendivs:=[G,D];
	return code;
end);

InstallMethod( Hermitian_DifferentialCode, "for one Hermitian divisor", true, [IsHermitian_Divisor], 0, 
function(G)
	local D;
	if not (IsRationalHermitian_Divisor(G)) then
		Error("wrong input\n");
	fi;
	D := Filtered( AllRationalAffinePlacesOfHermitian_Curve( G!.curve ), 
		p -> not IsSubset( Support( G ), Support( p ) ) 
	); 
	D := Sum( D );
	return Hermitian_DifferentialCode(G,D);
end);

#############################################################################
##  DISPLAYING AND COMPARING ELEMENTS
##  -------------------------------------------------------------------------

InstallMethod( ViewObj, "for a Hermitian agcode",
	[ IsHermitian_Code ], 10, 
function( C )
	Print( "<[", Length(C), ",", Dimension(C), "] Hermitian AG-code over ", LeftActingDomain(C), ">" );
end );

InstallMethod( Display, "for a Hermitian agcode",
	[ IsHermitian_Code ], 10,
function( C )
	Print( "<[", Length(C), ",", Dimension(C), "] Hermitian AG-code over ", LeftActingDomain(C), ">" );
end );

# Methods for vector spaces must be OK.

InstallMethod( PrintObj, "for a Hermitian agcode",
	[ IsHermitian_Code ], 10, 
function( C ) 
	if IsHermitian_FunctionalCode(C) then 
		Print("Hermitian_FunctionalCode(", C!.gendivs[1], ",", C!.gendivs[2], ")"); 
	else
		Print("Hermitian_DifferentialCode(", C!.gendivs[1], ",", C!.gendivs[2], ")"); 
	fi;
end );

#InstallMethod( \=, "for two Hermitian agcodes", IsIdenticalObj, [ IsHermitian_Code, IsHermitian_Code ], function( C1, C2 ) end );
#InstallMethod( \<, "for two Hermitian agcodes", IsIdenticalObj, [ IsHermitian_Code, IsHermitian_Code ], function( C1, C2 ) end );

#############################################################################
##  UTILITIES
##  -------------------------------------------------------------------------

InstallMethod( UnderlyingField,
	"for a Hermitian code",
	[ IsHermitian_Code ],
function( C )
	return UnderlyingField(C!.curve);
end );

#############################################################################
##  DECODING
##  -------------------------------------------------------------------------

InstallMethod( Hermitian_DECODER_DATA, "for a Hermitian AG code", true, [ IsHermitian_Code ], 0,
function(agcode)
	local t,F,pls,mat1,mat2;
	t:=Int((DesignedMinimumDistance(agcode)-1-Genus(agcode!.curve))/2);
	F:=(t+Genus(agcode!.curve))*Hermitian_Place(agcode!.curve,[infinity]);
	pls:=Support(agcode!.gendivs[2]);;
	if IsHermitian_DifferentialCode(agcode) then
		mat1:=GeneratorMatrixOfAffineFunctionalHermitian_CodeNC(agcode!.gendivs[1]-F,pls);
	else
		mat1:=GeneratorMatrixOfAffineFunctionalHermitian_CodeNC(agcode!.gendivs[1]+F,pls);
		mat1:=NullspaceMat(TransposedMat(mat1));
	fi;
	mat2:=GeneratorMatrixOfAffineFunctionalHermitian_CodeNC(F,pls);
	mat2:=NullspaceMat(TransposedMat(mat2));
	return [mat1,mat2];
end);

InstallMethod( Hermitian_DecodeToCodeword, "for a Hermitian AG code and a vector", true, [ IsHermitian_Code, IsFFECollection ], 0,
function(agcode, received)
	local precomp,diag,i,sol,zeropos,mat,rhs;
	if not(Characteristic(agcode)=Characteristic(received)) then
		Error("arguments must have the same characteristic");
	fi;
	if not(Length(agcode)=Length(received)) then
		Error("arguments must have the same length");
	fi;

	precomp:=Hermitian_DECODER_DATA(agcode);
	diag:=CVEC_ZeroMat(Length(agcode),CVecClass(LeftActingDomain(agcode),Length(agcode)));
	for i in [1..Length(agcode)] do diag[i][i]:=received[i]; od;
	sol:=precomp[1]*diag;
	Append(sol,precomp[2]);
	sol:=NullspaceMat(TransposedMat(sol));

	zeropos:=List(sol,x->Filtered([1..Length(agcode)],i->IsZero(x[i])));
	zeropos:=Intersection(zeropos);

	mat:=ExtractSubMatrix(GeneratorMatrixOfHermitian_Code(agcode),[1..Dimension(agcode)],Difference([1..Length(agcode)],zeropos));
	rhs:=received{Difference([1..Length(agcode)],zeropos)};

	sol:=SolutionMatDestructive(mat,rhs);
	if sol=fail then 
		return fail; 
	fi;
	if Is8BitVectorRep(sol) then 
		sol:=CVec(sol);
	else
		sol:=CVec(sol,CVecClass(LeftActingDomain(agcode),Length(sol)));
	fi;
	return sol*GeneratorMatrixOfHermitian_Code(agcode);
end);



