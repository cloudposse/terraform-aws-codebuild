pipeline { 
    agent any 
	parameters {
        string(defaultValue: '1.0.0.0', description: '', name: 'VERSION')
    }
    stages {
        stage('Build') { 
            steps { 
                echo 'Build Step'
                build 'fortify'
            }
        }
        stage('Deploy QA Env') {
            steps {
                echo 'Deployment QA Step'
            }
        }
		stage('QA Automated Smoke Test'){
            steps {
                echo 'Smoke Testing QA environment' 
            }
        }
        stage('Staging - Baseline Smoke Test'){
            steps {
                timeout(time:5, unit:'DAYS') {
					script {
						def userinput  = input(id: 'userInput', message:'Run baseline smoke tests?', submitter: 'holcombrm')
						
						echo "Staging Smoke Test Complete"
					}
				}
            }
        }
        stage('Deploy Stage Env Manual') {
            steps {
                timeout(time:5, unit:'DAYS') {
					script {
						def userinput  = input(id: 'userInput', message:'Disable Autoshard and Mute Datadog?', submitter: 'holcombrm')
						
						echo "Autoshard Disabled and Datadog Muted"
					}
				}   
                timeout(time:5, unit:'DAYS') {
					script {
						def version
						def sql
						
						def userinput  = input(id: 'userInput', message:'Approve deployment?', parameters: [
							string(defaultValue: "${params.VERSION}", description: '', name: 'BuildNumber', trim: false),
						    booleanParam(defaultValue: false, description: '', name: 'Web'),
							booleanParam(defaultValue: false, description: '', name: 'Worker'),
							booleanParam(defaultValue: false, description: '', name: 'SQL')
						], submitter: 'holcombrm')
						
						version = userinput.BuildNumber?:''
						sql = userinput.SQL?:false
						web = userinput.Web?:false
						worker = userinput.Worker?:false
						
						env.sql = userinput.SQL?:false
						env.web = userinput.Web?:false
						env.worker = userinput.Worker?:false
						
						if (userinput.SQL == true) {
							echo "Deploying SQL"
						}
						
						if (userinput.Web == true) {
							echo "Deploying Web"
						}
						if (userinput.Worker == true) {
							echo "Deploying Worker"
						}
						
						echo "Deployment Stage Complete ${version}"
						
					}
				}
            }
        }
		stage('Staging - UI and API Smoke Test'){
            steps {
                timeout(time:5, unit:'DAYS') {
					script {
						def userinput  = input(id: 'userInput', message:'Run automated smoke tests?', submitter: 'holcombrm')
						
						echo "Staging Smoke Test Complete"
					}
				}
            }
        }
        stage('Staging - Enable Autoshard and Unmute Datadog'){
            steps {
                timeout(time:5, unit:'DAYS') {
					script {
						def userinput  = input(id: 'userInput', message:'Enable Autoshard and Unmute Datadog?', submitter: 'holcombrm')
						
						echo "Autoshard Enabled and Datadog Unmuted"
					}
				}
            }
        }
        stage('Production - Baseline Smoke Test'){
            steps {
                timeout(time:5, unit:'DAYS') {
					script {
						def userinput  = input(id: 'userInput', message:'Run smoke tests?', submitter: 'holcombrm')
						
						echo "Production Smoke Test Complete"
					}
				}
            }
        }
        stage('Deploy Prod Env Manual') {
            steps {
                timeout(time:5, unit:'DAYS') {
					script {
						def userinput  = input(id: 'userInput', message:'Disable Autoshard and Mute Datadog?', submitter: 'holcombrm')
						
						echo "Autoshard Disabled and Datadog Muted"
					}
				}   
                timeout(time:5, unit:'DAYS') {
					script {
						def version
						def sql
						
						def userinput  = input(id: 'userInput', message:'Approve deployment?', parameters: [
							string(defaultValue: "${params.VERSION}", description: '', name: 'BuildNumber', trim: false),
						    booleanParam(defaultValue: "${env.web}", description: '', name: 'Web'),
							booleanParam(defaultValue: "${env.worker}", description: '', name: 'Worker'),
							booleanParam(defaultValue: "${env.sql}", description: '', name: 'SQL')
						], submitter: 'holcombrm')
						
						version = userinput.BuildNumber?:''
						sql = userinput.SQL?:false
						web = userinput.Web?:false
						worker = userinput.Worker?:false
						
						if (userinput.SQL == true) {
							echo "Deploying SQL"
						}
						
						if (userinput.Web == true) {
							echo "Deploying Web"
						}
						if (userinput.Worker == true) {
							echo "Deploying Worker"
						}
						
						echo "Deployment Prod Complete ${version}"
						
					}
				}
            }
        }
		stage('Production - UI and API Smoke Test'){
            steps {
                timeout(time:5, unit:'DAYS') {
					script {
						def userinput  = input(id: 'userInput', message:'Run smoke tests?', submitter: 'holcombrm')
						
						echo "Production Smoke Test Complete"
					}
				}
            }
        }
        stage('Production - Enable Autoshard and Unmute Datadog'){
            steps {
                timeout(time:5, unit:'DAYS') {
					script {
						def userinput  = input(id: 'userInput', message:'Enable Autoshard and Unmute Datadog?', submitter: 'holcombrm')
						
						echo "Autoshard Enabled and Datadog Unmuted"
					}
				}
            }
        }
    }
}
