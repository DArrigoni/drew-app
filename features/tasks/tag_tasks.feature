Feature: Tag Tasks
  As a DrewApp user
  I want to be able to tag my tasks
  So that I can quickly organize and find tasks relevant to different situations

  Background:
    Given the user Bob exists
    And I have logged in

  Scenario: Start a task
    Given I am on the task page
    When I add a task for "Fix the roof #home"
    Then I should see a task for "Fix the roof"
    And I should see 1 task tagged as "home"

  Scenario: Find other tasks with tag
    Given there are some tasks
    And I am on the task page
    Then I should see 5 tasks
    When I click the "home" tag
    Then I should see 3 tasks
    When I clear the tag filter
    Then I should see 5 tasks