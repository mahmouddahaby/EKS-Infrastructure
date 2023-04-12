pipeline {
  agent any
  
  environment {
    AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
    AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
  }
  
  stages {
    stage('Checkout') {
      steps {
        git branch: 'master', url: 'https://github.com/mahmouddahaby/Fixed-Solutions-Infrastructure.git'
      }
    }
    
    stage('Terraform Init') {
      steps {
        dir('terraform') {
          withCredentials([string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'), string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')]) {
            sh 'terraform init'
          }
        }
      }
    }
    
    stage('Terraform Plan') {
      steps {
        dir('terraform') {
          withCredentials([string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'), string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')]) {
            sh 'terraform plan'
          }
        }
      }
    }
    
    stage('Terraform Apply') {
      steps {
        dir('terraform') {
          withCredentials([string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'), string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')]) {
            sh 'terraform apply -auto-approve'
          }
        }
      }
    }
  }
}
