require 'erb'
require 'webrick'

ROOT = File.dirname(__FILE__)

server = WEBrick::HTTPServer.new(:Port => 8000)

server.mount '/assets', WEBrick::HTTPServlet::FileHandler, "#{ROOT}/public"

server.mount_proc '/' do |req, res|
  template = ERB.new(File.read("#{ROOT}/index.html.erb"))
  res.body = template.result
end

trap 'INT' do
  server.shutdown
end

server.start
