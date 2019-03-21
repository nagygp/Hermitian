#############################################################################
##
#W  riemannroch.gd                HERmitian Package                Gabor P. Nagy
##
##  Declaration file for Hermitian Riemann-Roch spaches
##
#Y  Copyright (C) 2019 Gabor P. Nagy (http://www.math.u-szeged.hu/~nagyg), 14/03/2019
##

#############################################################################
##
#F  Hermitian_RiemannRochSpace(<D>)
##
##  <#GAPDoc Label="Hermitian_RiemannRochSpaceBasis">
##  <ManSection>
##  <Func Name="Hermitian_RiemannRochSpaceBasis" Arg='D'/>
##
##  <Description>
##  returns a <B>basis</B> of the Riemann-Roch space of the Hermitian divisor 
##  <A>D</A>, which is defined by <M>\{ f \in K[Y] \mid Div(f) \geq - D \}</M>. 
##  
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "Hermitian_RiemannRochSpaceBasis" );

