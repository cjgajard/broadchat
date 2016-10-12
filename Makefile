# all: release

release:
	crystal build --release src/main.cr -o bin/udipo

dev:
	crystal build src/main.cr -o bin/udipo

test:
	crystal spec

clean:
	rm -rf bin/*
