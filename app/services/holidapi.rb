require 'httparty'
require 'json'

class Holidapi
  attr_reader :upcoming_holidays

  def initialize
    @upcoming_holidays = get('https://date.nager.at/api/v3/NextPublicHolidays/US')
  end

  def get(url)
    response = HTTParty.get(url)
    parse(response)
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def next_three
    @upcoming_holidays[0..2]
  end
end