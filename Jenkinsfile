pipeline{
    agent any

    stages('Checkout'){
        steps{
            git branch: 'main', url: 'https://github.com/anujnairr/cloud-resume.git'
        }
    }

    stages{
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