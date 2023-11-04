pipeline {
  agent any

  stages {
    stage('Hello ') {
        steps {
            echo 'hello'
        }
    }
    stage('Checkout GIT') {
      steps {
        git branch: 'GestionCategorieProduit',
          credentialsId: '37b47f1c-2237-4c2d-93f3-47a063dd3226',
          url :'https://github.com/samarcherni/DevOpsProject-Front.git'
      }
     
    }
    stage('compile'){
        steps{
            sh 'npm start'
        }
    }
    stage('Docker build'){
     steps{
      sh 'docker build -t samarcherni/front:1.0 .'
     }
    }
    stage('Docker push image'){
     steps{
      sh 'docker login -u samarcherni -p Handsoff2021'
      sh 'docker push samarcherni/front:1.0'
     }
    }

  }
}