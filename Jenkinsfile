pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: 'master']], userRemoteConfigs: [[url: 'https://github.com/mahmouddahaby/Fixed-Solutions-Infrastructure']]])
            }
        }
        stage('Terraform Init') {
            steps {
                dir('Terraform') {
                    sh 'terraform init'
                }
            }
        }
        stage('Terraform Apply') {
            when {
                branch 'master'
            }
            steps {
                dir('Terraform') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
}
