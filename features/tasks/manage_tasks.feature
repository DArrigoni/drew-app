Feature: Manage Tasks
  As a DrewApp user
  I want to be able to manage my tasks
  So that I can organize work that I need to get done

  Scenario: Read existing tasks
    Given I have some tasks
    When I goto the task page
    Then I should see my tasks

  Scenario: Add a new task
    Given there are no tasks
    When I goto the task page
    And I add a task for "Do something!"
    Then I should see 1 task
    And the first task should be "Do something!"
    And the form should be reset

  Scenario: Mark a task as done
    Given I have some tasks
    When I goto the task page
    And I mark the first task as done
    Then I should see 4 tasks

  Scenario: Show done tasks
    Given I have some mixed tasks
    When I goto the task page
    Then I should see 0 done tasks
    And I should see 3 tasks
    When I filter in done tasks
    Then I should see 3 done tasks
    And I should see 6 tasks
