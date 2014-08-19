# rake db:export RAILS_ENV=development
# rake db:import RAILS_ENV=production

SEEDS = File.join(Rails.root, "db/seeds/")

namespace :db do
  desc 'Export the data from an existing database'
  task :export => :environment do
    sql  = "SELECT * FROM %s"
    skip_tables = ["schema_info", "schema_migrations"]

    ActiveRecord::Base.establish_connection(Rails.env)
    tables = (ActiveRecord::Base.connection.tables - skip_tables)

    tables.each do |table_name|
      File.open("#{SEEDS}#{table_name}.json", 'w') do |file|
        data = ActiveRecord::Base.connection.select_all(sql % table_name)
        file.write data.to_json
      end
    end
  end

  desc 'Import data from json files into database'
  task :import => :environment do
    Rake::Task['db:migrate'].execute

    files = (Dir.new(SEEDS).entries - ['.', '..', '.gitkeep'])

    if files.empty?
      raise "*** [ERROR] No import files found!"
    else
      files.each do |file|
        model = file.chomp('.json').classify.constantize
        data = ActiveSupport::JSON.decode(File.read("#{SEEDS}/#{file}"))

        data.each do |hash|
          object = model.new(hash)

          if model.name == "User"
            object.id = hash["id"]
            object.encrypted_password = hash["encrypted_password"]
            object.created_at = hash["created_at"]
            object.updated_at = hash["updated_at"]
          end

          begin
            if model.name == "User"
              object.save!(:validate => false)
            else
              object.save!
            end
          rescue Exception => e
            puts "*** [WARNING] #{model} import failed: #{e.inspect}"
          end


        end
      end
    end

    puts "*** [SUCCESS] done"

  end
end
