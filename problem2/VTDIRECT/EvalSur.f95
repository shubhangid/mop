program EvalSur
use REAL_PRECISION

implicit none

INTEGER :: ierr ! Error status for file I/O.
INTEGER :: M, N1, N2, i, j, k, cnt
REAL(KIND = R8), DIMENSION(12) :: xs,xt,xt0,xs0
REAL(KIND = R8), DIMENSION(15) :: xf
REAL(KIND = R8),DIMENSION(3) :: ft, fs, fst, ftx0, fsx0, sumrhos
REAL(KIND = R8):: tol, sumerrf1,sumerrf2,sumerrf3,rms1,rms2,rms3
REAL(KIND = R8)::SumXi,pi,g,SumRho

	M = 12
	tol=1e-13
	cnt=0
	sumerrf1=0.0
	sumerrf2=0.0
	sumerrf3=0.0
	SumXi=0.0
	SumRho=0.0
	sumrhos(1:3)=0.0
	pi = 3.14159265359
	N1=0
	N2=0
	
	open(175, FILE="RSMOutTest.dat", STATUS='OLD')
	read(175,*)N1
	write(*,*)'N1 ',N1
	do k=1,N1,1
		read(175,*,IOSTAT=ierr)xt

		if(k==1) then
			xt0(1:12)=xt(1:12)
		end if
		
		write(*,*)xt0
		if(ierr > 0) then
			write(*,*) 'Read failed'
			exit
		else if (ierr < 0) then
			exit
		else
			open(176, FILE="RSMOutTest1.dat", STATUS='OLD')			
			read(176,*)N2
			do i=1,N2,1
				read(176,*)xf
				xs(1:12)=xf(1:12)
				fst(1:3)=xf(13:15)
				do j=1,M
					if(abs(xt(j)-xs(j))<=tol) then
						cnt=cnt+1
					end if
				end do
				if(cnt==M)then
					if(k==1) then
						fsx0(1:M)=fst(1:M)
					else
						fs(1:M)=fst(1:M)
					end if
					close(176)
					exit
				end if
			end do
			close(176)
		end if	
		do i=3,M,1
			SumXi = SumXi + (xt(i)-0.5)**2 - Cos(20*pi*(xt(i)-0.5))
		end do
		!write(*,*) 'Sum ',SumXi
		g   = 100 * (10.0 + SumXi)
		!write(*,*) 'g ',g
		ft(1) = 0.5*xt(1)*xt(2)*(1+g)
	  	ft(2)  = 0.5*xt(1)*(1-xt(2))*(1+g)
	  	ft(3)  = 0.5*(1-xt(1))*(1+g)
!			WRITE(*,*) 'Evaluate ', X, f1, f2, f3
		if(k==1) then
			ftx0(1:3)=ft(1:3)
		end if
		write(*,*)'k=',k,'ftx0 ',ftx0
		do i=1,M
			sumrhos(i)=sumRhos(i)+((ftx0(i)-ft(i))/(fsx0(i)-fs(i)))
		end do
		sumerrf1=sumerrf1+((fs(1)-ft(1))**2)
		sumerrf2=sumerrf2+((fs(2)-ft(2))**2)
		sumerrf3=sumerrf3+((fs(3)-ft(3))**2)

	write(*,*)'N1 ',N1
	cnt=0
	end do			
	close(175)
	open(175, FILE="RSMOutTest.dat", STATUS='OLD')
	read(175,*)N1
	close(175)
			write(*,*)'sums ',sumerrf1,sumerrf2,sumerrf3
			write(*,*)'sumrhos ',sumrhos(1),sumrhos(2),sumrhos(3)
			write(*,*)'N1 ',N1
			write(*,*)sumerrf1/N1
			rms1=sqrt(sumerrf1/N1)
			rms2=sqrt(sumerrf2/N1)
			rms3=sqrt(sumerrf3/N1)
		write(*,*)'rms:',rms1,rms2,rms3

END PROGRAM EvalSur
