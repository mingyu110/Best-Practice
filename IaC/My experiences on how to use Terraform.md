## My Experiences on How to Use Terraform

### How to Manage Secrets in Terraform

#### Background
- When you use Terraform to manage and provide cloud resources, you must properly manage sensitive data, such as API Keys and credentials of the database, to prevent sensitive data from leaking. How to manage sensitive data in Terraform is discussed herein set forth

#### Warning
- NVER store any sensitive information in plaintext in Terraform code, as this may lead to the disclosure of sensitive data, such as sensitive data found in your git repository or terraform state file
