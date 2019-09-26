pipeline {
  agent any
  stages {
    stage('reqs') {
      steps {
        sh '''#!/bin/bash -l
source /var/lib/jenkins/.profile;
/var/lib/jenkins/.rvm/bin/rvm list;
ruby -v
rvm use'''
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