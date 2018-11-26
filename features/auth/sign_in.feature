Feature: Sign In
  As a DrewApp user
  I want to be able to sign in for DrewApp
  So that I can keep my tasks separate from everyone elses

  Scenario: Sign up via email
    Given I have not signed up
    And there are some tasks
    When I go to the app
    Then I should see the landing page
    When I click log in
    And I sign in with the email "alice@alice.com" and password "Password123"
    Then I should see the dashboard
    When I go to the task page
    Then I should see 0 tasks