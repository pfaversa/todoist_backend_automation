function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'prod';
  }
  var config = {
    apiUrl: ''
  }
  if (env == 'dev') {
    config.userEmail = 'pablo.karate@test.com'
    config.userPass = 'pablo.karate'
  }
  
  if (env == 'prod') {
    config.apiUrl= 'https://api.todoist.com/rest/v2'
  }

  var accessToken = karate.callSingle('classpath:helpers/GetToken.feature', config).authToken
  karate.configure('headers',{ Authorization:'Bearer ' + accessToken })
  return config;
}