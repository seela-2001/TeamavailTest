pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                echo 'Checking out the code ....'
                chekout scm
            }
        } 

        stage("Stop the container"){
            steps {
                sh 'docker compose down || docker-compose down || true'
            }
        }

        stage('Build the image') {
            steps{
                sh 'docker compose build --no-cache || docker-compose build --no-cache'
            }
        }

        stage('Re-run the container') {
            steps {
                sh 'docker compose up -d || docker-compose up -d'
            }
        }
    }

    post {
        success {
            echo 'Pipeline succeeded! Application is running..'
        }

        failure {
            echo "Pipline failed! Showing logs..."
            sh 'docker compose logs --tail=50 || docker-compose logs --tail=50 || true'
        }
    }
}