$: << File.expand_path("../..", __FILE__)
Dir[File.dirname(__FILE__) + "/helpers/*.rb"].each { |file| require file }
require "awesome_print"
require "byebug"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
