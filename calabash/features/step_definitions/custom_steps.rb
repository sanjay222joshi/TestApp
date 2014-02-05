require 'net/http'
require 'rexml/document'

Then /^I am on Welcome Screen$/ do
	performAction('wait_for_view_by_id', 'setImageView')
end

Then /^I should see the message "([^\"]*)"$/ do |text|
  performAction('assert_text',text, true) 
end

Then /^I should see "([^\"]*)" radio button with id "([^\"]*)"$/ do |text, id|
	performAction('wait_for_view_by_id', id)
end

Then /^I should see "([^\"]*)" radio button is checked by default$/ do |text|
  performAction( 'assert_view_property', 'usRadioImageView', 'isChecked', 'true' )
end

When /^I press the "(.*?)" button with id "(.*?)"$/ do |arg1, arg2|
  performAction('click_on_view_by_id',arg2)
end

Then /^I am on the tutorial screen$/ do
	performAction('wait_for_view_by_id', 'doneTextView')
end

Then /^I should see "(.*?)" button with id "(.*?)"$/ do |arg1, arg2|
  performAction('wait_for_view_by_id', arg2)
end

Then /^I accept to get the "([^\"]*)" notifications$/ do|text|
  performAction('press_button_with_text', 'Yes')
  performAction('wait', 15)
end

Then /^I open the "([^\"]*)"$/ do |text|
	performAction('wait', 15)
	performAction('press_menu')
end

Then /^I scroll down the "([^\"]*)"$/ do |text|
	performAction("drag_coordinates", query("* marked:'Slideshows'")[0]['rect']['center_x'], query("* marked:'Slideshows'")[0]['rect']['center_y'], query("* marked:'Home'")[1]['rect']['center_x'], query("* marked:'Home'")[1]['rect']['center_y'])
	performAction('press_menu')
end

Then /^I click on the "([^\"]*)" button from Navigation Drawer$/ do |text|
	performAction('select_from_menu', text)
end

Then /^I should be navigated to "([^\"]*)" screen$/ do |text|
  performAction('wait', 10)
  performAction('assert_text',text, true) 
end

Then /^I should see "([^\"]*)" label$/ do |text|
  performAction('assert_text',text, true) 
end

Then /^I should see "([^\"]*)" radio button is checked$/ do |text|
  performAction( 'assert_view_property', 'usButton', 'isChecked', 'true' )
end	

Then /^I should see "(.*?)" are in "(.*?)" state$/ do |text1, text2|
  performAction( 'assert_view_property', 'pushAlertButton', 'isChecked', 'true' )
end

Then /^I should see "([^\"]*)" section is present in Navigation Drawer for United States edition$/ do |text|
  performAction('assert_text',text, true) 
end

Then /^I change the edition to "([^\"]*)"$/ do |text|
	performAction('click_on_view_by_id',"internationalButton")
end

Then /^I should see FAVORITES for US edition is changed to "([^\"]*)" for International edition$/ do |text|
  performAction('assert_text',text, true) 
end

Then /^I verify "([^\"]*)" list is as per the corresponding feed url$/ do |text|
	performAction('wait', 15)
	# Web search for "Top News"
	url = 'http://search.cnbc.com/rs/search/combinedcms/view.xml?partnerId=20042&ids=19746125'

	#Array to store actual news in app
	newsFeed = []

	# get the XML data as a string
	xml_data = Net::HTTP.get_response(URI.parse(url)).body

	performAction('wait', 15)
	# extract event information
	doc = REXML::Document.new(xml_data)
	titles = []
	links = []
	doc.elements.each('//channel/item/title') do |ele|
		titles << ele.text
	end

	#########Looping to get store app news############

	last = query("* id:'titleTextView'", :text).count
	while last > 1
		newsFeed = newsFeed + query("* id:'titleTextView'", :text)
		performAction('wait', 15)
		performAction("drag_coordinates", query("* id:'titleTextView'")[last-1]['rect']['center_x'], query("* id:'titleTextView'")[last-1]['rect']['center_y'], query("* id:'titleTextView'")[0]['rect']['center_x'], query("* id:'titleTextView'")[0]['rect']['center_y'])
		performAction('wait', 15)
		last = query("* id:'titleTextView'", :text).count
	end
	newsFeed = newsFeed.uniq

	##########Loop to store app news ends###########
	i = 0
	flag = 'false'

	newsFeed.each_with_index do |news|
	#puts 'News:::::::> '+ news
	#puts 'Title::::::> '+ titles[i]
	#puts '***********************************************************************'
	
		if news.eql? titles[i]
			#assert_not_equal(titles[i],news,'==========MATCHED==========')
			flag = 'true'
		else
			assert_equal(titles[i],news,'NEWS NOT FOUND')
			# puts 'News:::::::> '+ news
			# puts 'Title::::::> '+ titles[i]
			# puts '***********************************************************************'
			flag = 'false'
		end

		#assert_equal(newsFeed[i], title, 'Failed: '+'Expected: ' + newsFeed[i] + ' But Appeared: '+ title)
		i = i+1
	end
	
	assert_equal('true',flag,'MESSAGE')

end


Then /^I check "([^\"]*)" section is available on Home screen$/ do |text|
	performAction('wait', 7)
	performAction("drag_coordinates", query("* marked:'Markets | Pre-Markets'")[0]['rect']['center_x'], query("* marked:'Markets | Pre-Markets'")[0]['rect']['center_y'], query("* id:'topNewsText'")[0]['rect']['center_x'], query("* id:'topNewsText'")[0]['rect']['center_y'])
	performAction('wait', 5)
end

Then /^I should be able to read "([^\"]*)" from Top news displayed on home page$/ do |text|
	performAction('wait', 10)
	# Web search for "Top News"
	url = 'http://search.cnbc.com/rs/search/combinedcms/view.xml?partnerId=20042&ids=19746125'

	newsFeed = []
	titles = []
	links = []
	i = 0
	flag = 'false'

	# get the XML data as a string
	xml_data = Net::HTTP.get_response(URI.parse(url)).body

	performAction('wait', 15)
	
	# extract title information
	doc = REXML::Document.new(xml_data)
		
	doc.elements.each('//channel/item/title') do |ele|
		titles << ele.text
	end

	performAction('wait', 5)
	topStoryInApp = query("* id:'topStoryTitleTextView'", :text)
	performAction('wait', 10)
	
	if topStoryInApp.include? titles[i]
		flag = 'true'
	else
		assert_equal(titles[i],topStoryInApp,'TOP STORY MISMATCH')
		flag = 'false'
	end
	
	assert_equal('true',flag,'MESSAGE')
end

Then /^I am on the "([^\"]*)" screen$/ do |text|
  performAction('assert_text',text, true) 
end


Then /^I select "([^\"]*)" from the navigation list$/ do |text|
  performAction('wait', 5)
  performAction('press_list_item', 2, 0) 
end

