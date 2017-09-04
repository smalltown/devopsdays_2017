import jenkins.model.Jenkins

// define global variable
def job_folder = 'Demo'
def job_name = 'Infrastructure_As_Code'

// load config file
def config = new ConfigSlurper().parse(readFileFromWorkspace('config/common.groovy'))

pipelineJob("${job_folder}/${job_name}") {

  properties {
    buildDiscarderProperty {
      strategy {
        logRotator {
          artifactDaysToKeepStr('')
          artifactNumToKeepStr('')
          daysToKeepStr('')
          numToKeepStr(config.numToKeepStr)
        }
      }
    }

    parametersDefinitionProperty {
      parameterDefinitions {

        choiceParameterDefinition {
          name('phase')
          choices ('demo')
          description(config.phase_description)
        }

        choiceParameterDefinition {
          name('version')
          choices ('ami-ffd2d1e9\nami-6d656316')
          description(config.version_description)
        }
      }
    }
  }

  definition {
    cps {
      script(readFileFromWorkspace("pipeline/${job_folder}/${job_name}.groovy"))
    }
  }
}

// approve the pipeline groovy automaitcally
def groovyscript = readFileFromWorkspace("pipeline/${job_folder}/${job_name}.groovy")
def scriptApproval = Jenkins.instance.getExtensionList('org.jenkinsci.plugins.scriptsecurity.scripts.ScriptApproval')[0]
scriptApproval.approveScript(scriptApproval.hash(groovyscript, 'groovy'))
