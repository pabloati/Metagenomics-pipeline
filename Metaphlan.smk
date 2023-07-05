#!/usr/bin/env python

#Set configurations
import os
from snakemake.exceptions import MissingInputException
PROJECT = "cu_1068"
METAPHL = "module load tools metaphlan/4.0.6; metaphlan"

# set configurations
W_DIR = config.get("work_dir")
SAMPLE_DATA = config.get("sample_data")
PATH_RAW_READS= config.get("path_to_raw_reads")

# read in sample_id_plus_data.txt
IDS = []
raw_reads = {}
fh_in = open(SAMPLE_DATA, 'r')
for line in fh_in:
    line = line.rstrip()
    fields = line.split('\t')
    IDS.append(fields[0])
    raw_reads[fields[0]] = [W_DIR+"/"+PATH_RAW_READS+"/"+fields[1],W_DIR+"/"+PATH_RAW_READS+"/"+fields[2]]

rule all:
    input:
        expand('results/metaphlan/og_all/bowtie/{id}.bowtie2out.txt', id = IDS),
        expand('results/metaphlan/og_all/profiles/{id}_profiled_metagenome.txt', id = IDS),
        expand('results/metaphlan/og_all/biom/{id}.biom', id = IDS),

rule mapping:
    input:
        r1 = lambda wildcards: raw_reads[wildcards.id][0],
        r2 = lambda wildcards: raw_reads[wildcards.id][1]
    output:
        btie = 'results/metaphlan/og_all/bowtie/{id}.bowtie2out.txt',
        prof = 'results/metaphlan/og_all/profiles/{id}_profiled_metagenome.txt',
        biom = 'results/metaphlan/og_all/biom/{id}.biom',
    params:
        walltime="7200",
        nodes="1",
        ppn="5",
        mem="20gb",
        project=PROJECT,
        qsub_log_e="logs/qsub/metaph_{id}.e",
        qsub_log_o="logs/qsub/metaph_{id}.o",
    threads: 5
    log: "logs/metaphlan/{id}.out"
    shell:
        """
        {METAPHL} {input.r1},{input.r2} \
        --nproc {threads} \
        --sample_id {wildcards.id} \
        --input_type fastq \
        -t rel_ab_w_read_stats \
        -o {output.prof} \
        --bowtie2out {output.btie} \
        --biom {output.biom}
        """
