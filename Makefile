# all: release

release:
	crystal build --release src/main.cr -o bin/broadchat

dev:
	crystal build src/main.cr -o bin/broadchat

test:
	crystal spec

clean:
	rm -rf bin/*
