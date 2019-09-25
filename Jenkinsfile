pipeline {
  agent { docker { image 'ruby:2.4.1' } }
  stages {
    stage('reqs'){
      sh 'echo "HELLOOOO"'
      sh 'gem install bundler -v 2.0.1'
    }
    stage('bundle') {
      steps {
        sh 'bundle install'
        sh 'echo "BBBUUUNNDDDLLEEEE"'
      }
    }
    stage('test'){
      sh 'rails test'
    }
  }
}