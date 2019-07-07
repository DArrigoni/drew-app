Feature: Tag Tasks
  As a DrewApp user
  I want to be able to tag my tasks
  So that I can quickly organize and find tasks relevant to different situations

  Background:
    Given the user Bob exists
    And I have logged in

  Scenario: Create a task with a tag via the # syntax
    Given I am on the tasks page
    When I add a task for "Fix the roof #home"
    Then I should see a task for "Fix the roof"
    And I should see 1 task tagged as "home"

  Scenario: Find other tasks with tag
    Given there are some tasks
    And I am on the tasks page
    Then I should see 5 tasks
    When I click the "home" tag
    Then I should see 3 tasks
    When I clear the tag filter
    Then I should see 5 tasks

  Scenario: Edit tags for a task
    Given I have added the task "Fix the roof"
    And I am on the tasks page
    Then I should see 0 tasks tagged as "Home"
    When I go to the edit page for the first task
    And I add the "Home" tag
    And I save my changes
    Then I should see the "Home" tag
    When I go to the tasks page
    Then I should see 1 task tagged as "Home"
    When I go to the edit page for the first task
    And I add the "Phone" tag
    And I save my changes
    Then I should see the "Home" tag
    And I should see the "Phone" tag
    When I close the task detail view
    Then I should see 1 task tagged as "Home"
    And I should see 1 task tagged as "Phone"
