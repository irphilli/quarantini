# frozen_string_literal: true

require 'dry-configurable'
require_relative 'quarantini/version'
require_relative 'quarantini/quarantine'
require_relative 'quarantini/reporters/rspec_reporter'
require_relative 'quarantini/reporters/minitest_reporter'

module Quarantini
  class Error < StandardError; end

  extend Dry::Configurable
  setting :run_all, default: false
end
