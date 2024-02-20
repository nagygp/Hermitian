#############################################################################
##
#W  agcodes.gd                   HERmitian Package                  Gabor P. Nagy
##
##  Declaration file for Hermitian agcodes
##
#Y  Copyright (C) 2019 Gabor P. Nagy (http://www.math.u-szeged.hu/~nagyg), 14/03/2019
##

#############################################################################
##
#C  IsHermitian_Code(<obj>)
##  
##  <#GAPDoc Label="IsHermitian_Code">
##  <ManSection>
##  <Filt Name="IsHermitian_Code" Arg='obj' Type='Category'/>
##  <Filt Name="IsHermitian_FunctionalCode" Arg='obj' Type='Category'/>
##  <Filt Name="IsHermitian_DifferentialCode" Arg='obj' Type='Category'/>
##  
##  <Description>
##  A Hermitian code is an algebraic-geometric (AG) code defined on the Hermitian curve of
##  equation <M>X^{q+1}=Y^q+Y</M>. 
##  AG-codes are either of functional or of differential type.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareFilter( "IsHermitian_FunctionalCode" );
DeclareFilter( "IsHermitian_DifferentialCode" );
DeclareCategory( "IsHermitian_Code", IsVectorSpace );

#############################################################################
##
#C  GeneratorMatrixOfAffineFunctionalHermitian_CodeNC(G,pls)
##  
##  <#GAPDoc Label="GeneratorMatrixOfAffineFunctionalHermitian_CodeNC">
##  <ManSection>
##  <Func Name="GeneratorMatrixOfAffineFunctionalHermitian_CodeNC" Arg='G,pls'/>
##  
##  <Returns>
##  The generator matrix of the functional AG code <M>C_L(D,G)</M>, where
##  <M>D</M> is the sum of the degree one places in the list <A>pls</A>. The support of 
##  <A>G</A> must be disjoint from <A>pls</A>.
##  </Returns>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "GeneratorMatrixOfAffineFunctionalHermitian_CodeNC" );

#############################################################################
##
#F  Hermitian_FunctionalCode(<G>,<D>)
#F  Hermitian_FunctionalCode(<G>)
##
##  <#GAPDoc Label="Hermitian_FunctionalCode">
##  <ManSection>
##  <Oper Name="Hermitian_FunctionalCode" Arg='G,D'/>
##  <Oper Name="Hermitian_FunctionalCode" Arg='G'/>
##
##  <Returns>
##  The functional AG code 
##  <M>C_L(D,G)=\{(f(P_1),\ldots,f(P_n)) \mid f\in L(G)\}.</M> 
##  <M>D</M> and <M>G</M> are rational divisors of the
##  Hermitian curve <M>H(q)</M>. <M>D=P_1+\cdots+P_n</M>, where <M>P_1,\ldots,P_n</M> are degree one places
##  of <M>H(q)</M>. The supports of <M>D</M> and <M>G</M> are disjoint. If <M>D</M> is not given then it is the 
##  sum of affine rational places of <M>H(q)</M>, not contained in the support of <M>G</M>. 
##  By the Riemann-Roch theorem, functional codes have dimension at least <M>\deg(G)+1-g</M>, 
##  with equality if <M>\deg(G)>2g-2</M>. 
##  </Returns>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "Hermitian_FunctionalCode", [IsHermitian_Divisor,IsHermitian_Divisor] );
DeclareOperation( "Hermitian_FunctionalCode", [IsHermitian_Divisor] );

#############################################################################
##
#F  Hermitian_DifferentialCode(<G>,<D>)
#F  Hermitian_DifferentialCode(<G>)
##
##  <#GAPDoc Label="Hermitian_DifferentialCode">
##  <ManSection>
##  <Oper Name="Hermitian_DifferentialCode" Arg='G,D'/>
##  <Oper Name="Hermitian_DifferentialCode" Arg='G'/>
##
##  <Returns>
##  The differential AG code 
##  <M>C_\Omega(D,G) = \{res_{P_1}(\omega),\ldots,res_{P_n}(\omega) \mid \omega \in \Omega(G-D)\}.</M>
##  <M>D</M> and <M>G</M> are rational divisors of the
##  Hermitian curve <M>H(q)</M>. <M>D=P_1+\cdots+P_n</M>, where <M>P_1,\ldots,P_n</M> are degree one places
##  of <M>H(q)</M>. The supports of <M>D</M> and <M>G</M> are disjoint. If <M>D</M> is not given then it is the 
##  sum of affine rational places of <M>H(q)</M>, not contained in the support of <M>G</M>. 
##  By the Riemann-Roch theorem, functional codes have dimension <M>\deg(G)+1-g</M>. 
##  The differential code is the dual of the corresponding functional code. 
##  By the Riemann-Roch theorem, differential codes have dimension at least <M>n-\deg(G)-1+g</M>, 
##  with equality if <M>\deg(G)>2g-2</M>. 
##  </Returns>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "Hermitian_DifferentialCode", [IsHermitian_Divisor,IsHermitian_Divisor] );
DeclareOperation( "Hermitian_DifferentialCode", [IsHermitian_Divisor] );



