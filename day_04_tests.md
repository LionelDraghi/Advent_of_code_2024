This test file was build to check if [bbt](https://github.com/LionelDraghi/bbt) could be useful to help implement an [Advent of Code challenge](https://adventofcode.com/2024/day/4), part 1 only.  
The answer is yes.  
Creating small test cases of progressive difficulty was done in twenty seconds each, and adding the tests from the two provided examples was done in less than a minute, with a direct cut & paste of the expected results from the AoC web page.  
Couldn't be easiest and less error prone.  

The tested exe is called day_04 and should be in the current directory.  
It should be run with  
> bbt day_04_tests.md  
It was run with version 0.0.6 of bbt.  

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

## Scenario 3
- Given the file `input_3`
```
..XMASAMXMA...
```

- When I run `day_04 XMAS input_3`
- Then output contains `Pattern Count = 2`

## Scenario 4
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
.A..A.
XMAS.S
.X....
```

- When I run `day_04 XMAS input_ex1`
- Then output contains `Pattern Count = 4`

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
