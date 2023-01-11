Feature: Login Page Tests

    Background: Default URL
        Given url apiUrl
        Given def dataGenerator = Java.type('helpers.DataGenerator')
        Given def projectSchemaPOST = read('classpath:todoistApp/json/post_schema_new_project.json')
        Given def taskSchemaPOST = read('classpath:todoistApp/json/post_schema_new_task.json')
        Given def timeValidator = read('classpath:helpers/timeValidator.js')

        #Set variables 
        Given def projectName = dataGenerator.getRandomProjectName()
        Given def taskName = dataGenerator.getRandomTaskName()
        Given def taskDescription = dataGenerator.getRandomTaskDescription()
        Given def taskDue = dataGenerator.dueDate(5)
        
        
    @smoke
    Scenario: Create a new project, then add a new task and finally delete task and project
       
        #Create a new Project
        Given def randomColor = dataGenerator.colorProject()
        Given params { name: #(projectName), color: #(randomColor), is_favorite: true }
        Given path api_projects
        When method POST
        Then status 200
        And match response == projectSchemaPOST
        And assert responseTime < 1500
        And match header Content-Type == 'application/json'
        * def projectId = response.id

        #List the new project
        Given path api_projects,projectId
        When method GET
        Then status 200
        And match response.id == projectId
        And match response.name == projectName
        And match response.color == randomColor
        And match response.is_favorite == true

        #Update the new project
        Given def randomColorUpdate = dataGenerator.colorProject()
        Given params { color: #(randomColorUpdate), is_favorite: false}
        Given path api_projects,projectId
        When method POST
        Then status 200

        #List the updated project and verify response values
        Given path api_projects,projectId
        When method GET
        Then status 200
        And match response.id == projectId
        And match response.name == projectName
        And match response.color == randomColorUpdate
        And match response.is_favorite == false

        #Verify empty tasks in new project
        Given params { project_id: #(projectId)}
        Given path api_task
        Given method GET
        Then status 200
        And match response == "#array"
        And match response == []

        #Create new task in a project
        Given params {content: #(taskName), description: #(taskDescription), project_id: #(projectId)}
        Given path api_task
        Given method POST
        Then status 200
        And match response == taskSchemaPOST
        * def taskId = response.id

        #Update the due date in task
        Given params {due_date: #(taskDue)}
        Given path api_task,taskId
        Given method POST
        Then status 200

        #List updated task and verify response values
        Given params { project_id: #(projectId)}
        Given path api_task
        Given method GET
        Then status 200
        And match response[0].due.date == taskDue

        #Delete task
        Given path api_task,taskId
        Given method DELETE
        Then status 204

        #Delete project
        Given path api_projects,projectId
        Given method DELETE
        Then status 204
