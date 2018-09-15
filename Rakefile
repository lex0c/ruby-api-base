require 'dotenv/load'

namespace :migrate do
  desc 'Run migrations => rake migrate:run'
  task :run, [:version] do |t, args|
    require 'sequel/core'
    Sequel.extension :migration
    Sequel.extension :date_arithmetic
    Sequel.split_symbols = true
    version = args[:version].to_i if args[:version]
    Sequel.connect(ENV['DATABASE_URL']) do |db|
      Sequel::Migrator.run(db, 'lib/database/migrations',
        target: version,
        allow_missing_migration_files: true
      )
    end
  end
  desc 'Create migration => rake migrate:create'
  task :create do
    ARGV.each { |a| task a.to_sym do ; end }

    args = ARGV.select{|a| (/^\w*$/ =~ a) != nil}
    args.unshift(Time.now.strftime('%Y%m%d%H%M%S'))

    out_file = File.new("lib/database/migrations/#{args.join('_').downcase}.rb", 'w')
    out_file.write("Sequel.migration do\n  up do\n\n DateTime :created_at, null: false\nDateTime :updated_at, null: false end\n\n  down do\n\n  end\nend\n")
    out_file.close
  end
end
