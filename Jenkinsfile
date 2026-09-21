pipeline {
    agent any

    stages {

        stage('Build') {
            steps {
                echo 'Installing dependencies...'
                sh 'npm install'
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                sh 'npm test'
            }
        }

        stage('Deploy DEV') {
            when {
                branch 'integration'
            }

            steps {
                echo 'Deploying to DEV environment...'

                sshagent(['ec2-jenkins-key']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no ubuntu@13.200.215.48 "
                            cd ~/cicd-toy-app &&
                            git pull &&
                            docker build -t cicd-toy-app:latest . &&
                            docker stop toy-dev || true &&
                            docker rm toy-dev || true &&
                            docker run -d --name toy-dev --env-file env/dev.env -p 3001:3001 cicd-toy-app:latest
                        "
                    '''
                }
            }
        }

        stage('Deploy QA') {
            when {
                branch 'main'
            }

            steps {
                echo 'Deploying to QA environment...'

                sshagent(['ec2-jenkins-key']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no ubuntu@13.200.215.48 "
                            cd ~/cicd-toy-app &&
                            git pull &&
                            docker build -t cicd-toy-app:latest . &&
                            docker stop toy-qa || true &&
                            docker rm toy-qa || true &&
                            docker run -d --name toy-qa --env-file env/qa.env -p 3002:3002 cicd-toy-app:latest
                        "
                    '''
                }
            }
        }

        stage('Approve Prod Deployment') {
            when {
                branch 'main'
            }

            steps {
                input message: 'Approve deployment to PROD?', ok: 'Deploy to PROD'
            }
        }

        stage('Deploy PROD') {
            when {
                branch 'main'
            }

            steps {
                echo 'Deploying to PROD environment...'

                sshagent(['ec2-jenkins-key']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no ubuntu@13.200.215.48 "
                            cd ~/cicd-toy-app &&
                            git pull &&
                            docker build -t cicd-toy-app:latest . &&
                            docker stop toy-prod || true &&
                            docker rm toy-prod || true &&
                            docker run -d --name toy-prod --env-file env/prod.env -p 3003:3003 cicd-toy-app:latest
                        "
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'CI/CD Pipeline completed successfully!'
        }

        failure {
            echo 'CI/CD Pipeline failed.'
        }
    }
}
