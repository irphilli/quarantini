# frozen_string_literal: true

if defined? RSpec
  require 'rspec/core/formatters/base_formatter'
  require_relative 'quarantine_result'

  module Quarantini
    module Reporters
      class RspecReporter < ::RSpec::Core::Formatters::BaseFormatter
        ::RSpec::Core::Formatters.register self, :close, :example_passed, :example_failed, :example_pending

        def initialize(output)
          super
          @quarantine_results = []
        end

        def example_passed(passed)
          example = passed.example
          register_result(example, true) if example.metadata[:quarantine]
        end

        def example_pending(skipped)
          example = skipped.example
          register_result(example, nil) if example.metadata[:quarantine]
        end

        def example_failed(failure)
          example = failure.example
          register_result(example, false) if example.metadata[:quarantine]
        end

        def close(_notification)
          output.write @quarantine_results.to_json
        end

        private

        def register_result(example, passed)
          @quarantine_results << QuarantineResult.new(name: example.full_description, test_path: example.file_path, passes: passed,
                                                      date: Time.now.utc)
        end
      end
    end
  end
end
