# frozen_string_literal: true

module ListOfCountries
  class State
    attr_reader :name
    attr_reader :code
    attr_reader :country_code

    def initialize(data, lightweight = ListOfCountries.lightweight?)
      @name = data.fetch("name")

      unless lightweight
        @country_code = data.fetch("country_code")
        @code = data.fetch("state_code")
      end
    end

    def country
      ListOfCountries.countries.find { |c| c.code == country_code }
    end

    def cities
      ListOfCountries.cities.filter { |city| city.state_code == code && city.country_code == country_code }
    end
  end
end
