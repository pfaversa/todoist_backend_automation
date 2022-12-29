Feature: Login Page Tests

    Background: Default URL
        Given url apiUrl

    @smoke
    Scenario: Create a new project with empty Name
        Given params { name: '', color: 'yellow', is_favorite: true }
        Given path 'projects'
        When method POST
        Then status 400
        And match response == "Name must be provided for the project creation"

    Scenario: Delete an invalid project Id
        * def invalidProjectId = 'Q"#zs33'
        Given path 'projects',invalidProjectId
        When method DELETE
        Then status 400
        And match response == "project_id is invalid"

    Scenario: Create a new task with empty Title
        Given params { content: ''}
        Given path 'tasks'
        When method POST
        Then status 400
        And match response == "Invalid argument value"

    Scenario: Attempt to delete an invalid task ID
        * def invalidTaskId = 'Q"#zs33'
        Given path 'tasks',invalidTaskId
        When method DELETE
        Then status 400
        And match response == "Task is invalid"