# frozen_string_literal: true

require "list_of_countries/name"
require "list_of_countries/demonyms"

module ListOfCountries
  class Country
    attr_reader :name
    attr_reader :code
    attr_reader :demonyms
    attr_reader :languages
    attr_reader :region
    attr_reader :subregion

    def initialize(data)
      @name = Name.new(data.fetch("name"))
      @demonyms = Demonyms.new(fetch_demonyms(data))
      @languages = data.fetch("languages").values
      @region = data.fetch("region")
      @subregion = data.fetch("subregion")
      @code = data.fetch("cca2")
    end

    ##
    # Get a list of cities for this country.
    def cities
      ListOfCountries.cities.filter { |city| city.country_code == code }
    end

    ##
    # Get a list of states for this country.
    def states
      ListOfCountries.states.filter { |state| state.country_code == code }
    end

    def to_s
      name.to_s
    end

    ##
    # Find the first matching city in this country by its name
    def city_by_name(city_name)
      cities.find { |city| city.name == city_name.strip}
    end

    ##
    # Find the first matching state in this country by its name
    def state_by_name(state_name)
      states.find { |state| state.name == state_name.strip}
    end

    ##
    # Find the first matching state in this country by its state code
    def state_by_code(state_code)
      states.find { |state| state.code == state_code.strip}
    end

    ##
    # This method returns the corresponding `ISO3166::Country` object, if the 'countries' gem
    # from https://github.com/countries/countries/ is installed.
    # The returned object then contains additional information (phone codes, currency, geo information, address schemas, VAT info and more).
    def iso_country
      if defined?(::ISO3166::Country)
        ::ISO3166::Country.find_country_by_alpha2(code)
      else
        raise "To get more country information from the 'countries' gem (https://github.com/countries/countries/), please install it first."
      end
    end

    private

    def fetch_demonyms(data)
      demonym = data["demonym"]
      if demonym
        return {
          "eng" => {
            "f" => demonym,
            "m" => demonym,
          },
        }
      end

      demonyms = data["demonyms"]
      if demonyms
        return demonyms
      end

      raise KeyError, %q{keys not found: "demonym" or "demonyms"}
    end
  end
end
