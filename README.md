# PseudoEpic-bedmethyl

The following commands can be used to extract methylation data and reformat it for analysis in [EpigenCentral](https://epigen.ccm.sickkids.ca/), as described in:
`Nanopore long-read sequencing for the critically ill facilitates ultrarapid diagnostics and urgent clinical decision making`, Smits et al., *Under revision*



## Requirements
Please make sure the following programs are available:

  - [modkit](https://github.com/nanoporetech/modkit)
  - [bedtools](https://bedtools.readthedocs.io/en/latest/)
  - base R

Download also the annotation file provided in this repo: `EPIC_hg38_stranded.bed`. 

```bash
# Tabulate methylation data 
modkit pileup /path/to/bam \
 /path/to/output.bed \
 --threads 128 \
 --combine-mods --cpg \
 --ref /path/to/reference/genome.fa \
 --include-bed /path/to/EPIC_hg38_stranded.bed

# Reformat and annotate with CpG IDs from the Illumina Manifest 
bedtools intersect \
  -a /path/to/output.bed \
  -b /path/to/EPIC_hg38_stranded.bed \
  -wb -wa -s | awk -v OFS="\t" '{print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$22}' >  /path/to/sampleID.pseudoepic.bed.cpgID

# Finally use the Rscript to generate input for EpigenCentral
Rscript R_preprocess_modkitoutput.R \ 
  sampleID \
  /path/to/sampleID.pseudoepic.bed.cpgID
  /path/to/EpigenCentral.input.tsv
```

Finally upload the `.tsv` to [EpigenCentral](https://epigen.ccm.sickkids.ca/) and follow on screen commands.
