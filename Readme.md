# Metagenomics analysis of gut microbiome shotgun sequencing

The main pipeline consists of an initial preprocessing of the raw fastq files using [Fastp v0.26](https://github.com/OpenGene/fastp) to trim and correct the quality of the reads and [Bowtie2 v2.4](https://github.com/BenLangmead/bowtie2) to eliminate the contamination by human DNA. Then, the processed reads are used for an assembly-free community composition analysis with [Metaphlan 4.0](https://github.com/biobakery/MetaPhlAn) 

## 1. Preprocessing
  
  The reads were were preprocessed using a [snakemake workflow](https://github.com/pabloati/Metagenomics-pipeline/blob/main/Preprocessing.smk) which also produced the [MultiQC](https://github.com/ewels/MultiQC) report from all the reads analyzed and cleaned by Fastp. 

## 2. MetaPhlAn pipeline

  Metaphlan is run with an option to output the absolute counts. Custom scripts were used to correctly assign the patients IDs to each of the samples, and to produce a table that contained the absolute counts. Metaphlan's basic output of relative counts was merged using the already exiting metaphlan's scripts. Another [script](secondary_scripts/merge_metaphlan_absolute.py) by timmyerg was used to extract and merge into one table the absolute counts for the OTUs. All the outputs from Metaphlan were analysed using R.

  ## 3. Analyses scripts

    The analyses of the results produced by MetaPhlAn were done in R. In the [R Markdown notebook](Rscripts/MIA_Thesis_final.Rmd) all the different analysis are summarized. As well, there is an RData file where the different supplementary functions that were used for the study. The Markdown file produces multiple alha and beta-diversity plots, as well as a differential abundance analysis, followed by a training and test of different Random Forest models. 
