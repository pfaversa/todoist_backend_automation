Feature: Login Page Tests

    Background: Default URL
        Given url apiUrl

    Scenario: Create new project and new task then delete task and project
       
        #Create new Project
        Given params { name: 'Karate Project', color: 'yellow', is_favorite: true }
        Given path 'projects'
        When method POST
        Then status 200
        * def projectId = response.id

        #List new project
        Given path 'projects',projectId
        When method GET
        Then status 200
        And match response.id == projectId
        And match response.name == 'Karate Project'
        And match response.color == 'yellow'
        And match response.is_favorite == true

        #Update new project
        Given params { name: 'Karate Project Update', color: 'violet', is_favorite: false}
        Given path 'projects',projectId
        When method POST
        Then status 200

        #List new project updated and verify
        Given path 'projects',projectId
        When method GET
        Then status 200
        And match response.id == projectId
        And match response.name == 'Karate Project Update'
        And match response.color == 'violet'
        And match response.is_favorite == false

        #Verify empty tasks on new project
        Given params { project_id: #(projectId)}
        Given path 'tasks'
        Given method GET
        Then status 200
        And match response == []

        #Create new task on new project
        Given params {content:'Karate Task', description:'Karate description', project_id: #(projectId)}
        Given path 'tasks'
        Given method POST
        Then status 200
        * def taskId = response.id

        #Update new task
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * def taskDue = dataGenerator.dueDate(5);
        Given params {due_date: #(taskDue)}
        Given path 'tasks',taskId
        Given method POST
        Then status 200

        #List task updated and verify
        Given params { project_id: #(projectId)}
        Given path 'tasks'
        Given method GET
        Then status 200
        And match response[0].due.date == taskDue

        #Delete task
        Given path 'tasks',taskId
        Given method DELETE
        Then status 204

        #Delete project
        Given path 'projects',projectId
        Given method DELETE
        Then status 204



