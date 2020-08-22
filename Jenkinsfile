pipeline {
  agent any
  stages {
    stage('Teste01') {
      steps {
        sh 'echo "TEste"'
        whateverFunction("arg01")
        callSh("java -version")
        build 'job01'
      }
    }

  }
}

void whateverFunction(String argA) {
    sh 'ls -lha'
    echo "Hello World ${argA}"
}

void callSh(String cmd) {
    sh ('#!/bin/sh -e\n' + cmd)
}
