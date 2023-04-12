pipeline {
  agent any
  
  environment {
  AWS_ACCESS_KEY_ID = "${credentials('AWS').AWS_ACCESS_KEY_ID}"
  AWS_SECRET_ACCESS_KEY = "${credentials('AWS').AWS_SECRET_ACCESS_KEY}"
}

  
  stages {
    stage('Terraform Init') {
      steps {
        dir('Terraform') {
          withCredentials([string(credentialsId: 'AWS', variable: 'AWS_ACCESS_KEY_ID'), string(credentialsId: 'AWS', variable: 'AWS_SECRET_ACCESS_KEY')]) {
            sh 'terraform init'
          }
        }
      }
    }
    
    stage('Terraform Plan') {
      steps {
        dir('Terraform') {
          withCredentials([string(credentialsId: 'AWS', variable: 'AWS_ACCESS_KEY_ID'), string(credentialsId: 'AWS', variable: 'AWS_SECRET_ACCESS_KEY')]) {
            sh 'terraform plan'
          }
        }
      }
    }
    
    stage('Terraform Apply') {
      steps {
        dir('terraform') {
          withCredentials([string(credentialsId: 'AWS', variable: 'AWS_ACCESS_KEY_ID'), string(credentialsId: 'AWS', variable: 'AWS_SECRET_ACCESS_KEY')]) {
            sh 'terraform apply -auto-approve'
          }
        }
      }
    }
  }
}
