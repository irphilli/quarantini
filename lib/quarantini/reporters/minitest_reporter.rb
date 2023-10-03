# frozen_string_literal: true

if defined? Minitest
  module Quarantini
    module Reporters
      class MinitestReporter < Minitest::Reporters::BaseReporter
        def initialize(options = {})
          super
          @quarantine_results = []
          reports_dir = options.fetch(:reports_dir)
          output_filename = options.fetch(:output_filename)
          @reports_path = File.absolute_path(reports_dir)
          @output_file_path = File.join(@reports_path, output_filename)
        end

        def record(test)
          super

          if test.error? || test.failure
            register_result(test, false)
          elsif test.skipped?
            register_result(test, nil)
          elsif test.passed?
            register_result(test, true)
          end
        end

        def report
          super
          FileUtils.mkdir_p(@reports_path)
          File.write(@output_file_path, @quarantine_results.to_json)
        end

        private

        def register_result(test, passed)
          test_metadata = (Kernel.const_get(test.klass).test_metadata || {}).dig(test.name.to_sym, :quarantine)
          return unless test_metadata

          @quarantine_results << QuarantineResult.new(name: test.name, test_path: test.location, passes: passed, date: Time.now.utc)
        end
      end
    end
  end

end
