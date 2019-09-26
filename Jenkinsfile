pipeline {
  agent any
  stages {
    stage('reqs') {
      steps {
        sh '''#!/bin/bash -l
source /var/lib/jenkins/.profile;
/var/lib/jenkins/.rvm/bin/rvm list;
rvm use 2.4.1
ruby -v
gem install bundle
bundle install
echo "DONE!"'''
      }
    }
    stage('bundle') {
      steps {
        sh '''ruby -v
rvm use 2.4.1
ruby -v
gem install bundle'''
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