Feature: Manage Tasks
  As a DrewApp user
  I want to be able to manage my tasks
  So that I can organize work that I need to get done

  Scenario: Read existing tasks
    Given I have some tasks
    When I goto the task page
    Then I should see my tasks