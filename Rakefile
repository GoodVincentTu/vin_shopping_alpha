# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

namespace :test do
	Rake::TestTask.new :services => "test:prepare" do |t|
		t.libs << "test"
		t.pattern = "test/services/**/*_test.rb"
	end
end

# Rake::Task[:test].enhance { Rake::Task["test:services"].invoke }
