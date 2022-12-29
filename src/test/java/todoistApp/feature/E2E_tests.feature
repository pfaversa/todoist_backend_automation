Feature: Login Page Tests

    Background: Default URL
        Given url apiUrl
        Given def dataGenerator = Java.type('helpers.DataGenerator')
        Given def projectSchemaPOST = read('classpath:todoistApp/json/POST_schema_newProject.json')
        Given def taskSchemaPOST = read('classpath:todoistApp/json/POST_schema_newTask.json')
        Given def timeValidator = read('classpath:helpers/timeValidator.js')

        #Set variables 
        Given def projectName = dataGenerator.getRandomProjectName()
        Given def projectNameUpdate = dataGenerator.getRandomProjectName()
        Given def taskName = dataGenerator.getRandomTaskName()
        Given def taskDescription = dataGenerator.getRandomTaskDescription()
        Given def taskDue = dataGenerator.dueDate(5)
        
        
    @smoke
    Scenario: Create a new project, then add a new task and finally delete task and project
       
        #Create a new Project
        Given params { name: #(projectName), color: 'yellow', is_favorite: true }
        Given path 'projects'
        When method POST
        Then status 200
        And match response == projectSchemaPOST
        And assert responseTime < 1500
        And match header Content-Type == 'application/json'
        * def projectId = response.id

        #List the new project
        Given path 'projects',projectId
        When method GET
        Then status 200
        And match response.id == projectId
        And match response.name == projectName
        And match response.color == 'yellow'
        And match response.is_favorite == true

        #Update the new project
        Given params { name: #(projectNameUpdate), color: 'violet', is_favorite: false}
        Given path 'projects',projectId
        When method POST
        Then status 200

        #List the updated project and verify response values
        Given path 'projects',projectId
        When method GET
        Then status 200
        And match response.id == projectId
        And match response.name == projectNameUpdate
        And match response.color == 'violet'
        And match response.is_favorite == false

        #Verify empty tasks in new project
        Given params { project_id: #(projectId)}
        Given path 'tasks'
        Given method GET
        Then status 200
        And match response == "#array"
        And match response == []

        #Create new task in a project
        Given params {content: #(taskName), description: #(taskDescription), project_id: #(projectId)}
        Given path 'tasks'
        Given method POST
        Then status 200
        And match response == taskSchemaPOST
        * def taskId = response.id

        #Update the due date in task
        Given params {due_date: #(taskDue)}
        Given path 'tasks',taskId
        Given method POST
        Then status 200

        #List updated task and verify response values
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
