require 'pry'
require 'json'
require 'capybara/blanket'

require 'coveralls'
Coveralls.wear!

class FakePage
  attr_reader :coverage_data

  def initialize
    @coverage_data = parse_fixture_json
  end

  def parse_fixture_json
    json = File.read(File.join(File.dirname(__FILE__),'fixtures','simple.json'))
    return JSON.parse(json) # How it looks when we get it from Selenium
  end

  def evaluate_script script
    if script == "window.CAPYBARA_BLANKET"
      self.coverage_data
    elsif script == "window.CAPYBARA_BLANKET.done"
      true
    elsif script == "window.CAPYBARA_BLANKET.is_setup"
      true
    end
  end
end
