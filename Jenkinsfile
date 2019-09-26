pipeline {
  agent any
  stages {
    stage('reqs') {
      steps {
        sh '''source /var/lib/jenkins/.rvm/scripts/rvm;
rvm use 2.4.1'''
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