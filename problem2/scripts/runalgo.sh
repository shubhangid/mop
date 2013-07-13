#!/bin/bash
matlab -nojvm -nodesktop -r "dtriangulation;exit;"
stty echo
perl /home/shubhangi/nomad.3.5.1/examples/interfaces/FORTRAN/MOP/problem2/scripts/remsim.pl
perl /home/shubhangi/nomad.3.5.1/examples/interfaces/FORTRAN/MOP/problem2/scripts/rmdups.pl wtA.dat

perl /home/shubhangi/nomad.3.5.1/examples/interfaces/FORTRAN/MOP/problem2/scripts/updtNML.pl
/home/shubhangi/nomad.3.5.1/examples/interfaces/FORTRAN/MOP/problem2/VTDIRECT/tmain

perl /home/shubhangi/nomad.3.5.1/examples/interfaces/FORTRAN/MOP/problem2/scripts/gentr.pl
perl /home/shubhangi/nomad.3.5.1/examples/interfaces/FORTRAN/MOP/problem2/scripts/copylncnt.pl tregion.dat
/home/shubhangi/nomad.3.5.1/examples/interfaces/FORTRAN/MOP/problem2/VTDIRECT/GenSur
/home/shubhangi/nomad.3.5.1/examples/interfaces/FORTRAN/MOP/problem2/NOMAD/test.exe
perl /home/shubhangi/nomad.3.5.1/examples/interfaces/FORTRAN/MOP/problem2/scripts/rmdups.pl RSMOutTest.dat
perl /home/shubhangi/nomad.3.5.1/examples/interfaces/FORTRAN/MOP/problem2/scripts/copylncnt.pl RSMOutTest.dat
perl /home/shubhangi/nomad.3.5.1/examples/interfaces/FORTRAN/MOP/problem2/scripts/copylncnt.pl RSMOutTest1.dat
#/home/shubhangi/nomad.3.5.1/examples/interfaces/FORTRAN/MOP/problem2/VTDIRECT/EvalSur
perl /home/shubhangi/nomad.3.5.1/examples/interfaces/FORTRAN/MOP/problem2/scripts/evalsur.pl

/home/shubhangi/nomad.3.5.1/examples/interfaces/FORTRAN/MOP/problem2/VTDIRECT/tskyline
cp blank.dat lshepwa.dat
cp blank.dat RSMOutTest1.dat
cp blank.dat RSMOutTest.dat

cp RSMInTest.dat input.dat
perl /home/shubhangi/nomad.3.5.1/examples/interfaces/FORTRAN/MOP/problem2/scripts/paretofront.pl

