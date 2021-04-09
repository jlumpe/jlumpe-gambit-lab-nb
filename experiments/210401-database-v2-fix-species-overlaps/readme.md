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

TODO

### 22

TODO

### 23

TODO

### 24

TODO

### 25

TODO

### 26

TODO

### 27

TODO

### 28

TODO

### 29

TODO

### 30

TODO

### 31

TODO

### 32

TODO

### 33

TODO

### 34

TODO


## Additional notebooks


## Output
