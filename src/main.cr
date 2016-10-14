require "option_parser"
require "./broadchat"

# `Broadchat::CLI` reads command-line arguments and executes the program.
module Broadchat::CLI
  private USAGE = <<-HELP
    Usage: broadchat [OPTION]...

    Option:
    HELP

  # Default broadcast address.
  DEFAULT_BCAST_ADDR = "192.168.1.255"
  # Default broadcast port.
  DEFAULT_BCAST_PORT = 6667

  # Parses command-line arguments. If no --bcast argument is given, it will
  # look for "BCAST_ADDR" in the environment variables
  def self.parse(args)
    bcast_addr = ENV["BCAST_ADDR"]? || DEFAULT_BCAST_ADDR
    bcast_port = DEFAULT_BCAST_PORT

    OptionParser.parse(args) do |parser|
      parser.banner = USAGE

      parser.on(
        "-b ADDRESS", "--bcast ADDRESS",
        "sets broadcast address (default: #{DEFAULT_BCAST_ADDR})") do |addr|
        # TODO: Check if is a valid address.
        bcast_addr = addr
      end

      parser.on(
        "-p NUMBER", "--port NUMBER",
        "sets broadcast port (default: #{DEFAULT_BCAST_PORT})") do |number|
        bcast_port = number.to_i
      end

      parser.on("-v", "--version", "shows version") do
        exit_with("broadchat #{Broadchat::VERSION}")
      end
      parser.on("-h", "--help", "shows this message") { exit_with parser }

      parser.separator <<-HELP

        Broadcast address can also be assigned with the environment variable BCAST_ADDR
        e.g.:
            export BCAST_ADDR='10.10.1.255'
        HELP

      parser.missing_option { exit_with parser }
      parser.invalid_option { exit_with parser }
      parser.unknown_args { |args| exit_with parser unless args.empty? }
    end

    return {
      addr: bcast_addr,
      port: bcast_port,
    }
  end

  # Prints all `messages` to console and shut the program down
  def self.exit_with(*messages)
    puts *messages
    exit
  end

  # Starts the program
  def self.main(args = ARGV.clone)
    options = parse(args)
    conn = Connection.new(options[:addr], options[:port])

    Signal::INT.trap do
      conn.close
      exit_with("\nGoodbye (＠´ー`)ﾉﾞ")
    end

    begin
      conn.setup.listen
    ensure
      conn.close
    end
  end
end

Broadchat::CLI.main
