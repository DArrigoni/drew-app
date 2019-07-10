Feature: Track Tasks
  As a DrewApp user
  I want to be able to track my task status
  So that I know what work I'm currently doing and what to do next

  Background:
    Given the user Bob exists
    And I have logged in

  Scenario: Focus a task
    Given there are some tasks
    And I have added the task "Fix the roof"
    And I am on the tasks page
    When I focus the "Fix the roof" task
    Then I should see the "Fix the roof" task is focused
    And I should see the "Fix the roof" task is first on the list
    When I go off and do some work then return
    Then I should see the "Fix the roof" task is focused

  Scenario: Unfocus a task
    Given there are some tasks
    And I have added the task "Fix the roof"
    And the "Fix the roof" task has been focused
    And I am on the tasks page
    When I unfocus the "Fix the roof" task
    Then I should see the "Fix the roof" task is no longer focused
    And I should see the "Fix the roof" task is last on the list
    When I go off and do some work then return
    Then I should see the "Fix the roof" task is no longer focused

  Scenario: Show focused tasks
    Given I have added the task "Fix the roof"
    And I have added the task "Research the nutrition"
    And the "Fix the roof" task has been focused
    And I am on the tasks page
    When I filter for focused tasks
    Then I should see 1 task
    And I should not see a task for "Research the nutrition"
    When I reset the focused filter for tasks
    Then I should see 2 tasks

  Scenario: See started tasks on the dashboard
    Given I have added the task "Fix the roof"
    And I have added the task "Research the nutrition"
    And the "Fix the roof" task has been focused
    And I am on the dashboard page
    Then I should see 1 task on the dashboard
