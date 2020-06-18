#!/bin/bash

# MIT Licence - Copyright (c) 2020 Bircan Bilici - Run at Scale
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#


# capture an interrupt # 0
trap '[ ! -z "$job_id" ] && kill -9 $job_id' EXIT

# colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Help
if [[ -z $1 || $1 == "help" || $1 == "--help" || $1 == "-h" ]]
 then
  echo
  echo -e "${GREEN}  ----------- AWS Codebuild Provisioning. Start Build and tail to Log Stream.  -----------   ${NC} "
  echo   
  echo -e "${RED}  Basic Usage:${NC}  ./start-build.bash <codebuild-project-name> "
  echo
  echo -e "${RED}  With Optional Parameters:${NC}  ./start-build.bash <codebuild-project-name> <aws-profile> <aws-region> <print-dots> <initial-timeout> <update-timeout> <sleep-interval> <init-wait-time>"
  echo
  echo -e "${RED}  Parameter Definitions${NC} "
  echo
  echo -e "${GREEN}    codebuild-project-name  ${NC} : The name of the codebuild project. (Required)"
  echo
  echo -e "${GREEN}    aws-profile             ${NC} : AWS profile name in aws credentials file. (Optional)"
  echo
  echo -e "${GREEN}    aws-region              ${NC} : AWS region to be passed into external program calls. (Optional)"
  echo
  echo -e "${GREEN}    print-dots              ${NC} : Use 'print-dots' phrase to print dots on every sleep interval. Default active if not specified. "
  echo
  echo -e "${GREEN}    initial-timeout         ${NC} : Number in seconds. If log stream is never updated within time interval specified in this parameter, script will terminate. Default is 60 seconds. It takes about 40-50 seconds for first data stream to come."
  echo
  echo -e "${GREEN}    update-timeout          ${NC} : Number in seconds. If log stream is not recieved after last update exceeding update-timeout interval, script will terminate. Default is 60 seconds."
  echo
  echo -e "${GREEN}    sleep-interval          ${NC} : Number in seconds. Waiting period in each cyle. Default value is 1 second."
  echo
  echo -e "${GREEN}    init-wait-time          ${NC} : Number in seconds. Initial wait time to let codebuild prepare log groups.Default is 10 seconds."
  echo
  echo -e "${GREEN}    max-log-retry           ${NC} : Maximum number of retry count for log stream creation.  Default is 6 ."
  echo
  echo -e "${RED}  Note :${NC}  Use 'na' phrase to bypass an argument."
  echo
  echo "  ---------------------------------------------------------------"
  echo -e "${RED}  github: ${BLUE}https://github.com/brcnblc ${NC}"
  echo
  echo -e "${RED}  Licence${NC} : Copyright (c) 2020 Bircan Bilici - Run at Scale - See source code for details."
  echo
  exit 1
fi


# Check if cw is installed - Thnks to Luca Grulla (https://github.com/lucagrulla/cw)
echo Checking cw version
cw --version
if [[ $? != 0 ]]
  then
    echo -e "${RED}cw is not installed - ${BLUE}https://github.com/lucagrulla/cw"
    echo -e "${NC}Type following to install cw:"
    echo -e "${GREEN}brew tap lucagrulla/tap"
    echo -e "${GREEN}brew install cw"
    echo -e "${NC} "
    echo Exiting script.
    exit 1
  fi
    
# Stop on error
set -e

# Argument default values
project_name=$1
arg=$2;if [[ $arg != "na" && ! -z $arg ]];then aws_profile="$arg";fi;
arg=$3;if [[ $arg != "na" && ! -z $arg ]];then aws_region="$arg";fi;
arg=$4;if [[ $arg == "print-dots" || -z $arg ]];then dots=true;fi;

declare -i init_timeout="${5:-60}"
declare -i update_timeout="${6:-60}"
declare -i sleep_interval="${7:-10}"
declare -i init_wait_time="${8:-10}"
declare -i max_log_retry="${9:-6}"

