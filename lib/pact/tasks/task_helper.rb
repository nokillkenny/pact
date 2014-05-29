module Pact
  module TaskHelper

    extend self

    def execute_pact_verify pact_uri = nil, pact_helper = nil
      require 'pact/provider'
      require 'pact/provider/pact_helper_locator'

      command = verify_command(pact_helper || Pact::Provider::PactHelperLocater.pact_helper_path, pact_uri)
      system(command) ? 0 : 1
    end

    def handle_verification_failure
      exit_status = yield
      abort if exit_status != 0
    end

    def verify_command pact_helper, pact_uri = nil
      require 'rake/file_utils'

      command_parts = []
      command_parts << FileUtils::RUBY
      command_parts << "-S pact verify"
      command_parts << "-h" << (pact_helper.end_with?(".rb") ? pact_helper : pact_helper + ".rb")
      (command_parts << "-p" << pact_uri) if pact_uri
      command_parts.flatten.join(" ")
    end

  end
end