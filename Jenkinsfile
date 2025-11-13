pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh '''
                    if docker compose version >/dev/null 2>&1; then
                        docker compose build
                    else
                        docker-compose build
                    fi
                '''
            }
        }

        stage('Run with Docker Compose') {
            steps {
                sh 'scripts/run.sh'
            }
        }
    }

    post {
        always {
            sh 'scripts/stop.sh || true'
        }
    }
}

