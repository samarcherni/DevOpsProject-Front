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
    stage('NPM Clean'){
        steps{
            sh 'npm cache clean --force'
            sh 'rm -rf node_modules package-lock.json'
        }
    }
    stage('NPM INSTALL'){
        steps{
            sh 'npm install --legacy-peer-deps --verbose'
        }
    }

    stage('Build') {
            steps {
                sh 'node --max-old-space-size=5120 ./node_modules/@angular/cli/bin/ng build --output-path=dist'
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