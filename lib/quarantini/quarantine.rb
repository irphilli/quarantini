# frozen_string_literal: true

require 'date'

module Quarantini
  class Released
    def skip?
      false
    end
  end

  RELEASED = Released.new

  class Quarantine
    class << self
      def skip?(quarantine_data)
        quarantine = mix_quarantini(quarantine_data)
        quarantine.skip?
      end

      def mix_quarantini(quarantine_data)
        if quarantine_data.nil?
          RELEASED
        elsif quarantine_data == true
          new
        else
          new(quarantine_data)
        end
      end
    end

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    def skip?
      !Quarantini.config.run_all && expires_at >= Date.today
    end

    def expires_at
      case @expires_at
      when nil
        Date.today.next
      when String
        Date.parse(@expires_at)
      when Date
        @expires_at
      else
        raise ArgumentError, "Unknown expiry type #{@expires_at.class.name}.  Expecting one of (nil|String|Date)"
      end
    end

    private

    attr_writer :expires_at
  end
end
