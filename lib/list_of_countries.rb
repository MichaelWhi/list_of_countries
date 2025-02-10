# frozen_string_literal: true

require "json"
require "list_of_countries/city"
require "list_of_countries/country"
require "list_of_countries/state"
require "list_of_countries/version"

module ListOfCountries  
  def self.countries
    @countries ||= begin
      path = File.expand_path("../../data/countries/countries.json", __FILE__)
      file = File.open(path, "r")
      JSON.load(file).map do |data|
        Country.new(data)
      end.freeze
    end
  end

  def self.states
    @states ||= begin
      path = File.expand_path("../../data/countries_states_cities_database/json/states.json", __FILE__)
      file = File.open(path, "r")
      JSON.load(file).map do |data|
        State.new(data)
      end.freeze
    end
  end

  def self.cities
    @cities ||= begin
      path = File.expand_path("../../data/countries_states_cities_database/json/cities.json", __FILE__)
      file = File.open(path, "r")
      JSON.load(file).map do |data|
        City.new(data)
      end.freeze
    end
  end

  ##
  # Find a country using its ISO2 code (ISO-3166-1 ALPHA2)
  def self.country_by_code(country_code)
    raise "The country_code is an ISO-3166-1 ALPHA2 code and thus must be two characters long (e.g. 'US' or 'DE')" if country_code&.size != 2 && !lightweight?
    
    countries.find { |country| country.code == country_code&.strip}
  end

  def self.country_by_name(country_name)
    countries.find { |country| country.name.common == country_name.strip}
  end

  def self.state_by_name_and_country(state_name, country_or_country_name_or_code)
    find_country_by_code_or_name(country_or_country_name_or_code)&.state_by_name(state_name)
  end

  def self.city_by_name(city_name)
    cities.find { |city| city.name == city_name}
  end

  def self.city_by_name_and_country(city_name, country_or_country_name_or_code)
    find_country_by_code_or_name(country_or_country_name_or_code)&.city_by_name(city_name)
  end

  def self.country_by_code_or_name(country_name_or_code)
    return country_name_or_code if country_name_or_code.is_a?(Country)
    if country_or_country_code.strip.size == 2
      country_by_code(country_or_country_code.strip)
    else
      country_by_name(country_or_country_code.strip)
    end
  end

  ##
  # call this to reduce memory usage, by reducing some information stored in cities.
  # If set, only the name of the city or state will be available, without connections to countries (or states).
  def self.lightweight!
    @@lightweight = true
  end

  def self.lightweight?
    defined?(@@lightweight) ? @@lightweight : false
  end
end
