pipeline {
  agent any
    environment {
    ACR_PASS = credentials('ACR_PASS')
  }
  stages {
    stage('build') {
      steps {
        sh '''
          echo "building dev docker compose infrastructure"
          docker-compose build
          docker system prune -f
          docker images
        '''
      }
    }
    stage('test') {
      steps {
        sh '''
          echo "running rspec tests"
          docker-compose up test --exit-code-from test
        '''
      }
    }
  }
  post {
    always {
      echo "always"
    }
    success {
      echo "success"
    }
    failure {
      echo "failure!"
    }
  }
}
