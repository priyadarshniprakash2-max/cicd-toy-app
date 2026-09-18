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

        stage('Deploy') {
            steps {
                sshagent(['ec2-jenkins-key']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no ubuntu@3.110.45.83 "
                            cd ~/cicd-toy-app &&
                            git pull &&
                            docker build -t cicd-toy-app . &&
                            docker stop cicd-toy-app || true &&
                            docker rm cicd-toy-app || true &&
                            docker run -d --name cicd-toy-app -p 3000:3000 cicd-toy-app
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