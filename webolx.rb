require 'selenium-webdriver'
require 'rubygems'
require 'fileutils'

 	def setup
 		@driver = Selenium::WebDriver.for :chrome, driver_path: 'chromedriver.exe'
 		@driver.manage.window.maximize
		@driver.get "https://www.olx.com.br"
		FileUtils.mkdir_p "evidence"
		touch("id", "state-sp", "Touch in state São Paulo")
		write("id", "searchtext","GOL G6")
		touch("id", "searchbutton", "Touch in button send search")
	end
	def get_searchs
		$i=1
		while $i < 6 do
		title 	   = @driver.find_elements(:xpath,"//div[@class='OLXad-list-line-1 mb5px']")[$i].text
		definition = @driver.find_elements(:xpath,"//div[@class='OLXad-list-line-2']")[$i].text
		price      = @driver.find_elements(:xpath,"//p[@class='OLXad-list-price']")[$i].text
		puts "Oferta #{$i} -  #{price},  #{title}, #{definition}. "
		$i +=1
	end
	end

	def search(property,attribute)
		@driver.find_element(property, attribute)
	end

	def touch(property,attribute, comment)
		search(property, attribute).click
		puts comment
		@driver.save_screenshot "evidence/#{comment}.png"
	end
	
	def write(property,attribute, value)
		search(property,attribute).send_keys value 
	end

	setup
	get_searchs