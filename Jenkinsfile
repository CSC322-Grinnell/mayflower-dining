pipeline {
  agent any
  stages {
    stage('reqs') {
      steps {
        sh '''source /var/lib/jenkins/.rvm/scripts/rvm;
/var/lib/jenkins/.rvm/bin/rvm list'''
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