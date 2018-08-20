Feature: Manage Tasks
  As a DrewApp user
  I want to be able to track my task status
  So that I know what work I'm currently doing and what to do next

  Scenario: Start a task
    Given I have some tasks
    And I am on the task page
    When I start the first task
    Then I should see 1 started task

  Scenario: Stop a task
    Given I have some tasks
    And I am on the task page
    And the first task has been started
    When I stop the first task
    Then I should see 0 started tasks
