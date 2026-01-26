pipeline {
    agent {
        docker {
            image 'maven:3.9.6-eclipse-temurin-17'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
    tools{
        maven "maven3.9"
    }
    environment {
        DOCKER_REPO = "bph/spring-html"
        APP_JAR = "target\\HelloWarFile-0.0.1-SNAPSHOT.war"
        DOCKER_CREDENTIALS_ID = "dockerhub-credentials"
        DOCKER_HOST_PORT = "8081"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/bhonepyaehmuee/Spring_html.git'
            }
        }
        stage('Test Docker') {
            steps {
                sh 'which docker || echo "Docker not installed"'
            }
        }


        stage('Build Jar') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image and tag it with build number
                    def imageTag = "${env.BUILD_NUMBER}"
                    sh "docker build -t ${DOCKER_REPO}:${imageTag} ."
                    sh "docker tag ${DOCKER_REPO}:${imageTag} ${DOCKER_REPO}:latest"
                    env.IMAGE_TAG = imageTag
                }
            }
        }

       
       stage('Run Docker Container') {
        steps {
            echo "Running container locally (port 8082)..."
            sh """
                docker stop spring-html || true
                docker rm spring-html || true
                docker run -d --name spring-html -p 8081:8080 ${DOCKER_REPO}:${env.IMAGE_TAG}
            """
        }
    }

    }

   post {
          always {
              echo "✅ Pipeline finished."
          }
          success {
             echo "Pipeline succeeded! App running at http://localhost:${env.DOCKER_HOST_PORT}/"
          }
          failure {
              echo "Pipeline failed."
          }
      }
}
