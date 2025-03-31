pipeline {
    agent any
    environment {
        WEBAPP_USER = "devadmin"  // Înlocuiește cu utilizatorul corect
        WEBAPP_IP = sh(script: "terraform output -raw web_server_ip", returnStdout: true).trim()
    }
    stages {
        stage('Deploy to WebApp VM') {
            steps {
                sh '''
                ssh -o StrictHostKeyChecking=no -i ~/.ssh/devazure.pem ${WEBAPP_USER}@${WEBAPP_IP} "
                cd /terraform/azure/python/Weather_App.py &&
                python3 Weather_App.py &
                "
                '''
            }
        }
    }
}
