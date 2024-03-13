
#### Introduction
- You can use the AWS Security Token Service (AWS STS) to create and provide trusted users with temporary security credentials that can control access to your AWS resources. Temporary security credentials work almost identically to long-term access key credentials, with the following differences:
  >- Temporary security credentials are short-term, as the name implies. They can be configured to last for anywhere from a few minutes to several hours. After the credentials expire, AWS no longer recognizes them or allows any kind of access from API requests made with them.
  >- Temporary security credentials are not stored with the user but are generated dynamically and provided to the user when requested. When (or even before) the temporary security credentials expire, the user can request new credentials, as long as the user requesting them still has permissions to do so.
- As a result, temporary credentials have the following advantages over long-term credentials:
  >- You do not have to distribute or embed long-term AWS security credentials with an application.
  >- You can provide access to your AWS resources to users without having to define an AWS identity for them.
  >- The temporary security credentials have a limited lifetime, so you do not have to update them or explicitly revoke them when they're no longer needed.

#### Common Secnarios
- Identity federation
  >- Enterprise identity federation
  >- Web identity federation
- Roles for cross-account access
- Roles for Amazon EC2
- Other AWS services

#### Case Study
1. access AWS resources from Microsoft Entra ID tenants using AWS Security Token Service [link](https://aws.amazon.com/blogs/security/how-to-access-aws-resources-from-microsoft-entra-id-tenants-using-aws-security-token-service/)

