function fn() {
  
  var env = karate.env;
  //var env_data = karate.read('../env_data.json');
  
  var config = {
    apiUrl: '',
    accessToken: '',
    api_projects: 'projects',
    api_task: 'tasks',
  }

  if (!env) {
    env = 'prod';
  }
  
  if (env == 'qa') {
    config.apiUrl= "https://api.todoist.com/rest/v2"      //env_data.qa.API_URL;
    config.accessToken = "f7ac641a44dc91d23a1f432a5333516135a317c7"    //env_data.qa.TOKEN;
    
  }
  
  if (env == 'prod') {
    config.apiUrl= "https://api.todoist.com/rest/v2"      //env_data.prod.API_URL;
    config.accessToken = "f7ac641a44dc91d23a1f432a5333516135a317c7"    //env_data.prod.TOKEN;
  }

  karate.configure('headers',{ Authorization:'Bearer ' + config.accessToken })
  return config;
}
