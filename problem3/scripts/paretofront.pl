#!/usr/local/bin/perl
#use strict;
#use warnings;
use Tie::File;
use File::Copy;

my($ifname) = 'input.dat';
my(@array) = {};
my(@b) = (0,0);
my(@t) = (0,0);
my($lno) = 0;
my($i) = 0;
my($dummy) = 0;
my($tol) = 0.00000001;
my($NDV) = 20;
tie @array, 'Tie::File', $ifname or die;
open OUT, ">", "skyline.dat" or die;

#if($#ARGV<1){
#	print OUT $dummy, "\n";
#}

while(@array){
	$temp = shift(@array);
	@b = split(" ",$temp);
	$i = 0;
#	print "b: ",@b,"\n";
	while ($i <= $#array) {
		$temp = $array[$i];
		@t = split(" ",$temp);
		if(@t){
	#	print "t: ",@t,"\n";
		if(abs($b[$NDV]-$t[$NDV])<=$tol and abs($b[$NDV+1]-$t[$NDV+1])<=$tol and 
			abs($b[$NDV+2]-$t[$NDV+2])<=$tol){
			splice @array,$i,1; #duplicate rows with same obj values			
		}
		elsif( ( (($b[$NDV]<$t[$NDV]) or (abs($b[$NDV]-$t[$NDV])<=$tol) ) and 
			 (($b[$NDV+1]<$t[$NDV+1]) or (abs($b[$NDV+1]-$t[$NDV+1])<=$tol) ) and 
			 (($b[$NDV+2]<$t[$NDV+2]) or (abs($b[$NDV+2]-$t[$NDV+2])<=$tol) ) ) and 
			 ( ($b[$NDV]<$t[$NDV]) or ($b[$NDV+1]<$t[$NDV+1]) or ($b[$NDV+2]<$t[$NDV+2]))
		) { #RyuTP
			splice @array,$i,1;
#			print "b dominates\n";
		}
		elsif( ( (($t[$NDV]<$b[$NDV]) or (abs($t[$NDV]-$b[$NDV])<=$tol) ) and 
			    (($t[$NDV+1]<$b[$NDV+1]) or (abs($t[$NDV+1]-$b[$NDV+1])<=$tol) ) and 
			    (($t[$NDV+2]<$b[$NDV+2]) or (abs($t[$NDV+2]-$b[$NDV+2])<=$tol) ) ) and 
			    ( ($t[$NDV]<$b[$NDV]) or ($t[$NDV+1]<$b[$NDV+1]) or ($t[$NDV+2]<$b[$NDV+2]))
		) { #RyuTP
			@b = @t;
			splice @array,$i,1;
#			print "t dominates\n";
		}
		else{
			$i++;}
		}
	}

	for $j(0..$#b){	
		print OUT $b[$j], " ";
	}
	print OUT "\n";
	$numND = $numND+1;
	$i = 0;
	while($i <= $#array){
		$temp = $array[$i];
		@t = split(" ",$temp);
		if( abs($b[$NDV]-$t[$NDV])<=$tol and abs($b[$NDV+1]-$t[$NDV+1])<=$tol and 
			abs($b[$NDV+2]-$t[$NDV+2])<=$tol ){
			splice @array,$i,1; #duplicate rows with same obj values			
		}
		elsif( ( (($b[$NDV]<$t[$NDV]) or (abs($b[$NDV]-$t[$NDV])<=$tol) ) and 
			 (($b[$NDV+1]<$t[$NDV+1]) or (abs($b[$NDV+1]-$t[$NDV+1])<=$tol) ) and 
			 (($b[$NDV+2]<$t[$NDV+2]) or (abs($b[$NDV+2]-$t[$NDV+2])<=$tol) ) ) and 
			 ( ($b[$NDV]<$t[$NDV]) or ($b[$NDV+1]<$t[$NDV+1]) or ($b[$NDV+2]<$t[$NDV+2]))
		){ 
			splice @array,$i,1;
		}
		else {
		$i++;}
	}
}
untie @array;
close(OUT);
