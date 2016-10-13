require "../server"
require "../client"

module Udipo::CLI
  USAGE = <<-HELP
    Usage: udipo COMMAND [OPTION]...

    Command:
        server                   starts a chat server
        client                   starts a chat client
        help, --help, -h         shows this message
        version, --version, -v   shows build version
    HELP

  def self.main(args = ARGV.clone)
    case command = args.shift?
    when "server"
      server_cmd(args)
    when "client"
      client_cmd(args)
    when "version", "--version", "-v"
      exit_with("udipo #{Udipo::VERSION}")
    else
      exit_with(USAGE)
    end
  end

  def self.exit_with(usage)
    puts usage
    exit
  end

  def self.server_cmd(args)
    # TODO: parse server specific arguments
    Server.new().setup.listen
  end

  def self.client_cmd(args)
    # TODO: parse client specific arguments
    Client.new().setup.run
  end
end
