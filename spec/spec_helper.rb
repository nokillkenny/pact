require 'rspec'
require 'rspec/fire'
require 'fakefs/spec_helpers'
require 'rspec'
require 'pact'
require 'webmock/rspec'
require_relative 'support/factories'
require_relative 'support/spec_support'

WebMock.disable_net_connect!(allow_localhost: true)

require './spec/support/active_support_if_configured'

RSpec.configure do | config |
  config.include(FakeFS::SpecHelpers, :fakefs => true)
  config.include(RSpec::Fire)

  config.extend Pact::Provider::RSpec::ClassMethods
  config.include Pact::Provider::RSpec::InstanceMethods
  config.include Pact::Provider::TestMethods
  config.include Pact::SpecSupport
end

