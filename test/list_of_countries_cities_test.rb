require "test_helper"

class ListOfCountriesCitiesTest < Minitest::Test
  def setup
    @cities = ListOfCountries.cities
  end

  def test_cities
    assert(143852 <= @cities.size)
  end

  def test_first_city
    city = @cities.first
    assert_equal("Ashkāsham", city.name)
  end

  def test_last_city
    city = @cities.last
    assert_equal("Zvishavane District", city.name)
  end

  def test_each_city_has_a_country
    assert(@cities.all?(&:country))
  end

  # disabled, since it is not true or data is incomplete. failing example: Trongsa in Bhutan
  # def test_each_city_has_a_state
  #  assert(@cities.all?(&:state))
  # end
end
