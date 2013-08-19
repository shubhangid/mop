program BuildLHSD
	use REAL_PRECISION
	use LHSDesign_MOD

	INTEGER:: P, LNSTART, I
	REAL (KIND = R8), DIMENSION(12):: LB, UB, XI
	REAL (KIND = R8), DIMENSION(12,100):: LHSDESIGN
	
	P=12
	LNSTART=100
	LB(1:2)=0.8
	LB(3:12)=0.3
	UB(1:2)=1.0
	UB(3:12)=0.7
	XI(1:2)=1.0
	XI(3:12)=0.5
	call LATINDESIGN(P,LNSTART,LB,UB,XI,LHSDESIGN)
	open(800, FILE="RSMOutTest.dat", STATUS='OLD', POSITION='APPEND')
	do I=1,LNSTART
		write(800,*) LHSDESIGN(:,I)
	end do
	close(800)
end program BuildLHSD
