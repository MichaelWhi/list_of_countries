# List Of Countries ![Ruby](https://github.com/tatey/list_of_countries/workflows/Ruby/badge.svg) [![Gem Version](https://badge.fury.io/rb/list_of_countries.svg)](https://badge.fury.io/rb/list_of_countries)

A list of countries, states, and cities in Ruby. Based on data from:

- [World countries in JSON, CSV, XML and Yaml](https://github.com/mledoze/countries)
- [Countries States Cities Database](https://github.com/dr5hn/countries-states-cities-database)

This gem was extracted from [Read Blindly](https://readblindly.com). Companies who use Read Blindly review job applications fairly and without bias.

## Installation

Add this line to your application's Gemfile:

``` ruby
gem 'list_of_countries'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install list_of_countries

## Usage

How many countries are there?

``` ruby
countries = ListOfCountries.countries
countries.size # => 250
```

What's the first country?

``` ruby
aruba = countries.first
aruba.name.common     # => "Aruba"
aruba.name.official   # => "Aruba"
aruba.languages       # => ["Dutch", "Papiamento"]
aruba.region          # => "Americas"
aruba.subregion       # => "Caribbean"
aruba.demonyms.female # => "Aruban"
aruba.demonyms.male   # => "Aruban"
```

How many cities or states are in the US?

``` ruby
us = ListOfCountries.country_by_code "US"
# us = ListOfCountries.country_by_name "United States" # would also be possible
us.cities.count # => 19823
us.states.count # => 66 # (states plus territories)
us.cities.first.to_s # => "Abbeville"
us.cities.first.state.to_s # => "Alabama"

al = us.states.first
al.to_s # => "Alabama"
al.cities.size # => 378
```

How many states are there?

``` ruby
states = ListOfCountries.states
states.size # => 4868
```

What's the first state?

``` ruby
state = states.first
state.name # => "Badakhshan"
state.code # => "BDS"
state.country.to_s # => "Afghanistan" 
```

How many cities are there?

``` ruby
cities = ListOfCountries.cities
cities.size # => 143852
```

What's the first city?

``` ruby
city = cities.first
city.name # => "Ashkāsham"
city.state.to_s # => "Badakhshan"
city.country # => "Afghanistan"
```

<details>

<summary>More country info with the countries gem</summary>

Get more country info using the [countries gem](https://github.com/countries/countries/). You have to install it, first.

Then, Just call the `iso_country` method on a `Country` object:

``` ruby
us = ListOfCountries.country_by_code "US"
us.iso_country # =>
# <ISO3166::Country:xxx
#  @country_data_or_code=
#   {"address_format" => "{{recipient}}\n{{street}}\n{{city}} {{region_short}} {{postalcode}}\n{{country}}",
#    "alpha2" => "US",
#    "alpha3" => "USA",
#    "continent" => "North America",
#    "country_code" => "1",
#    "currency_code" => "USD",
#    "distance_unit" => "MI",
#    "g20_member" => true,
#    "g7_member" => true,
#    "gec" => "US",
#    "geo" =>
#     {"latitude" => 37.09024,
#      "longitude" => -95.712891,
#      "max_latitude" => 71.3577635769,
#      "max_longitude" => -66.96466,
#      "min_latitude" => 18.91619,
#      "min_longitude" => -171.791110603,
#      "bounds" => {"northeast" => {"lat" => 71.3577635769, "lng" => -66.96466}, "southwest" => {"lat" => 18.91619, "lng" => -171.791110603}}},
#    "international_prefix" => "011",
#    "ioc" => "USA",
#    "iso_long_name" => "The United States of America",
#    "iso_short_name" => "United States of America",
#    "languages_official" => ["en"],
#    "languages_spoken" => ["en"],
#    "national_destination_code_lengths" => [3],
#    "national_number_lengths" => [10],
#    "national_prefix" => "1",
#    "nationality" => "American",
#    "number" => "840",
#    "postal_code" => true,
#    "postal_code_format" => "(\\d{5})(?:[ \\-](\\d{4}))?",
#    "region" => "Americas",
#    "start_of_week" => "sunday",
#    "subregion" => "Northern America",
#    "un_locode" => "US",
#    "un_member" => true,
#    "unofficial_names" =>
#     ["United States", "USA", "Vereinigte Staaten von Amerika", "États-Unis", "Estados Unidos", "アメリカ合衆国", "Verenigde Staten", "Соединенные Штаты Америки"],
#    "vehicle_registration_code" => "USA",
#    "world_region" => "AMER",
#    "translations" => {"en" => "United States", "de" => "Vereinigte Staaten"},
#    "translated_names" => ["United States", "Vereinigte Staaten"]},
```

</details>


### Compatibility with older versions

If you want to reduce memory usage and the behavior of versions prior to 2.1.0, you can block some attributes from being imported. Then, however, no connection between cities, states and countries is established. Use that lightweight mode if you only want simple lists without references. The corresponding methods will not work and return `nil` or an empty array:

``` ruby
ListOfCountries.lightweight! # run this before any other call, now less data will be imported.

us = ListOfCountries.country_by_code "US"
us.to_s # => "United States"
us.cities # => [] # this information now is not present, the array is empty.
us.states # => []
ListOfCountries.cities.first.country # => nil
```

## Development

This project uses Git Submodules. Use the `--recursive-submodules` flag when cloning the repository.

    $ git clone --recursive-submodules git@github.com:tatey/list_of_countries.git

After cloning out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tatey/list_of_countries. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/tatey/list_of_countries/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT license](https://github.com/tatey/list_of_countries/blob/master/LICENSE.txt). Data is under the terms of their individual submodule.

## Code of Conduct

Everyone interacting in the List of Countries project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/list_of_countries/blob/master/CODE_OF_CONDUCT.md).
