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
    stage('prod-login') {
      steps {
        sh '''
          echo "login to azure container registry"
          docker login --username=azurechyld --password=$ACR_PASS azurechyld.azurecr.io
        '''
      }
    }
    stage('prod-push') {
      steps {
        sh '''
          echo "push production docker images to azure container registry"
          docker push azurechyld.azurecr.io/web:$BUILD_NUMBER
          docker push azurechyld.azurecr.io/logger:$BUILD_NUMBER
        '''
      }
    }
    stage('prod-k8s') {
      steps {
        sh '''
          echo "deploy kubernetes to azure container service"
          envsubst < deployment.yaml | kubectl apply -f -
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
      echo "failure"
    }
  }
}
