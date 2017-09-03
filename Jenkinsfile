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
        '''
      }
    }
    stage('test') {
      steps {
        sh '''
          echo "running rspec tests"
          docker images
          docker ps -a
          docker-compose run web rspec
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
