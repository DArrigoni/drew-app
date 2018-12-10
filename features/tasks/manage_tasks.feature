Feature: Manage Tasks
  As a DrewApp user
  I want to be able to manage my tasks
  So that I can organize work that I need to get done

  Scenario: Read existing tasks
    Given I have some tasks
    And I have logged in
    When I go to the task page
    Then I should see my tasks
    When I open the details of the first task
    Then I should see the first task's description

  Scenario: Add a new task
    Given there are no tasks
    And the user Bob exists
    And I have logged in
    And I am on the task page
    When I add a task for "Do something!"
    Then I should see 1 task
    And the first task should be "Do something!"
    And the form should be reset
    When I go off and do some work then return
    Then I should see a task for "Do something!"

  Scenario: Mark a task as done
    Given I have some tasks
    And I have logged in
    And I am on the task page
    When I mark the first task as done
    Then I should see 4 tasks

  Scenario: Show done tasks
    Given I have some mixed tasks
    And I have logged in
    When I go to the task page
    Then I should see 0 done tasks
    And I should see 3 tasks
    When I filter in done tasks
    Then I should see 3 done tasks
    And I should see 6 tasks

  Scenario: Change task title
    Given the user Bob exists
    And I have logged in
    And I have added the task "Fix the rof"
    And I am on the details page for first task
    When I click the edit button
    Then I should be ready to edit the task
    When I change the title to "Fix the roof"
    And I save my changes
    Then I should see a task for "Fix the roof"

  Scenario: Add a description to a task
    Given the user Bob exists
    And I have logged in
    And I have added the task "Fix the roof"
    And I am on the details page for first task
    When I click the edit button
    Then I should be ready to edit the task
    When I change the description to
        """
        Roof is big and peaked and requires big nails.
        Measure roof size
        Buy lots of big nails
        """
    And I save my changes
    And I go off and do some work then return
    And I go to the tasks page
    And I open the details of the first task
    Then I should see the description
        """
        Roof is big and peaked and requires big nails.
        Measure roof size
        Buy lots of big nails
        """