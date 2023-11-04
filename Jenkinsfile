def getGitBranchName() {
    return scm.branches[0].name
}

def branchName
def targetBranch 

pipeline {
  agent any

  environment {
        DOCKERHUB_USERNAME = "samarcherni"
        STAGING_TAG = "${DOCKERHUB_USERNAME}/frontend:1.2"
    }

    parameters {
        string(name: 'BRANCH_NAME', defaultValue: "${scm.branches[0].name}", description: 'Git branch name')
        string(name: 'CHANGE_ID', defaultValue: '', description: 'Git change ID for merge requests')
        string(name: 'CHANGE_TARGET', defaultValue: '', description: 'Git change ID for the target merge requests')
    }


    stages {
        stage('Git checkout') {
            steps {
                script {
                    branchName = params.BRANCH_NAME
                    targetBranch = branchName

                    git branch: branchName,
                        url: 'https://github.com/samarcherni/DevOpsProject-Front.git',
                        credentialsId: '37b47f1c-2237-4c2d-93f3-47a063dd3226'
                }
                echo "Current branch name: ${branchName}"
                echo "Current target branch: ${targetBranch}"
            }
        }

    stage('NPM Clean') {
            when {
                expression { 
                    (params.CHANGE_ID != null) && (targetBranch == 'GestionCategorieProduit')
                }
            }
            steps {
                sh 'npm cache clean --force'
                sh 'rm -rf node_modules package-lock.json'
            }
        }
    stage('NPM INSTALL') {
            when {
                expression {
                    (params.CHANGE_ID != null) && (targetBranch == 'GestionCategorieProduit')
                }
            }
            steps {
                sh 'npm install --legacy-peer-deps --verbose'
            }
        }



    stage('Build') {
            when {
                expression { 
                    (params.CHANGE_ID != null) && (targetBranch == 'GestionCategorieProduit')
                }
            }
            steps {
                sh 'node --max-old-space-size=5120 ./node_modules/@angular/cli/bin/ng build --output-path=dist'
            }
        }

    
    stage('Build Docker') {
            when {
                expression {
                    (params.CHANGE_ID != null) && (targetBranch == 'GestionCategorieProduit')
                }
            }
            steps {
                script {
                    if (targetBranch == 'GestionCategorieProduit') {
                        sh "docker build -t ${STAGING_TAG} ."
                    } 
                }
            }
        }

        stage('Docker Login'){
	     when {
        expression {
          (params.CHANGE_ID != null) && ((targetBranch == 'GestionCategorieProduit'))
        }
    }
            steps{
                withCredentials([usernamePassword(credentialsId: '29873907-3831-4649-9fee-154080a8d225', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                sh "docker login -u ${DOCKERHUB_USERNAME} -p ${DOCKERHUB_PASSWORD}"
    }
  }

        }

    stage('Docker Push') {
            when {
                expression {
                    (params.CHANGE_ID != null) && (targetBranch == 'GestionCategorieProduit')
                }
            }
            steps {
                sh 'docker push $DOCKERHUB_USERNAME/front --all-tags'
            }
        }
        stage('Remove Containers') {
            when {
                expression {
                    (params.CHANGE_ID != null) && (targetBranch == 'GestionCategorieProduit')
                }
            }
            steps {
                sh '''
                container_ids=$(docker ps -q --filter "publish=8089/tcp")
                if [ -n "$container_ids" ]; then
                    echo "Stopping and removing containers..."
                    docker stop $container_ids
                    docker rm $container_ids
                else
                    echo "No containers found using port 8089."
                fi
                '''
            }
        }

  }
}