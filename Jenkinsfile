pipeline{
    agent any
    stages{
        stage('Checkout'){
            steps{
                git branch: 'main', url: 'https://github.com/anujnairr/cloud-resume.git'
            }
        }
    
        stage('Initialize'){
            steps{
                sh 'terraform init'
            }
        }
        stage('Validate'){
            steps{
                sh 'terraform validate'
            }
        }
        stage('Plan'){
            steps{
                sh 'terraform plan'
            }
        }
    }   
}