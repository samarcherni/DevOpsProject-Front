pipeline {
    agent any
    environment {
        DOCKERHUB_USERNAME = 'balkiss7'
    }
    stages {
        stage('Checkout Git') {
            steps {
                script {
                    git branch: 'GestionOperateur',
                        url: 'https://github.com/samarcherni/DevOpsProject-Front.git',
                        credentialsId: 'devops-classe-git'
                    echo 'Git done'
                }
            }
        }
        stage('Clean Install') {
            steps {
                script {
                    sh "rm -rf"
                }
            }
        }
        stage('Maven Compile') {
            steps {
                script {
                    sh "npm  install"
                }
            }
        }
       /* stage('Test') {
            steps {
                sh 'mvn test' 
            }
        }
        stage('Static Test with Sonar') {
            steps {
                script {
                    sh "mvn sonar:sonar -Dsonar.login=admin -Dsonar.password=balkiss"
                }
            }
        } */
        stage('Build Docker') {
            steps {
                script {
                    sh "docker build -t balkiss7/achat-front ."
                }
            }
        }
        stage('Docker Login') {
           steps{
                withCredentials([usernamePassword(credentialsId: 'operateur', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                sh "docker login -u ${DOCKERHUB_USERNAME} -p ${DOCKERHUB_PASSWORD}"
             }
            }

        }
       stage('push Docker') {
            steps {
                script {
                    sh "docker push ${DOCKERHUB_USERNAME}/achat-front"
                }
            }
        } 
       
    }
}
