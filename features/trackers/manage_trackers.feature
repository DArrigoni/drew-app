Feature: Manage Daily Trackers
  As a DrewApp user
  I want to be able to manage my daily trackers
  So that I can record and track information on a daily basis

  Background:
    Given the user Bob exists
    And I have logged in

  Scenario: Create new Tracker
    Given I have no trackers
    When I go to the trackers page
    Then I should see 0 trackers
    When I click the new Tracker button
    Then I should be on the create tracker page
    When I add the title "Go to bed on time"
    And I save my new tracker
    And I go to the trackers page
    Then I should see a tracker titled "Go to bed on time"

  Scenario: Record a new event for a tracker
    Given I have a tracker named "Go to bed on time"
    When I go to the trackers page
    And I click on the tracker named "Go to bed on time"
    Then I should be on the tracker page for "Go to bed on time"
    And I should see no tracker records
    When I add a tracker record
    Then I should see 1 tracker record
    And I should see a tracker record for today

  Scenario: Delete an existing tracker with no exsiting records
    Given I have a tracker named "Go to bed on time" with 0 records
    And I am on the tracker page for "Go to bed on time"
    When I delete the tracker
    Then I should be on the trackers page
    And I should see 0 trackers

  Scenario: Delete an existing tracker with exsiting records
    Given I have a tracker named "Go to bed on time" with 3 records
    And I am on the tracker page for "Go to bed on time"
    When I delete the tracker
    Then I should see a warning about deleting records
    When I cancel out of the tracker delete warning
    Then I should be on the tracker page for "Go to bed on time"
    And I should see 3 tracker records
    When I delete the tracker
    And I agree to the tracker delete warning
    Then I should be on the trackers page
    And I should see 0 trackers