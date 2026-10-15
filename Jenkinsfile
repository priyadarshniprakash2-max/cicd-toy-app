```groovy
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
                echo 'Running application tests...'
                sh 'npm test'
            }
        }

        stage('Security Scan') {
            steps {
                echo 'Building application image and checking for CRITICAL vulnerabilities...'
                sh '''
                    set -eu

                    docker build -t cicd-toy-app:scan .

                    trivy image \
                        --scanners vuln \
                        --severity CRITICAL \
                        --exit-code 1 \
                        --no-progress \
                        cicd-toy-app:scan
                '''
            }
        }

        stage('Deploy DEV') {
            when {
                expression { false }
            }
            steps {
                echo 'Deployment temporarily disabled for security testing.'
            }
        }

        stage('Deploy QA') {
            when {
                expression { false }
            }
            steps {
                echo 'Deployment temporarily disabled for security testing.'
            }
        }

        stage('Approve Prod Deployment') {
            when {
                expression { false }
            }
            steps {
                echo 'Production approval temporarily disabled for security testing.'
            }
        }

        stage('Deploy PROD') {
            when {
                expression { false }
            }
            steps {
                echo 'Deployment temporarily disabled for security testing.'
            }
        }
    }

    post {
        success {
            echo 'Build, tests, and security scan completed successfully.'
        }

        failure {
            echo 'Pipeline failed. Check the stage logs for the cause.'
        }
    }
}
```
