pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: 'master']], userRemoteConfigs: [[url: 'https://github.com/mahmouddahaby/Fixed-Solutions-Infrastructure']]])
            }
        }
        stage('Navigate to Terraform') {
            steps {
                sh 'cd Terraform'
            }
        }
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }
        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }
        stage('Terraform Apply') {
            when {
                branch 'master'
            }
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
    }
}
