ENV['RAILS_ENV'] ||= 'test'
require 'fixture_dependencies/sequel'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
#load "#{Rails.root}/db/seeds.rb"

FixtureDependencies.fixture_path = File.join(File.dirname(File.expand_path(__FILE__)), 'fixtures')

class ActiveSupport::TestCase
  def fixture(att)
    FixtureDependencies.load(att)
  end

  def run(*args, &block)
    Sequel::Model.db.transaction(rollback: :always, auto_savepoint: true) { super }
  end
end
