Feature: User Settings
  
  Background:
    Given I am on Welcome Screen
	And I press the "SET" button with id "setImageView"
	
  Scenario: Verify User Configured Option During Installation Are Reflected In App Settings
	Given I am on the tutorial screen
	When I press the "Done" button with id "doneTextView"
	And I accept to get the "Breaking News" notifications
	And I open the "Navigation Drawer"
	And I scroll down the "Navigation Drawer"
	And I click on the "Settings" button from Navigation Drawer
	Then I should be navigated to "Settings" screen
	And I should see "CHOOSE EDITION" label
	And I should see "UNITED STATES" radio button with id "usButton"
	And I should see "INTERNATIONAL" radio button with id "internationalButton"
	And I should see "United States" radio button is checked
	And I should see "Push Alerts" are in "ON" state
	When I press the "Done" button with id "action_menu_done"
	Then I should be navigated to "Home" screen
	
  Scenario: Verify App Behaviour When User Changes Edition From Settings
    Given I am on the tutorial screen
	When I press the "Done" button with id "doneTextView"
	And I accept to get the "Breaking News" notifications
	And I open the "Navigation Drawer"
	Then I should see "FAVORITES" section is present in Navigation Drawer for United States edition
	When I scroll down the "Navigation Drawer"
	And I click on the "Settings" button from Navigation Drawer
	Then I should be navigated to "Settings" screen
	When I change the edition to "International"
	And I press the "Done" button with id "action_menu_done"
	And I open the "Navigation Drawer"
	Then I should see FAVORITES for US edition is changed to "FAVOURITES" for International edition