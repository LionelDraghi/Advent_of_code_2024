.SILENT:
all: build check

build: 
	alr build

day_04: build

check: day_04
	bbt --yes --cleanup day_04_tests.md

clean:
	alr clean