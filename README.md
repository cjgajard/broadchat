# broadchat

Chat through UDP local broadcast.

## Installation

```text
$ git clone git@github.com:cjgajard/broadchat.git
$ cd broadchat
$ make
```

## Usage

```text
Usage: broadchat [OPTION]...

Option:
    -b ADDRESS, --bcast ADDRESS      sets broadcast address (default: 192.168.1.255)
    -p NUMBER, --port NUMBER         sets broadcast port (default: 6667)
    -v, --version                    shows version
    -h, --help                       shows this message

Broadcast address can also be assigned with the environment variable BCAST_ADDR
e.g.:
    export BCAST_ADDR='10.10.1.255'
```

## Contributing

1. Fork it ( https://github.com/cjgajard/broadchat/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [cjgajard](https://github.com/cjgajard) Carlos Gajardo - creator, maintainer
