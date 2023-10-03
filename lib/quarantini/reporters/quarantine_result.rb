# frozen_string_literal: true

require "dry-struct"
require_relative "../types"

module Quarantini
  module Reporters
    class QuarantineResult < Dry::Struct
      # {
      #   "name": "some test",
      #   "passes": false,
      #   "testPath": "/path/to/spec.rb",
      #   "date": "2022-01-30T19:20:40.950Z"
      # }
      attribute :name, Quarantini::Types::String
      attribute :passes, Quarantini::Types::Bool.optional
      attribute :test_path, Quarantini::Types::String
      attribute :date, Quarantini::Types::Time
    end
  end
end
