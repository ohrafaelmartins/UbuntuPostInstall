pipeline {
  agent any
  stages {
    stage('Teste01') {
      steps {
        sh 'echo "TEste"'
        whateverFunction "arg01" "arg02"
        build 'job01'
      }
    }

  }
}

void whateverFunction() {
    sh 'ls -lha'
    sh "Hello World $1 - $2"
}
