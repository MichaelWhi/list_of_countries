# frozen_string_literal: true

module ListOfCountries
  class City
    attr_reader :name
    attr_reader :country_code
    attr_reader :latitude
    attr_reader :longitude
    attr_reader :state_code

    def initialize(data, lightweight = ListOfCountries.lightweight?)
      @name = data.fetch("name")

      unless lightweight
        @country_code = data.fetch("country_code")
        @state_code = data.fetch("state_code")
        @longitude = data.fetch("longitude")
        @latitude = data.fetch("latitude")
      end
    end

    def to_s
      name.to_s
    end

    def country
      ListOfCountries.country_by_code(country_code)
    end

    def state
      country&.state_by_code(state_code)
    end
  end
end
