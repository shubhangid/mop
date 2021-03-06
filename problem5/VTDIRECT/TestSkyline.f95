PROGRAM TestSkyline
USE REAL_PRECISION
USE TestObj_MOD  ! The module for obj function

IMPLICIT NONE

INTEGER :: ierr ! Error status for file I/O.
INTEGER :: M, N, indx, indx1
REAL(KIND = R8), DIMENSION(:,:), ALLOCATABLE :: X
REAL(KIND = R8), DIMENSION(12) :: c
REAL(KIND = R8) :: f

	M = 12
	OPEN(75, FILE="RSMOutTest.dat", STATUS='OLD')
	READ(75,*) N
  ALLOCATE(X(M,N))
	DO indx=1, N, 1
		READ(75,*) X(:,indx)
	END DO
	CLOSE(75)
	DO indx=1, N, 1
		DO indx1=1, M
			c(indx1) = X(indx1,indx)
		END DO
		CALL TestObj(c,f)
	END DO
  DEALLOCATE(X)
END PROGRAM TestSkyline
