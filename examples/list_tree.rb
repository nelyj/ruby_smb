#!/usr/bin/env ruby

require 'bundler/setup'

require 'smb2'

host = ARGV.first
if host.nil?
  $stderr.puts("Usage: #{$0} <ip address>")
  exit 1
end

d = Smb2::Dispatcher::Socket.connect(host, 445)

c = Smb2::Client.new(dispatcher: d, username: "msfadmin", password: "msfadmin")

c.negotiate
c.authenticate
tree = c.tree_connect("\\\\#{host}\\C$")

tree.list(directory: 'Users\\Public').each { |f| puts f.file_name }
