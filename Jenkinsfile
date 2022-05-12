pipeline {
         agent any
         stages {
                 stage('terraform-version') {
                  steps {
                     sh "terraform -v"
                  }
                 }
                 stage('terraform-init') {
                  steps {
                      sh 'terraform init'
                   }
                 }
                stage('terraform-Plan') {
                  steps {
                      sh  "terraform plan"
                   }
                 } 
                stage('terraform-apply') {
                  steps {
                      sh  "terraform destroy -auto-approve"
                   }
                   
                   }
           } 
           
      }
}
