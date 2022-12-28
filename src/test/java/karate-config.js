function fn() {
  
  var env = karate.env;
  var env_data = karate.read('../env_data.json');
  
  var config = {
    apiUrl: '',
    accessToken: ''
  }

  if (!env) {
    env = 'prod';
  }
  
  if (env == 'qa') {
    config.apiUrl= env_data.qa.API_URL;
    config.accessToken = env_data.qa.TOKEN;
    
  }
  
  if (env == 'prod') {
    config.apiUrl= env_data.prod.API_URL;
    config.accessToken = env_data.prod.TOKEN;
  }

  karate.configure('headers',{ Authorization:'Bearer ' + config.accessToken })
  return config;
}
