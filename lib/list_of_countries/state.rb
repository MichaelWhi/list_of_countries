# frozen_string_literal: true

module ListOfCountries
  class State
    attr_reader :name
    attr_reader :code
    attr_reader :country_code

    def initialize(data, lightweight = ListOfCountries.lightweight?)
      @name = data.fetch("name")
      @code = data.fetch("state_code")

      @country_code = data.fetch("country_code") unless lightweight
    end

    def to_s
      name.to_s
    end

    def country
      ListOfCountries.country_by_code(country_code)
    end

    def cities
      found = country&.cities&.filter { |city| !city.state_code.nil? && city.state_code == code }
      found.nil? ? [] : found
    end

    ##
    # Find the first matching city in this state by its name
    def city_by_name(city_name)
      cities.find { |city| city.name == city_name.strip}
    end
  end
end
