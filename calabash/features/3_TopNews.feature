Feature: Top News
  
  Background:
    Given I am on Welcome Screen
	And I press the "SET" button with id "setImageView"	
	When I am on the tutorial screen
	And I press the "Done" button with id "doneTextView"
	And I accept to get the "Breaking News" notifications
	Then I should be navigated to "Home" screen
	
  Scenario: Verify Top News list displayed in app is same as in the feed url response
	Given I am on the "Home" screen
	When I open the "Navigation Drawer"
	And I select "Top News" from the navigation list
	Then I should be navigated to "Top News" screen
	And I verify "Top News" list is as per the corresponding feed url
	