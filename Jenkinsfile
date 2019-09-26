pipeline {
  agent any
  stages {
    stage('reqs') {
      steps {
        sh 'echo "HELLOOOO"'
        sh '''source /var/lib/jenkins/.rvm/scripts/rvm
rvm use 2.4.1
echo "DOONEE"'''
        sh 'gem install bundler -v 2.0.1'
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