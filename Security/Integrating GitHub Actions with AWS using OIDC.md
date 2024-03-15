#### Background
Have you ever wondered how you can securely manage access to your AWS resources without Access keys and Secret Keys? AWS OIDC is actually a straightforward concept once you break it down. 
For instance, you want to eliminate the need to store log-term credentials to access AWS resources when you use GitHub Actions with AWS.

#### Terminology
- ID Token : An ID token contains the identity information about the authenticated users, and it is intended to be consumed by the front-end application.
- Access Token : An access token represents a ticket with permission to consume an API. The ID token and the access token are negotiated with an Authorization Server using OAuth 2.0。
- OIDC : OpenID Connect (OIDC) 
