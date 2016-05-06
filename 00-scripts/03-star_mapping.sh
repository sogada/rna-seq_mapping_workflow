#!/bin/bash
#PBS -A ihv-653-ab
#PBS -N STAR_align__BASE__
#PBS -o STAR_align__BASE__.out
#PBS -e STAR_align__BASE__.err
#PBS -l walltime=24:00:00
#PBS -M jeremy.le-luyer.1@ulaval.ca
#PBS -m ea 
#PBS -l nodes=1:ppn=8
#PBS -r n

#pre-requis
module load compilers/gcc/4.8  apps/mugqic_pipeline/2.1.1
module load mugqic/blat/36
module load mugqic/star/2.4.0k
module laod mugqic/samtools/1.2


#variables
PWD="__PWD__"
base="__BASE__"
DATAFOLDER="02-data"

cd $PWD

	# aligning
echo '	aligning "$base"'

STAR --runThreadN 8 \
  --genomeDir "$DATAFOLDER"/genome_star_dir \
    --readFilesIn "$DATAFOLDER"/"$base".R1.paired.fastq.gz "$DATAFOLDER"/"$base".R2.paired.fastq.gz \
    --readFilesCommand zcat \
    #--sjdbGTFfile /path/to/genome_annot.gff \
    --outFileNamePrefix "$DATAFOLDER"/star_"$base"

	# trimming and sorting
samtools view -Sb -q 1 "$DATAFOLDER"/star_"$base".sam > "$DATAFOLDER"/star_"$base".bam

samtools sort -n "$DATAFOLDER"/star_"$base".bam "$DATAFOLDER"/star_"$base".sorted.bam
  
  # Clean up
    echo '	Removing "$base"'

rm $DATAFOLDER/star_"$(base)".sam
rm $DATAFOLDER/star_"$(base)".bam
