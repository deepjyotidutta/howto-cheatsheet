# devx-queue-integration-do-not-delete
devx-queue-integration-do-not-delete

## Steps:
1. Create new Policy with publish/list access to SNS
1. Create Assumable IAM Role Devx-AGW-SNS-Webhook-Role and attach Policy to publish message to SNS
2. Update CMK Key policy and Allow above Role to access CMK
3. Create REST API Gateway
4. Integration Type AWS Service , SNS , POST , Publish
5. Use Role created earlier
6. Setup Header X-GitHub-Event in Method Request
7. Setup query params Message , MessageGroupId, TopicArn and all required headers as Message ATtributes under Integration Request
8. Deploy AGW
9. Create CloudFront Distribution using API GW URL
10. Enable all query params to be passed from Cloudfront to API GW

## Authorizer:
1. Create Lambda Authorizer for Basic Auth for all requests
2. Add the the Authorizer to the API Gateway Resource's Method Execution section Auth field
