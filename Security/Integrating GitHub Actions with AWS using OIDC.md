#### Background
Have you ever wondered how you can securely manage access to your AWS resources without Access keys and Secret Keys? AWS OIDC is actually a straightforward concept once you break it down. 
For instance, you want to eliminate the need to store log-term credentials to access AWS resources when you use GitHub Actions with AWS.

#### Terminology
- ID Token : An ID token contains the identity information about the authenticated users, and it is intended to be consumed by the front-end application.
- Access Token : An access token represents a ticket with permission to consume an API. The ID token and the access token are negotiated with an Authorization Server using OAuth 2.0。
- OIDC : OpenID Connect (OIDC) is providing an extra layer of protection. It allows GitHub Actions to assume an IAM role in AWS directly, eliminating the need to store long-term credentials,
  and you can know more benefit about OIDC combining with GitHub Actions at [About security hardening with OpenID Connect](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect)
- AWS IAM :  AWS Identity and Access Management (IAM), you can specify who or what can access services and resources in AWS, centrally manage fine-grained permissions, and analyze access to refine permissions across AWS.

#### Architecture

#### Steps
- Step1 : Creating an OIDC Provider for GitHub
  - Login AWS console and navigate to " Identity Provider"

    <img width="439" alt="截屏2024-03-17 15 47 21" src="https://github.com/mingyu110/Best-Practice/assets/48540798/1d6505fd-dbc1-44b6-bfe1-c0a42e8796e1">
  - Choose "OpenID Connect" as your Identity provider on "Add Provider" panel
    
    <img width="436" alt="截屏2024-03-17 15 53 19" src="https://github.com/mingyu110/Best-Practice/assets/48540798/aa5c649a-b352-4c08-a483-7b5b45e0a931">
  - Enter Provider URL: For the Provider URL, enter the GitHub OIDC IdP URL: https://token.actions.githubusercontent.com
  - Get Thumbprint: Click on "Get thumbprint" to verify the server certificate of your IdP. For more information on OIDC thumbprints, refer to the AWS documentation on[link](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc_verify-thumbprint.html)
  - Specify Audience: For the Audience, enter sts.amazonaws.com. This allows the AWS Security Token Service (AWS STS) API to be called by this IdP
    <img width="428" alt="截屏2024-03-17 15 59 45" src="https://github.com/mingyu110/Best-Practice/assets/48540798/0fedce82-0705-4609-b87e-9a07d34c8290">
- Step 2: Creating an IAM Role and Scope the Trust Policy
  - Create Role: On the Create role page, "Web identity" should be already selected as the trusted entity, and the Identity provider field should be populated with your IdP. In the Audience list, select sts.amazonaws.com, and then click "Next."
    <img width="438" alt="截屏2024-03-17 16 01 19" src="https://github.com/mingyu110/Best-Practice/assets/48540798/d4ae1846-9ce6-461c-8104-1e0ae03b7ca0">
  - Set Permissions: On the Permissions page, click "Next." You can add permissions as needed.
  - Add Tags (Optional): On the Tags page, you can add tags to this new role, and then click "Next: Review."
  - Review and Create Role: On the Create role page, enter a role name, such as "GitHubAction-AssumeRoleWithAction." Optionally, add a description. Click "Create role" to finalize the creation of the role.
 
By following these steps, you'll have set up an OIDC provider for GitHub and created an IAM role that can be assumed by GitHub Actions. This setup enhances the security of AWS resources by leveraging the identity federation between GitHub and AWS

- Step 3: Create GitHub Actions Workflow
  With our IAM role ready, we proceed to our GitHub repository and seamlessly integrate the OIDC step into our GitHub Actions workflow as follows:
  
