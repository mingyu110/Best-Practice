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
- Then,the Reporting Email API will perform the analysis and generate the report. Once it is done, it will automatically send the email to managers.

#### Termilonogy
- [AWS Lambda](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html) is a compute service that lets you run code without provisioning or managing servers.With Lambda, all you need to do is supply your code in one of the language runtimes that Lambda supports.
- [AWS IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html) is a web service that helps you securely control access to AWS resources. With IAM, you can centrally manage permissions that control which AWS resources users can access. You use IAM to control who is authenticated (signed in) and authorized (has permissions) to use resources.
- [AWS CloudWatch](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/WhatIsCloudWatch.html) monitors your Amazon Web Services (AWS) resources and the applications you run on AWS in real time. You can use CloudWatch to collect and track metrics, which are variables you can measure for your resources and applications.

#### Architecture
   ![image](https://github.com/mingyu110/Best-Practice/assets/48540798/c3d91aea-9c66-4b5c-a11e-950c41329fc3)

#### Main Steps
- Choose or create an execution role of function
- Create function and choose runtime
- Write Lambda function code and Deploy
- Create Scheduled Event in the Amazon CloudWatch Console
  >- Create Event Source using "Schedule based on cron expression"
  >- Add Lambda function as Target using "Add Targets"
  >- Provide a name and description for our event rule
