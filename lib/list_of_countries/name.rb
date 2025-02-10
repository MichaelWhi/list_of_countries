# frozen_string_literal: true

module ListOfCountries
  class Name
    attr_reader :common
    attr_reader :official

    def initialize(data)
      @common = data.fetch("common")
      @official = data.fetch("official")
    end

    def to_s
      common
    end
  end
end
