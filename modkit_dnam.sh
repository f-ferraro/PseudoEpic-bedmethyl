modkit pileup sampleID.bam \
 sampleID.pseudoepic.bed \
 --threads 128 \
 --combine-mods --cpg \
 --ref ${ref_genome} \
 --include-bed EPIC_hg38_stranded.bed

bedtools intersect -a  sampleID.pseudoepic.bed -b EPIC_hg38_stranded.bed -wb -wa -s | awk -v OFS="\t" '{print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$22}' >  sampleID.pseudoepic.bed.cpgID

# Edit sampleID in R_prepreocess_modkitoutput.R
Rscript R_preprocess_modkitoutput.R