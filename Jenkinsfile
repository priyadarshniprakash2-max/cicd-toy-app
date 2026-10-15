```groovy
pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Installing application dependencies...'
                sh '''
                    set -eu
                    npm install
                '''
            }
        }

        stage('Test') {
            steps {
                echo 'Running application tests...'
                sh '''
                    set -eu
                    npm test
                '''
            }
        }

        stage('Security Scan') {
            steps {
                echo 'Building the hardened image and scanning for Critical vulnerabilities...'
                sh '''
                    set -eu

                    # Set a dedicated temporary directory for Trivy.
                    export TMPDIR=/var/tmp/trivy-tmp
                    mkdir -p "$TMPDIR"

                    # Build the hardened Docker image.
                    docker build \
                        -f Dockerfile.hardened \
                        -t cicd-toy-app:scan .

                    # Fail if any Critical vulnerability is detected.
                    trivy image \
                        --scanners vuln \
                        --severity CRITICAL \
                        --exit-code 1 \
                        --no-progress \
                        --skip-version-check \
                        cicd-toy-app:scan
                '''
            }
        }

        stage('Deploy DEV') {
            when {
                expression { false }
            }
            steps {
                echo 'Deployment disabled during security testing.'
            }
        }

        stage('Deploy QA') {
            when {
                expression { false }
            }
            steps {
                echo 'Deployment disabled during security testing.'
            }
        }

        stage('Approve Prod Deployment') {
            when {
                expression { false }
            }
            steps {
                echo 'Production approval disabled during security testing.'
            }
        }

        stage('Deploy PROD') {
            when {
                expression { false }
            }
            steps {
                echo 'Deployment disabled during security testing.'
            }
        }
    }

    post {
        success {
            echo 'Build, tests, and security scan completed successfully.'
        }

        failure {
            echo 'Pipeline failed. Review the stage logs for the cause.'
        }

        always {
            echo 'Pipeline execution finished.'
        }
    }
}
```
