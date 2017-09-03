pipeline {
  agent any
    environment {
    ACR_PASS = credentials('ACR_PASS')
  }
  stages {
    stage('build dev') {
      steps {
        sh '''
          echo "building development docker container image 1"
        '''
      }
    }
    stage('test') {
      steps {
        sh '''
          echo "running rspec tests"
        '''
      }
    }
  }
  post {
    always {
      echo "pruning docker images from system"
      sh '''docker system prune -f'''
    }
    success {
      echo "success"
    }
    failure {
      echo "failure!"
    }
  }
}
