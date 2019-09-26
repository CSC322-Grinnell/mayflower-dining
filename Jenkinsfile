pipeline {
  agent any
  stages {
    stage('reqs') {
      steps {
        sh 'source /var/lib/jenkins/.rvm/scripts/rvm; ruby -v'
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