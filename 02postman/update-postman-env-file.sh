#!/usr/bin/env bash

#This shell script updates Postman environment file with the API Gateway URL created
# via the api gateway deployment

echo "Running update-postman-env-file.sh"

api_gateway_url=`aws cloudformation describe-stacks \
  --stack-name petstore-api-stack \
  --query "Stacks[0].Outputs[*].{OutputValueValue:OutputValue}" --output text`

echo "API Gateway URL: https://skntgzvovc.execute-api.eu-west-1.amazonaws.com/prod" 

jq -e --arg apigwurl https://skntgzvovc-vpce-0b27ccb25401f01a2.execute-api.eu-west-1.amazonaws.com/prod '(.values[] | select(.key=="apigw-root") | .value) = $apigwurl' \
  PetStoreAPIEnvironment.postman_environment.json > PetStoreAPIEnvironment.postman_environment.json.tmp \
  && cp PetStoreAPIEnvironment.postman_environment.json.tmp PetStoreAPIEnvironment.postman_environment.json \
  && rm PetStoreAPIEnvironment.postman_environment.json.tmp

echo "Updated PetStoreAPIEnvironment.postman_environment.json"

cat PetStoreAPIEnvironment.postman_environment.json
