// define pipeline global variable
def job_info = [:]

job_info['folder'] = 'Demo'
job_info['name'] = env.JOB_BASE_NAME

pipeline {

  agent any

  stages {
    stage('Build') {
      when { expression { version == 'none' } }

      steps {
        echo 'Building AMI...'
        deleteDir()
      }
    }

    stage('Deploy') {
      when { expression { version != 'none' } }

      steps {
        dir("${env.JENKINS_HOME}/terraform-repo/aws_account/${phase}/${env.AWS_DEFAULT_REGION}/${job_info['name']}"){
          sh "make deploy image_id=${version}"
        }
      }
    }

    stage('Testing') {
      when { expression { version != 'none' } }

      steps {
        dir("${env.JENKINS_HOME}/terraform-repo/aws_account/${phase}/${env.AWS_DEFAULT_REGION}/${job_info['name']}"){
          sh "make test"
        }
      }
    }
  }
}
