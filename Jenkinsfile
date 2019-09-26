pipeline {
  agent any
  stages {
    stage('reqs') {
      steps {
        sh '''#!/bin/bash -l
source /var/lib/jenkins/.profile;
/var/lib/jenkins/.rvm/bin/rvm list;
rvm use 2.4.1
ruby -v'''
      }
    }
    stage('bundle') {
      steps {
        sh 'gem install bundle'
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