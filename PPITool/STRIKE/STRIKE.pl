##!/usr/bin/perl -w

# Program written by Dr. Nazar Zaki on March 2009.
($infile, $ptr, $ntr, $pts, $nts, $s, $l) = @ARGV;

# Intializing the time computing **********************
# *****************************************************
my $start_time = time;
# ***********************************
$train = $ptr + $ntr;
$test = $pts + $nts;
$allseq = $train + $test;

# Compute the initial kernel matrix
# ***********************************
for $i(0..$allseq-1)
{
	for $j(0..$allseq-1)
	{
		$matrix[$i][$j] = -1;
		if ($i == $j)
		{
			$matrix[$i][$j] = 1;
		}	
	}
}

open(OUT,">Kernelfile");
for $i(0..$allseq-1)
{
	for $j(0..$allseq-1)
	{
		print OUT "$matrix[$i][$j] ";
	}
	print OUT "\n";
}


# ***********************************

$path = '';
$outfile = 'no_repeat.txt';
open(INFO, $path.$infile) || die ("Could not open file <br> $!");
open(OUT,">$path$outfile") || die ("Could not open file \n$!"); 

$line = <INFO>;
while ($line )
{
  $line =~ /(\S+)\s+(\S+)/;
  print OUT "$1\n";
  print OUT "$2\n";
  $line = <INFO>;
}

close(INFO);
close(OUT);

# *************************************************************

$Proteins = 'no_repeat.txt';
$Sequences = 'all_seq.fasta';
$outfile = 'seq.txt';
open(PROT, $path.$Proteins) || die ("Could not open file <br> $!");
open(SEQ, $path.$Sequences) || die ("Could not open file <br> $!");
open(OUT,">$path$outfile") || die ("Could not open file \n$!");

$line = <PROT>;
@sequence = <SEQ>;
$size = @sequence;

while ($line)
{
 	$p = $line;
 	chomp($p);
  $i=0; $flag = 0;
  while($i<$size && !$flag){
     if($sequence[$i] =~ />/){
     	 $sequence[$i] =~ />(\S+)\s/;
       if($1 eq $p){
       	 $flag = 1;
       	 $flag2 = 0;
       	 print OUT $sequence[$i];
         $i++;
       	 while($i<$size && !$flag2){
           if($sequence[$i] =~ />/){
           	 $flag2 = 1;
           }else {
           	print OUT $sequence[$i];
            }
           $i++;
         }
       }
     }
     $i++;
  }
  $line = <PROT>;
}
close(PROT);
close(SEQ);
close(OUT);  

# *****************************************
open(inFile,"<seq.txt");
open(outFile,">data");
while ($seqLine=<inFile>)
{
	if ($seqLine =~/^[^>]/) 
	{
		$seqLine =~ tr/[A-Z]/[a-z/;
		$seqLine =~ s/\s+//gi;
		push @array1, $seqLine;
	}
}
chomp @array1;

for ($i=0; $i< $allseq*2; $i+=2)
{
	print outFile "$array1[$i]$array1[$i+1]\n";
}
close(outFile);
# *****************************************

open(outFile,">trindex");
for ($i=1;$i<=($train);$i++){
	print outFile "$i\n";
}
close (outFile);

open(outFile,">tsindex");
for ($j=($train)+1;$j<=$allseq;$j++){
	print outFile "$j\n";
}
close (outFile);
# *****************************************

open(outFile,">trainlabel");
for ($i=0; $i<($ptr); $i++){
	print outFile "1 ";
}
for ($i=0; $i<($ntr); $i++){
	print outFile "-1 ";
}
close (outFile);

# *****************************************

open(outFile,">testlabel");
for ($i=0; $i<($pts); $i++){
	print outFile "1 ";
}
for ($i=0; $i<($nts); $i++){
	print outFile "-1 ";
}

# *****************************************

system "./SK.exe data trindex tsindex -s $s -l $l -p $ptr -n $ntr -t $train -e $test -C 1000.0";
system "rm  no_repeat.txt data testlabel trainlabel trindex tsindex Kernelfile seq.txt"; 

# Computing the running time
#*****************************************************

my $difference;
my $end_time;
sub nazarcputime
{
	$end_time = time;
	$difference = $end_time - $start_time;
}

$t =  &nazarcputime($difference)/60;
$t = sprintf("%.4f", $t);
print "\n********************************\n";
print "CPU Running Time: $t Minutes\n";
print "********************************\n\n";
