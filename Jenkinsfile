pipeline {
    agent any

    stages {
        stage('Setup Node.js') {
            steps {
                echo 'Installing Node.js and npm...'
                sh '''
                    apt-get update
                    apt-get install -y nodejs npm
                    node --version
                    npm --version
                '''
            }
        }

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
                echo 'Deploying application...'
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
