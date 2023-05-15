# Data preparation
Update: May 15th, 2023 (Version 1.0)



## Data access and preprocessing

Virial sequence and metadata were obtained from ViGTK (https://www.biosino.org/ViGTK), which is a mirror site for SARS-CoV-2 genome data of the GISAID (https://gisaid.org) and NCBI (https://www.ncbi.nlm.nih.gov) database. We download 16,395,521 genome sequences from ViGTK as of November 26, 2022. Records with missing time or location were discarded. After removing low quality sequences of length less than 29000 bp or with ambiguous bases more than 400, we obtained 14,959,290 genome sequences altogether (Table S1). Lineage assignment was performed with Pangolin (version 4.1.2) (1) subsequently. To get the spike protein sequences, genome sequences were firstly aligned to SARS-CoV-2 reference genome (Wuhan-Hu-1, NC_045512.2) (2) using the MAFFT7 (version 7.505) (3). Then, coding sequences were extracted from the alignment and translated into protein sequences. We only considered spike protein sequences whose sequence length were between 1265 and 1275 amino acid residues. Additionally, spike proteins with ambiguous amino acids were excluded, which yielded high quality dataset of 10,184,273 sequences in total. A total of 2,713,327 SARS-CoV-2 spike protein sequences that belong to UK was subset from processed dataset.


## Preparation of the dataset for pre-training and fine-tuning

After preprocessing, we bin time intervals into one-month segments, resulting in 35 time-bins. In each month, sequences were arranged by their evolution distance relative to Wuhan-Hu-1 strain (NC_045512.2) of SARS-CoV-2. In order to find nearest neighborhood for the sequence in t time, all sequences in t-1 month were aligned to this sequence. The spike protein sequence in t-1 month with minimum edit distance relative to Wuhan-Hu-1 strain were selected as the nearest neighborhood.


## Data availability
GISAID sequence data is publicly available at https://gisaid.org. The dataset sampled from the UK region according to the Pango lineage designation and assignment, used for the R0 calculation is available at https://zenodo.org/deposit/7388491.


Reference:
1. A. Rambaut, E. C. Holmes, Á. O’Toole, V. Hill, J. T. McCrone, C. Ruis, L. du Plessis, O. G. Pybus, A dynamic nomenclature proposal for SARS-CoV-2 lineages to assist genomic epidemiology. Nature Microbiology. 5, 1403–1407 (2020).

2. F. Wu, S. Zhao, B. Yu, Y.-M. Chen, W. Wang, Z.-G. Song, Y. Hu, Z.-W. Tao, J.-H. Tian, Y.-Y. Pei, M.-L. Yuan, Y.-L. Zhang, F.-H. Dai, Y. Liu, Q.-M. Wang, J.-J. Zheng, L. Xu, E. C. Holmes, Y.-Z. Zhang, A new coronavirus associated with human respiratory disease in China. Nature. 579, 265–269 (2020).

3. K. Katoh, D. M. Standley, MAFFT Multiple Sequence Alignment Software Version 7: Improvements in Performance and Usability. Molecular Biology and Evolution. 30, 772–780 (2013).
