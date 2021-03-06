require File.expand_path("../../test/dummy/config/environment.rb", __FILE__)
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../../test/dummy/db/migrate", __FILE__)]
ActiveRecord::Migrator.migrations_paths << File.expand_path('../../db/migrate', __FILE__)
require 'rails/test_help'
require 'factory_bot'
require 'factories'
require 'byebug'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.file_fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.fixtures :all
end

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  def clear_root_folder
    Boxroom::Folder.instance_variable_set('@root_folder', nil)
  end

  def do_cleanup
    DatabaseCleaner.clean
    FileUtils.rm_rf(Dir["#{Rails.root}/#{Boxroom.configuration.uploads_path}"])
    ActionMailer::Base.deliveries.clear
  end
end
