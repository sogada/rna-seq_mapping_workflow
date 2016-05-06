#!/bin/bash
#PBS -A ihv-653-ab
#PBS -N trimmomatic__BASE__
#PBS -o trimmomatic__BASE__.out
#PBS -e trimmomatic__BASE__.err
#PBS -l walltime=02:00:00
#PBS -M jeremy.le-luyer.1@ulaval.ca
#PBS -m ea 
#PBS -l nodes=1:ppn=8
#PBS -r n


#pre-requis

module load compilers/gcc/4.8
module load apps/mugqic_pipeline/2.1.1
module load mugqic/java/jdk1.7.0_60
module load mugqic/trimmomatic/0.35

PWD="__PWD__"

cd $PWD

base=__BASE__

java -XX:ParallelGCThreads=1 -Xmx22G -cp $TRIMMOMATIC_JAR org.usadellab.trimmomatic.TrimmomaticPE \
        -phred33 \
        02-data/"$base".R1.f(ast)?q.gz \
        02-data/"$base".R2.f(astq)?.gz \
        02-data/"$base".R1.paired.fastq.gz \
        02-data/"$base".R1.single.fastq.gz \
        02-data/"$base".R2.paired.fastq.gz \
        02-data/"$base".R2.single.fastq.gz \
        ILLUMINACLIP:/rap/ihv-653-ab/00_ressources/02_databases/univec/univec.fasta:2:20:7 \
        LEADING:20 \
        TRAILING:20 \
        SLIDINGWINDOW:30:30 \
        MINLEN:60