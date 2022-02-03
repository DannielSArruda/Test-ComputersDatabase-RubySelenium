class Computer
  SEARCH_INPUT = {id: 'searchbox'}
  SEARCH_SUBMIT = {id: 'searchsubmit'}
  ADD_COMPUTER_BUTTON = {id:'add'}
  SUBMIT_CREATE_COMPUTER_BUTTON = {css: '[type="submit"]'}
  COMPUTER_NAME_INPUT = {id:'name'}
  INTRODUCED_INPUT = {id:'introduced'}
  DISCONTINUED_INPUT = {id:'discontinued'}
  COMPANY_SELECT = {id:'company'}
  COMPUTER_CREATED_MESSAGE = {css: '[class="alert-message warning"]'}

  def initialize(driver)
    @driver = driver
    @driver.get('https://computer-database.gatling.io/computers')
  end

  def search_for(name)
    @driver.find_element(SEARCH_INPUT).send_keys(name)
    @driver.find_element(SEARCH_SUBMIT).click
    @driver.find_element(xpath: "//a[contains(text(), '#{name}')]").displayed?
  end

  def edit(name)
    search_for(name)
    @driver.find_element(xpath: "//a[contains(text(), '#{name}')]").click
  end

  def access_form
    @driver.find_element(ADD_COMPUTER_BUTTON).click
    @driver.find_element(SUBMIT_CREATE_COMPUTER_BUTTON).displayed?
  end

  def company_name(company_name)
    {xpath:"//option[contains(text(), '#{company_name}')]"}
  end

  def create(name, introduced_date, discontinued_date, company)
    @driver.find_element(COMPUTER_NAME_INPUT).send_keys(name)
    @driver.find_element(INTRODUCED_INPUT).send_keys(introduced_date)
    @driver.find_element(DISCONTINUED_INPUT).send_keys(discontinued_date)
    @driver.find_element(COMPANY_SELECT).click
    @driver.find_element(company_name(company)).click
    @driver.find_element(SUBMIT_CREATE_COMPUTER_BUTTON).click

    @driver.find_element(COMPUTER_CREATED_MESSAGE).displayed?
  end
end