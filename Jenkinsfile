pipeline {
  agent any
  stages {
    stage('Teste01') {
      steps {
        sh 'echo "TEste"'
        build(job: 'job01', propagate: true, wait: true)
      }
    }

  }
}