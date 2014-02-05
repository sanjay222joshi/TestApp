Feature: Welcome Screen Verification
  @Basic_Smoke_Suite
  Scenario: Verify Welcome Screen UI and Actions
	Given I am on Welcome Screen
	Then I should see the message "PLEASE SELECT AN EDITION"
	And I should see "UNITED STATES" radio button with id "usRadioImageView"
	And I should see "INTERNATIONAL" radio button with id "internationalRadioImageView"
	And I should see "SET" button with id "setImageView"
	And I should see the message "You may change this preference"
	And I should see the message "at any time in the Settings menu."
	And I should see "United States" radio button is checked by default

	
  

	


		

	