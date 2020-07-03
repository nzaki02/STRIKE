STRIKE: a protein-protein interaction classification tool
By Nazar Zaki (nzaki@uaeu.ac.ae)
Bioinformatics Laboratory, UAE University.


STRIKE runs under windows paltform. A Linux based version will soon be available.

Download and extract the file PPI_Tool. Change to STRIKE directory.

Usage:
perl STRIKE.pl [input file] [ptr] [ntr] [pts] [nts] [n] [lamda]

input file: the file contains the protein interaction pairs (in the same directory)
ptr: the number of positive training examples
ntr: the number of negative training examples
pts: the number of positive testing examples
nts: the number of negative testing examples
n: the lenght of the subsequence
lambda: the weighted decay factor  

e.g: perl STRIKE.pl sample.txt 2 2 2 2 5 0.1