This Markdown spec comply with https://github.com/LionelDraghi/bbt 0.0.6  
It should be run with  
> bbt day_04_tests.md

## Scenario 1
- Given the file `input_1`
```
..X...
```

- When I run `day_04 XMAS input_1`
- Then output contains `Pattern Count = 0`

## Scenario 2
- Given the file `input_2`
```
..XMAS...
```

- When I run `day_04 XMAS input_2`
- Then output contains `Pattern Count = 1`

## Scenario 2
- Given the file `input_3`
```
..XMASAMXMA...
```

- When I run `day_04 XMAS input_3`
- Then output contains `Pattern Count = 2`

## Scenario 2
- Given the file `input_4`
```
X2345678X
1M345678M
12A45X78A
123S56M8S
```

- When I run `day_04 XMAS input_4`
- Then output contains `Pattern Count = 2`

## Scenario example 1
First example on the web page : https://adventofcode.com/2024/day/4
- Given the file `input_ex1`
```
..X...
.SAMX.
.A....
XMAS..
.X....
```

## Scenario example 2
- Given the file `input_ex2`
```
....XXMAS.
.SAMXMS...
...S..A...
..A.A.MS.X
XMASAMX.MM
X.....XA.A
S.S.S.S.SS
.A.A.A.A.A
..M.M.M.MM
.X.X.XMASX
```

- When I run `day_04 XMAS input_ex2`
- Then output contains `Pattern Count = 18`
