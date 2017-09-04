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
        '''
      }
    }
    stage('clean') {
      steps {
        sh '''
          echo "clean up"
          docker system prune -f
          docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)
          docker images
          docker ps -a
        '''
      }
    }
    stage('test') {
      steps {
        sh '''
          echo "running rspec tests"
          docker-compose run web ./scripts/start-dev.sh rspec -f d
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
