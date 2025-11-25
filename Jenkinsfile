pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                echo 'Checking out the code...'
                checkout scm
            }
        }

        stage("Stop & Clean Containers") {
            steps {
                echo 'Stopping and removing old containers, networks, and volumes (for a clean environment)...'

                sh 'docker compose down --remove-orphans || true'
            }
        }

        stage('Build the Image') {
            steps {
                echo 'Building image without cache to ensure latest code is used...'
                sh 'docker compose build --no-cache --force-rm'
            }
        }

        stage('Deploy the Container') {
            steps {
                echo 'Starting new container from the fresh build...'
                sh 'docker compose up -d --force-recreate'
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline succeeded! Application is now running.'
        }

        failure {
            echo "❌ Pipline failed! Showing logs for debugging..."
            sh 'docker compose logs --tail=50 || true'
        }
    }
}