require 'httparty'
require 'pry'
require 'json'

class Holidapi
  def initialize
    @holidays = get('https://date.nager.at/api/v3/NextPublicHolidays/US')
  end

  def get(url)
    response = HTTParty.get(url)
    parse(response)
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def next(num, holidays)
    num -= 1
    holidays[0..num]
  end
end

