pipeline {
  agent any
    environment {
    ACR_PASS = credentials('ACR_PASS')
  }
  stages {
    stage('dev-build') {
      steps {
        sh '''
          echo "building dev docker compose infrastructure"
          docker-compose build
        '''
      }
    }
    stage('dev-clean') {
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
    stage('dev-validation') {
      steps {
        sh '''
          echo "running rspec tests"
          docker-compose run web ./scripts/start-dev.sh rspec -f d
        '''
      }
    }
    stage('prod-build') {
      steps {
        sh '''
          echo "building production docker images"
          docker build -t azurechyld.azurecr.io/web:$BUILD_NUMBER -f learn/Dockerfile-prod learn/
          docker build -t azurechyld.azurecr.io/logger:$BUILD_NUMBER -f logger/Dockerfile-prod logger/
        '''
      }
    }
    stage('prod-clean') {
      steps {
        sh '''
          echo "clean up"
          docker system prune -f
          docker images
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