echo 
echo "Project Name: "$project_name
echo "Aws Profile: "$aws_profile
echo "Aws Region: "$aws_region
echo -n "Print dots: "; if [[ $dots ]];then echo "true";else echo "false";fi
echo "Initial Timeout: "$init_timeout
echo "Update Timeout: "$update_timeout
echo "Sleep Interwal: "$sleep_interval
echo "Initial Wait time: "$init_wait_time
echo "Max Log Retry: "$max_log_retry

# Completion criteria
complete_phrase="Phase complete: POST_BUILD"
success_phrase="Phase complete: POST_BUILD State: SUCCEEDED"

# Stream file to be created and evaluated by the script
log_file="stream.log"

# ---------------------------------------

# Starting info
echo Starting to build $project_name

# Prepare arguments
if [[ $aws_profile ]];then aws_profile_arg="--profile $aws_profile";fi
if [[ $aws_region ]];then aws_region_arg="--region $aws_region";fi

function getStatus(){
  build_info=$(aws codebuild batch-get-builds --ids $build_id | jq .builds[0])

  Phases=$(echo $build_info | jq .phases)
  PhaseStatuses=$(echo $Phases | jq '.[] | {(.phaseType):(.phaseStatus)}' | jq -s add)

  if [[ $(echo $PhaseStatuses | grep -p "\"COMPLETED\": null") != "" ]];then BatchCompleted=true;fi
  if [[ $(echo $PhaseStatuses | grep -p "\"POST_BUILD\": \"SUCCEEDED\"") != "" ]];then BatchSucceeded=true;fi

}

