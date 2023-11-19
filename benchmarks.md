#### RBTree vs BTree

Benchmarking the performance with 10k entries

**Instructions**

|        |    insert() |      get() |    delete() |
| :----- | ----------: | ---------: | ----------: |
| RBTree | 110_209_785 | 17_640_966 | 100_564_274 |
| BTree  |  78_767_432 | 60_689_987 | 153_273_397 |

**Heap**

|        |   insert() |   get() |    delete() |
| :----- | ---------: | ------: | ----------: |
| RBTree | 11_803_356 |   9_008 | -18_214_872 |
| BTree  |  1_330_028 | 639_072 |   1_939_952 |
