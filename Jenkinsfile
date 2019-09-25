pipeline {
  agent any
  stages {
    stage('bundle') {
      steps {
        sh 'echo "HELLOOOO"'
        checkout scm
        sh 'bundle install'
        sh 'echo "BBBUUUNNDDDLLEEEE"'
      }
    }
  }
}