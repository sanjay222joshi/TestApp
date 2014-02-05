Feature: Results
  Background:
    Given I am on Welcome Screen
	And I press the "SET" button with id "setImageView"
	Then I am on the tutorial screen
	When I press the "Done" button with id "doneTextView"
	And I accept to get the "Breaking News" notifications
	Then I should be navigated to "Home" screen
	
  Scenario: Validate authentication of Top Story from Top News displayed on Home Page is as per the US URL feed
	Given I am on the "Home" screen
	Then I should be able to read "Top Story" from Top news displayed on home page