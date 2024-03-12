## My Experiences on How to Use Terraform

### How to Manage Secrets in Terraform

#### Background
- When you use Terraform to manage and provide cloud resources, you must properly manage sensitive data, such as API Keys and credentials of the database, to prevent sensitive data from leaking. How to manage sensitive data in Terraform is discussed herein set forth

#### Warning
- NEVER store any sensitive information in plaintext in Terraform code, as this may lead to the disclosure of sensitive data, such as sensitive data found in your git repository or terraform state file

#### Solutions
- Enviroment Varibles
- Encrypting secrets(KMS，PGP and SOPS)
- Cloud-based Services(AWS Secret Manager,etc.)

#### KeyNote
- Don't save your state in a local terrafrom.tfstate file, and you can save it on many backends, such as AWS S3 as well as  encrypting the key and then strictly controlling who can access your Terraform backend with IAM.
  > You can see that the issue regarding storing sensitive values in state files is still open at present. [Terraform GitHub Issues #516](https://github.com/hashicorp/terraform/issues/516) [Terraform available backends](https://developer.hashicorp.com/terraform/language/settings/backends/configuration#available-backends)
  
  > Add secret flag to variables when using environmental variables, and please refer to it at [Terraform sensitive varibles](https://developer.hashicorp.com/terraform/tutorials/configuration-language/sensitive-variables)

### How to enable multi-environment deployment combined with workspace when using Terraform

#### Overall reference directory structure (example of deploying ElasticCloud in multiple environments)

```
-- terraform
|   |-- envs
|   |   |-- cn-production
    |   |-- staging
    |   |-- qa
    |   |-- dev
|   |-- modules
|   |   |-- ec_deployment
    |   |-- ec_backup
    |   |-- ec_index_magement
```
- Reusable Modules that can be used to implement ElasticCloud
  ```
  -- modules
    |-- ec_deployment
    |   |-- README.md
    |   |-- data.tf
    |   |-- locals.tf
    |   |-- main.tf
    |   |-- outputs.tf
    |   |-- provider.tf
    |   |-- variables.tf
  ```
- Specific variable values of each ElasticCloud in the envs directory
   ```
   |   |-- envs​
   |   |   |-- cn-production​
   |   |   |   |-- ec_deployment​
   |   |   |   |       |-- locals.tf​
   |   |   |   |       |-- main.tf​
   |   |   |   |       |-- outputs.tf​
   |   |   |   |       `-- provider.tf​
   |   |   |-- staging​
   |   |   |   |-- ec_deployment​
   |   |   |   |       |-- locals.tf​
   |   |   |   |       |-- main.tf​
   |   |   |   |       |-- outputs.tf​
   |   |   |   |       `-- provider.tf​
   |   |   |-- int​
   |   |   |   |-- ec_deployment​
   |   |   |   |       |-- locals.tf
   ```
- Finally, put the definitions of different Terraform Workspace in provider.tf under their respective env; For instance, this is provider.tf file under INT directory
```
  terraform {
  required_version = "~> 1.3.2"

  required_providers {
    ec = {
      source  = "elastic/ec"
      version = "~> 0.4.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5"
    }
  }

  cloud {
    organization = "terraform-cloud"

    workspaces {
      name = "infra-elasticsearch--ec_deployment--aws--integration--infra"
    }
  }
}
 
```

### Typical file directory structure reference of Terraform Project
```
- modules/
    - services/
        - webserver-cluster/
            - examples/
            - main.tf
            - outputs.tf
            - vars.tf
            - user-data.sh
            - README.md
            - [] versions.tf
- stage/
    - vpc/
    - services/
        - frontend-app/
        - backend-app/
            - main.tf
            - outputs.tf
            - vars.tf
            - user-data.sh
            - README.md
            - [] provider.tf
            - [] versions.tf
            - [] terraform.tfvars（or `*.auto.tfvars`)
            - [] main.tfvars
    - data-storage/
        - mysql/
        - redis/
- prod/
    - vpc/
    - services/
        - frontend-app/
        - backend-app/
    - data-storage/
        - mysql/
        - redis/
- mgmt/
    - vpc/
    - services/
        - bastion-host/
        - jenkins/
- global/
    - iam/
    - s3/
        - main.tf
        - outputs.tf
        - vars.tf
        - user-data.sh
        - README.md
        - [] provider.tf
        - [] versions.tf
```
#### Note
- \- [] denotes this item is optional
- examples/ denotes this item is directory
