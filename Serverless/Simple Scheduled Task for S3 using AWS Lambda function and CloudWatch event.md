Automating repeated tasks in a scheduled manner is also known for so-called cron jobs. It helps in reducing resource costs, maintaining system availability, and removing manual workloads efficiently over time.

In this article,will walk you through the steps for creating a simple scheduled task using Amazon CloudWatch and AWS Lambda to realize deleting log rotation in AWS S3 bucket.


#### AWS Resource

There are two AWS resources involved in building the scheduled task:

1. Amazon CloudWatch Event (Rules)
2. AWS Lambda (Lambda Function)

#### AWS Lambda DemoCode
[GitHub Repo](https://github.com/mingyu110/Best-Practice/tree/function_compute/logrotation)

#### Case Scenario

- The CloudWatch Rules will activate the Lambda function according to the scheduled time defined in the cron expression.
- The Lambda function will be activated once it is invoked by CloudWatch Events. It will call the Reporting Email API endpoint to perform the required tasks.
- The Reporting Email API will perform the analysis and generate the report. Once it is done, it will automatically send the email to managers.

#### Termilonogy
- [AWS Lambda](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html)is a compute service that lets you run code without provisioning or managing servers.With Lambda, all you need to do is supply your code in one of the language runtimes that Lambda supports.
- [AWS IAM]()
