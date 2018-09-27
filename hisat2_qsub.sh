### QSUB INFO ###
#$ -N hisat2
#$ -S /bin/bash
#$ -m be
#$ -M bryan.chim@nih.gov
#$ -e /nethome/chimb/scripts/std_error_output/hisat2/
#$ -o /nethome/chimb/scripts/std_error_output/hisat2/
#$ -pe threaded 4
#$ -l h_vmem=32G

export PATH=/hpcdata/li/li_data/bryan/bin/hisat2-2.1.0/:$PATH
module load SAMtools/1.7-goolf-1.7.20

wd=$1
srr=$2
genome=$3


cd $wd

hisat2 -p 4 -x $genome --sra $srr | samtools view -bS - > $srr.bam

