require 'selenium-webdriver'
require_relative '../pages/computer'

describe 'Computer' do

  before :each do
    chrome = Selenium::WebDriver::Service.chrome(path: 'driver/chromedriver.exe')
    @driver = Selenium::WebDriver.for :chrome, service: chrome
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    @computer = Computer.new(@driver)
  end

  after :each do
    @driver.quit
  end

  it 'Seach for a computer' do
    @computer.search_for('MacBook Pro')
  end

  it 'Add a computer' do
    @computer.access_form
    @computer.create('MacBook Pro', '2022-01-30', '2023-01-30', 'Apple Inc.')
  end

  it 'Edit a computer' do
    @computer.edit('MacBook Pro')
  end

end