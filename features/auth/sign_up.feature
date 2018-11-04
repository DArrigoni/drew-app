Feature: Sign Up
  As a prospective DrewApp user
  I want to be able to sign up for DrewApp
  So that I can use the app

  @WIP
  Scenario: Sign up via email
    Given I have not signed up
    And there are some tasks
    When I go to the app
    Then I should see the landing page
    When I click sign up
    And I sign up with the email "bob@bob.bob"
    Then I should see the dashboard
    And I should see 0 tasks