# Run build command
build_id=$(aws codebuild start-build --project-name $project_name $aws_profile_arg $aws_region_arg | jq .build.id | sed s/\"//g)
echo build_id=$build_id

# Wait for Provisioning 
set +e
while true
do

# Get status
getStatus
echo $PhaseStatuses | jq .

ProvisioningPhase=$(echo $Phases | jq '.[] | select( .phaseType | contains("PROVISIONING"))' )
ProvisioningStatus=$(echo $ProvisioningPhase | jq .phaseStatus | sed s/\"//g)

echo ProvisioningStatus=$ProvisioningStatus

if [[ $ProvisioningStatus == "SUCCEEDED" ]] 
then
  break
fi

if [[ $(echo $ProvisioningStatus | grep "ERROR") != "" || $BatchCompleted == true ]]
then
  statusCode=$(echo $ProvisioningPhase | jq .contexts[0].statusCode | sed s/\"//g)
  errorMessage=$(echo $ProvisioningPhase | jq .contexts[0].message)
  
  # Try again if it gives "ACCESS_DENIED", in the very first deployment of build project
  findInMessage=$(echo $errorMessage | grep "does not allow AWS CodeBuild to create Amazon CloudWatch Logs log streams for build")

  if [[ $statusCode == "ACCESS_DENIED" &&  $findInMessage != "" && $retryCount < 2 ]] 
  then
    retryCount=$(($retryCount + 1))
    echo Access Denied error.
    echo Echo Retrying Build within 15 seconds...
    echo Retry: $retryCount
    echo "Waiting for 10 seconds"
    sleep 15
    # Run build command
    build_id=$(aws codebuild start-build --project-name $project_name $aws_profile_arg $aws_region_arg | jq .build.id | sed s/\"//g)
    echo new build id=$build_id
    BatchCompleted=""
  else
    echo -e "${RED}Error: $statusCode${NC}"
    echo -e "${RED}$errorMessage${NC}"
    exit 1
  fi
    
fi
echo "Provisioning still continues, Waiting for 15 seconds and retrying..."
sleep 15
done
set -e
# End of provisioning

# Extract Log Arn
cloudWatchLogsArn=$(echo $build_info | jq .logs.cloudWatchLogsArn)
echo cloudWatchLogsArn=$cloudWatchLogsArn

# Extract group
log_group=/aws/codebuild/$(echo $build_id | cut -d ":" -f 1)

# Extract stream
stream=$(echo $build_id | cut -d ":" -f 2)

# Concat
log_group_stream=$log_group:$stream

echo Log Id: $log_group_stream

# Clear file
if [ -f "$log_file" ]; then rm $log_file;fi
touch $log_file

# Wait for initialization
declare -i log_retry_count=0
while [ $log_retry_count -lt $max_log_retry ]
do
  log_retry_count=$((log_retry_count+1))
  echo "Try count: $log_retry_count"
  echo "Checking log_group $log_group"

  # Check if Log group exists
  if [[ $(cw ls groups | grep -p "$log_group$") != "" ]]
  then
    log_group_exists=true
    echo -e "${GREEN}Log group exists.${NC}"
    echo "Checking stream $stream"
    if [[ $(cw ls streams $log_group | grep -p "$stream$") != "" ]]
    then
      echo -e "${GREEN}Log stream exists.${NC}"
      log_stream_exists=true
    else
      echo -e "${RED}Log stream does not exist.${NC}"
    fi
  else
    echo -e "${RED}Log group does not exist.${NC}"
  fi

  if [ $log_stream_exists ]
    then
      break
    else
      if [ $log_retry_count -lt $max_log_retry ]
        then 
          echo "Wait for stream, trying in $init_wait_time seconds."
        else
          echo
          echo -e "${RED}Error: Couldn't find log stream. Exiting.${NC}"
          exit 1
      fi
  fi
        
  sleep $init_wait_time
done

# Attach cw process to background, direct stdout to log file
cw tail -f $aws_profile_arg $aws_region_arg $log_group_stream > $log_file 2>&1 &

# Get Job Id
job_id=$!

echo Job: $job_id

sleep 1

declare -i lines=0
declare -i linesold=0
declare -i elapsedtime=0
logupdated=false

echo "Waiting for first log update. "

while :
do
  linesold=$lines
  lines=$(wc -l $log_file | awk '{ print $1 }')

  if [[ $linesold != $lines ]]
  then 
    echo 
    awk -v linesold=$linesold 'NR > linesold' $log_file | sed '/^$/d'
    elapsedtime=0
    logupdated=true

    # Evaluate completion and exit on complete
        if [[ -f $log_file ]] && [[ ! -z $complete_phrase ]] &&  [[ ! -z $success_phrase ]]
          then
            if [[ $(grep "$complete_phrase" "$log_file") ]] 
              then
                if [[ $(grep "$success_phrase" "$log_file") ]] 
                  then
                    echo
                    echo -e "${GREEN}Success: Build completed succesfully.${NC} "
                    exit 0
                  else
                    echo
                    echo -e "${RED}Error: Build Failed.${NC} "
                    exit 1
                  fi
              fi
          fi
    fi


  # Wait for each cycle
  sleep $sleep_interval
  
  # Exit if timeout occurs
  elapsedtime+=$sleep_interval

  if [[ $logupdated == true ]]
    then
      if [[ $elapsedtime -gt $update_timeout ]]; then echo;echo Log Update Timeout;echo Error: Build failed.;exit 1; fi
    else
      if [[ $elapsedtime -gt $init_timeout ]]; then echo;echo Init Timeout;echo Error: Build failed.;exit 1; fi
  fi

  # Print Dots and seconds
  if [[ $dots ]] 
    then 
      if [[ $(($elapsedtime % 10)) -eq 0 ]]
        then 
          echo -n $elapsedtime
        else
          echo -n .
        fi 
  fi

  # check job status
  getStatus
  echo 
  if [[ $BatchCompleted == true && $BatchSucceeded != true ]]
  then 
    exitBatchCounter=$(($exitBatchCounter + 1))
  fi  

  if [[ $exitBatchCounter > 2 ]]
  then
    echo -e "${RED}Job Terminated Unexpectedly!${NC}"
    echo $PhaseStatuses | jq .
    exit 1
  fi
done

