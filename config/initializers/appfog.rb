require "pg"
services = JSON.parse(ENV['VCAP_SERVICES'])
postgresql_key = services.keys.select { |svc| svc =~ /postgresql/i }.first
postgresql = services[postgresql_key].first['credentials']
postgresql_conn = {:host => postgresql['hostname'], :port => postgresql['port'], :username => postgresql['user'], :password => postgresql['password'], :dbname => postgresql['name']}
connection = PG.connect(postgresql_conn)
