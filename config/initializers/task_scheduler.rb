require 'rufus/scheduler'
scheduler = Rufus::Scheduler.start_new

scheduler.every '30m' do
  require "net/http"
  require "uri"
  Net::HTTP.get_response(URI.parse('http://codeglot.com'))
end
