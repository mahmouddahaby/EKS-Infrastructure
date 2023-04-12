pipeline {
  agent any
  
  stages {
    stage('Checkout') {
      steps {
        git branch: 'master', url: 'https://github.com/mahmouddahaby/Fixed-Solutions-Infrastructure.git'
      }
    }
    
    stage('Terraform Init') {
      steps {
        dir('terraform') {
          sh 'terraform init'
        }
      }
    }
    
    stage('Terraform Plan') {
      steps {
        dir('terraform') {
          sh 'terraform plan'
        }
      }
    }
    
    stage('Terraform Apply') {
      steps {
        dir('terraform') {
          sh 'terraform apply -auto-approve'
        }
      }
    }
  }
}
