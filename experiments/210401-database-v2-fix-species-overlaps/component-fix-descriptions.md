## Component fixes

### 1

Most overlaps caused by hygroscopicus and griseus, both have two subclusters of 3 genomes with
larger separation between them. Set manual threshold of 0.6 for both, about halfway between subgroup
diameter in min inter. Similar situation for californicus, set threshold to 0.2.

### 2

Reduced thresholds: fluorescens .98 -> .8, parafulva .94 -> .6, alcaligenes .96 -> .8.
Split syringae 51/33/19/7 (4 removed), amygdali 8/8/11 (2 removed), savastanoi 9/15, putida 18/4/6.
Needed to further reduce threshold on syringae subgroup 4 and amygdali subgroup 2.
Removed species "denitrificans (nom. rej.)" (9 genomes), could not separate from aeruginosa and
according to NCBI this probably isn't a real species anyway.

### 3

Removed 2/16 outliers from multivorans (diameter .91 -> .62), 2/20 from cenocepacia (.81 -> .74).
Fixing cepacia overlap with lata was difficult, needed to remove 14/64 genomes (diameter .69 -> .50)
and further reduce threshold to .35.

### 4

All overlaps caused by frederiksenii having large diameter. Set manual threshold to slightly lower
than this.

### 5

7/12 mycoides seemed like they should be classified within cereus subgroup 3, removed (diameter .95
->  .36). Anthracis is a tight cluster within the smaller of the two main cereus subgroup 1
subtrees, removed all cereus in 2nd tree (22/80, diameter .74 -> .70) and further lowered threshold
to .6. Removed 3/19 thuringiensis from otherwise pure cereus 2 tree (diameter .68 -> .67), further
lowered threshold to .5. Removed 13/71 cereus 2 from mixed cereus/thuringiensis tree (diameter .69
-> .63), further lowered threshold to .55.

### 6

Split suis 25/10 with 5 genomes removed, two comparatively very tight with large separation.
Removed one outlier from pinnipedialis (diameter .054 -> .030). Lowered threshold on ceti from
diameter of .06 to .02.

### 7

All overlaps caused by harveyi having large diameter. Removed 3 outlier genomes decreasing diameter
from .9 to .45.

### 8

Removed 7 outlier genomes from meningitidis and 2 from lactamica (all seemingly part of a third species/cluster).

### 9

Removed 6/563 outliers from S. sonnei, diameter .37 -> .29.
Split S. boydii 8/5, S. dysenteriae 3/3, E. coli 1487/2204/508 (5 removed).
Lowered thresholds on E. coli subgroups: subgroup 1 .66 -> .4, subgroup 2 .55 -> .35, subgroup 3 .50 -> .35.

### 10

Removed 2 outlier genomes from japonicum.

### 11

Set slightly lower threshold on tasmaniensis and splendidus.

### 12

Oceanensis pretty nested inside pacifica, split pacifica into 3 subtaxa.

### 13

Removed single outlier from caratovorum (looks like misclassified brasiliense).

### 14

Removed 3 outliers from thailandensis, reducing diameter from .83 to .38. Pseudomallei still
overlaps mallei, with no obvious outliers. Set threshold slightly lower.

### 15

Remove 6/6825 outliers from pneumoniae, diameter .77 -> .59.
Split pseudopneumoniae 6/5.
Reduce thresholds on mits .76 -> .5, pseudopneumoniae subgroup 2 .67 -> .5.

### 16

Coli overlaps jejuni but has no outliers to remove, set lower threshold.

### 17

Removed 3 outliers from euvesicatoria, lowering diameter from .45 to .17.

### 18

Removed 4 outliers from leguminosarum, reducing diameter from .88 to .80.

### 19

Bronchiseptica has two clear subgroups and no real outliers, lowered thershold to remove outgoing overlaps.

### 20

Clustering of all genomes in component gives about five clusters: two almost entirely cloacae, two
almost entirely hormaechei, and one split about 50/50. Located another two tight, nearly pure
cloacae subclusters within the mixed one. Used these to split cloacae 23/18/13/9 (35 removed) and
hormaechei 115/44 (43 removed). Needed to reduce hormaechei subgroup 2 threshold .43 -> .25

### 21

Removed 2 outliers from pestis, lowering diameter from .19 to .14. Lowered threshold of
pseudotuberculosis slightly.

### 22

Remove single outlier from alginolyticus (looks like it should be diabolicus).

### 23

Lower threshold on nucleatum somewhat.

### 24

Split amyloliquefaciens 10/10. One subgroup was clear outlier to other subgroup + velezensis.
Velezensis still overlaps with this other subgroup but had no obvious outliers, just lowered
threshold a bit.

### 25

Removed two outliers from salivarius, reducing diameter from .89 to .73.

### 26

Remove single outlier from licheniformis, reducing diameter from .65 to .18.

### 27

Safensis nested inside pumilus. Split pumilus into two subgroups, removed two outliers.

### 28

Fusiformis seems like it is composed of two pretty unrelated subgroups of 2 and 3 genomes. Since
neither is an obvious outlier just lowered threshold.

### 29

Removed 5 sporogenes and 4 botulinum subgroup 1 genomes that were seemingly misclassified and should
have been part of the other group. This is a large fraction of sporogenes to remove but doesn't seem avoidable.

### 30

Lactobacillus casei and Lacticaseibacillus paracasei don't look like they are any different. Should
merge into a single species.

### 31

Removed two outliers from psittaci.

### 32

Lowered threshold of canettii.

### 33

Lowered threshold of pnomenusa.

### 34

Lowered threshold of crocidurae.


### Additional notes

- Species with substantial mutual intermixing
  - Pseudomonas amygdali/savastanoi/syringae (component 2)
  - Enterobacter cloacae/hormaechei (component 20)
  - Lactobacillus casei/Lacticaseibacillus paracasei (component 30), ended up merging
- Species deeply nested inside other species
  - Pseudomonas monteilii within putida (component 2)
  - "denitrificans (nom. rej.)" within aeruginosa (component 2). Deleted, probably not real species.
  - Burkholderia lata within cepacia? (component 3)
  - Bacillus anthracis within cereus subgroup 1 (component 5)
- Species with many misclassified genomes
  - Many Bacillus mycoides seem to be cereus subgroup 3 (component 5)
