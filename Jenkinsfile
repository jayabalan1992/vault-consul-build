pipeline {
    agent {
        docker {
            image 'puppet/puppet-agent'
        }
    }
    stages {
        stage('validate') {
            steps {
                sh 'puppet help'
            }
        }
    }
}
