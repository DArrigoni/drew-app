Feature: Log In
  As a DrewApp user
  I want to be able to log in and out for DrewApp
  So that I can keep my tasks separate from everyone elses

  Scenario: Log in via email
    Given I have not signed up
    And there are some tasks
    When I go to the app
    Then I should see the landing page
    When I click log in
    And I log in with the email "alice@alice.com" and password "Password123"
    Then I should see the dashboard
    When I go to the task page
    Then I should see 0 tasks

  Scenario: Log out
    Given the user Bob exists
    And I have logged in
    When I go to the app
    Then I should see the dashboard
    When I log out
    Then I should see the landing page
    When I go to the task page
    Then I should see the landing page