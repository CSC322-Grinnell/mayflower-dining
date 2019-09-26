pipeline {
  agent any
  stages {
    stage('reqs') {
      steps {
        sh '''source /var/lib/jenkins/.rvm/scripts/rvm;
ruby -v'''
      }
    }
    stage('bundle') {
      steps {
        sh 'bundle install'
        sh 'echo "BBBUUUNNDDDLLEEEE"'
      }
    }
    stage('test') {
      steps {
        sh 'rails test'
      }
    }
  }
}