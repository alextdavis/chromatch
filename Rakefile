require 'rubygems'
require 'bundler'

Bundler.require

require './seed'

Sequel.extension :migration
DB = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://db/main.db')
Dir['./models/*.rb'].each { |file| require file }

desc 'Perform migration reset (full erase and migration up)'
task :reset do
  Sequel::Migrator.run(DB, 'migrations', :target => 0)
  Sequel::Migrator.run(DB, 'migrations')
  puts '<= sq:migrate:reset executed'
end

desc 'Perform migration up/down to VERSION'
task :to do
  version = ENV['VERSION'].to_i
  raise 'No VERSION was provided' if version.nil?
  Sequel::Migrator.run(DB, 'migrations', :target => version)
  puts "<= sq:migrate:to version=[#{version}] executed"
end

desc 'Perform migration up to latest migration available'
task :up do
  Sequel::Migrator.run(DB, 'migrations')
  puts '<= sq:migrate:up executed'
end

desc 'Perform migration down (erase all data)'
task :down do
  Sequel::Migrator.run(DB, 'migrations', :target => 0)
  puts '<= sq:migrate:down executed'
end

desc 'Generate some dummy data for the database'
task :seed, [:table] do |task, args|
  unless args.table
    seed
  end
  if args.table.to_s.upcase == 'USERS'
    seed_users
  end
  if args.table.to_s.upcase == 'TAGS'
    seed_labels
  end
  if args.table.to_s.upcase == 'LABELLINGS'
    seed_labellings
  end
  puts '<= database seeded'
end

desc 'Reset database and seed'
task :resetSeed do
  Sequel::Migrator.run(DB, 'migrations', :target => 0)
  Sequel::Migrator.run(DB, 'migrations')
  puts '<= sq:migrate:reset executed'
  seed
end