pipeline {
    agent any // IN THE LECTURE I WILL EXPLAIN THE SCRIPT AND THE WORKFLOW

    environment {
        // Define Docker Hub credentials ID
        DOCKERHUB_CREDENTIALS_ID = 'dockerhub-johannes-cred'
        // Define Docker Hub repository name
        DOCKERHUB_REPO = 'johannesliikanen/calculator'
        // Define Docker image tag
        DOCKER_IMAGE_TAG = 'ver2'
    }
    stages {
        stage('Checkout') {
            steps {
                // Checkout code from Git repository
                git 'https://github.com/emotytto00/docker_calc.git'
            }
        }
        stage('Run Tests') {
                    steps {
                        // Run the tests first to generate data for Jacoco and JUnit
                        bat 'mvn clean test' // For Windows agents
                        // sh 'mvn clean test' // Uncomment if on a Linux agent
                    }
                }
                stage('Code Coverage') {
                    steps {
                        // Generate Jacoco report after the tests have run
                        bat 'mvn jacoco:report'
                    }
                }
                stage('Publish Test Results') {
                    steps {
                        // Publish JUnit test results
                        junit '**/target/surefire-reports/*.xml'
                    }
                }
                stage('Publish Coverage Report') {
                    steps {
                        // Publish Jacoco coverage report
                        jacoco()
                    }
                }
        stage('Build Docker Image') {
            steps {
                // Build Docker image
                script {
                    docker.build("${DOCKERHUB_REPO}:${DOCKER_IMAGE_TAG}")
                }
            }
        }
        stage('Push Docker Image to Docker Hub') {
            steps {
                // Push Docker image to Docker Hub
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS_ID) {
                        docker.image("${DOCKERHUB_REPO}:${DOCKER_IMAGE_TAG}").push()
                    }
                }
            }
        }
    }
}
