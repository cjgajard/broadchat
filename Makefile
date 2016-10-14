# all: release

release:
	crystal build --release src/main.cr -o bin/broadchat

dev:
	crystal build src/main.cr -o bin/broadchat

clean:
	rm -rf bin/*
	rm -rf doc
	rm -rf tmp
