pipeline {
  agent any
  stages {
    stage('reqs') {
      steps {
        sh 'source /var/lib/jenkins/.rvm/scripts/rvm'
        sh '''#!/bin/bash -xl
/var/lib/jenkins/.rvm/bin/rvm get stable
/var/lib/jenkins/.rvm/bin/rvm use 2.4.1'''
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