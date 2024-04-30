pipeline {
    agent any
    environment {
        action = ''
    }
    stages {
        stage('Checkout from Git') {
            steps {
                git branch: 'main', url: 'https://github.com/Sibapanda22/Tetris-V1.git'
            }
        }
        stage('Terraform version') {
            steps {
                sh 'terraform --version'
            }
        }
        stage('Terraform init') {
            steps {
                dir('Eks-terraform') {
                    sh 'terraform init'
                }
            }
        }
        stage('Terraform validate') {
            steps {
                dir('Eks-terraform') {
                    script {
                        sh 'terraform validate'
                        if (currentBuild.result == null || currentBuild.result == 'SUCCESS') {
                            echo 'Terraform validate succeeded'
                            env.action = 'plan'
                        } else {
                            echo 'Terraform validate failed, proceeding with destroy'
                            env.action = 'destroy'
                        }
                    }
                }
            }
        }
        stage('Terraform plan') {
            when {
                expression { env.action == 'plan' }
            }
            steps {
                dir('Eks-terraform') {
                    sh 'terraform plan'
                    env.action = 'apply'
                }
            }
        }
        stage('Terraform apply/destroy') {
            steps {
                dir('Eks-terraform') {
                    sh 'terraform ${env.action} --auto-approve'
                }
            }
        }
    }
}

