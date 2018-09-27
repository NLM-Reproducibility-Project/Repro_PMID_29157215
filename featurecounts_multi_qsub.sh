#!/bin/bash
#featurecounts_arrayjob.sh
#Accepts a BAM file sorted by name,
#samtools view BAM + GTF --> htseq-count --> counts file
######################

### QSUB INFO ###
#$ -N featurecounts
#$ -S /bin/bash
#$ -m be
#$ -M bryan.chim@nih.gov
#$ -e /nethome/chimb/scripts/std_error_output/featurecounts/
#$ -o /nethome/chimb/scripts/std_error_output/featurecounts/
#$ -pe threaded 4
#$ -l h_vmem=32G


### EXPORT PATH AND CHECK SOFTWARE ###
module load subread/1.6.2

### COMMAND-LINE INPUTS ###
bam_input=$1
gtf_file=$2
counts_output=$3
bam_input_directory=$4

### truncate BAM path and extensions, get base sample name ###
sampname=`basename $bam_input`
sampname=${sampname%%.*}


### EXTRAPOLATED DEFAULT FILE/DIRECTORY NAME VARIABLES ##########
### BASED ON USER-SPECIFIED PROJECT DIRECTORY AND SGE_TASK_ID ###
#counts_output=${counts_output_dir}/${sampname}.counts


### CHECK FOR OUTPUT DIR, IF !-e, CREATE ###
if ! [ -e ${counts_output_dir} ]
then
    echo "Output Directory ${counts_output_dir} doesn't exist --- creating..."
    mkdir ${counts_output_dir}
fi


### INPUT AND OUTPUT CHECKS ###
echo "project: $project_directory"
echo "gtf file used: $gtf_file"
echo "input bam file: $bam_input"
echo "counts will be outputted to $counts_output"
printf "\n"



printf "\n"

### HTSEQ-COUNT COMMAND ### 

cd $bam_input_directory

echo "Running featureCounts ..."

featureCounts -T 4 -t exon -g gene_name -a $gtf_file -o $counts_output $bam_input

echo "DONE!"

