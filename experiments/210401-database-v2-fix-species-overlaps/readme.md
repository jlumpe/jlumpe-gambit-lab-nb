# 210401 Database v2 Fix Species Overlaps

This experiment aims to fix all species-species overlaps in v1.2 of the database, taking off where the previous experiment (`210303-database-v2-overlaps`) left off.
That experiment applied some minor edits to v1.2 and then located all remaining species-species overlaps.


## Source files


## Component fixes

### 1

Most overlaps caused by hygroscopicus and griseus, both have two subclusters of 3 genomes with
larger separation between them. Set manual threshold of 0.6 for both, about halfway between subgroup
diameter in min inter. Similar situation for californicus, set threshold to 0.2

### 2

TODO

### 3

TODO

### 4

All overlaps caused by frederiksenii having large diameter. Set manual threshold to slightly lower
than this.

### 5

TODO

### 6

TODO

### 7

All overlaps caused by harveyi having large diameter. Removed 3 outlier genomes decreasing diameter
from .9 to .45.

### 8

Removed 7 outlier genomes from meningitidis and 2 from lactamica (all seemingly part of a third species/cluster).

### 9

TODO

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

TODO

### 16

Coli overlaps jejuni but has no outliers to remove, set lower threshold.

### 17

Removed 3 outliers from euvesicatoria, lowering diameter from .45 to .17.

### 18

Removed 4 outliers from leguminosarum, reducing diameter from .88 to .80.

### 19

Bronchiseptica has two clear subgroups and no real outliers, lowered thershold to remove outgoing overlaps.

### 20

TODO

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

TODO

### 31

Removed two outliers from psittaci.

### 32

Lowered threshold of canettii.

### 33

Lowered threshold of pnomenusa.


### 34

Lowered threshold of pnomenusa crocidurae.


## Additional notebooks


## Output