#############################################################################
##
#F  UnderlyingCurveOfHermitian_Code(C)
##
##  <#GAPDoc Label="UnderlyingCurveOfHermitian_Code">
##  <ManSection>
##  <Func Name="UnderlyingCurveOfHermitian_Code" Arg='C'/>
##
##  <Returns>
##  The underlying Hermitian curve of the AG code <A>C</A>.
##  </Returns>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "UnderlyingCurveOfHermitian_Code" );

#############################################################################
##  
#A  UnderlyingField(<C>)
##  
##  <#GAPDoc Label="UnderlyingField_Code">
##  <ManSection>
##  <Attr Name="UnderlyingField" Arg='C'/>
##  
##  <Description>
##  The underlying field of an AG code is its left acting domain. 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "UnderlyingField", IsHermitian_Code );

#############################################################################
##
#A  Length(<C>)
##  
##  <#GAPDoc Label="Length_Code">
##  <ManSection>
##  <Attr Name="Length" Arg='C'/>
##  
##  <Returns>
##  The length of the AG code <A>C</A>.
##  </Returns>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Length", IsHermitian_Code );

#############################################################################
##
#A  GeneratorMatrixOfHermitian_Code(<C>)
##  
##  <#GAPDoc Label="GeneratorMatrixOfHermitian_Code">
##  <ManSection>
##  <Attr Name="GeneratorMatrixOfHermitian_Code" Arg='C'/>
##  
##  <Returns>
##  The generator matrix of the AG code <A>C</A> in <Package>CVEC</Package> matrix format.
##  </Returns>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "GeneratorMatrixOfHermitian_Code", IsHermitian_Code );

#############################################################################
##  
#A  DesignedMinimumDistance(<C>)
##  
##  <#GAPDoc Label="DesignedMinimumDistance">
##  <ManSection>
##  <Attr Name="DesignedMinimumDistance" Arg='C'/>
##  
##  <Returns>
##  The designed minimum distance <M>\delta</M> of the Hermitian AG code <A>C</A>. 
##  When <M>\deg(G)\geq 2g-2</M>, then the general formulas for <M>\delta</M> are as follows. 
##  For the functional code <M>C_L(D,G)</M>, <M>\delta=n-\deg(G)</M>, and for the differential
##  code <M>C_\Omega(D,G)</M>, <M>\delta=\deg(G)-(2g-2)</M>. 
##  </Returns>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "DesignedMinimumDistance", IsHermitian_Code );

################
### DECODING ###
################
#############################################################################
##  
#A  Hermitian_DecodeToCodeword(<C>,<w>)
##  
##  <#GAPDoc Label="Hermitian_DecodeToCodeword">
##  <ManSection>
##  <Oper Name="Hermitian_DecodeToCodeword" Arg='C,w'/>
##  
##  <Description>
##  Let <M>\delta</M> be the designed minimum distance of <A>C</A>, and define <M>t=[(\delta-1-g)/2]</M>.
##  If there is a codeword <M>c\in C</M> with <M>d(c,w)\leq t</M> then <M>c</M> is returned.
##  Otherwise, the output is <C>fail</C>.
##  <P/>The decoding algorithm is from [Hoholdt-Pellikaan 1995]. The function <C>Hermitian_DECODER_DATA</C> 
##  precomputes two matrices which are stored as attributes of the AG code. The decoding consists
##  of solving linear equations. 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Hermitian_DECODER_DATA", IsHermitian_Code );
DeclareOperation( "Hermitian_DecodeToCodeword", [IsHermitian_Code,IsFFECollection] );

