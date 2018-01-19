require 'rspec'
require 'page-object'
require 'watir'
require 'require_all'

CONFIG = YAML.load_file("#{Dir.pwd}/config.yml")
BROWSER = CONFIG['browser']
DEFAULTS = YAML.load_file("#{Dir.pwd}/spec/support/fixtures.yml")

require_relative '../pages/basic_page'
BasicPage::BASIC_URL = CONFIG['basic_url']

require_all '././pages'

PageObject.default_page_wait = 120
PageObject.default_element_wait = 10

module PageObject
  module PageFactory
    def visit_page(page_class, params={:using_params => {}}, &block)
      tries ||= 3
      on_page page_class, params, true, &block
    rescue Net::ReadTimeout
      retry unless (tries -= 1).zero?
    end

    alias_method :visit, :visit_page
  end
end

RSpec.configure do |config|
  config.include PageObject::PageFactory
  config.before :all do

    #running browser
    @browser = Watir::Browser.new BROWSER.to_sym
    @browser.window.resize_to 1600, 1500
    @browser.driver.manage.timeouts.page_load = 120
  end

  config.after :all do
    @browser.close
  end
end