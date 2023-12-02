terraform {
    // Require Terraform Version
    required_version = ">= 1.5.7" # = >= 

    # Require Provider and their version
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "5.28.0" # Optional but recommended
        }
    }

    # Remote backend for storing Terraform State in S3 Bucket
    backend "s3" {
        bucket  = "your-bucket-name"
        key     = "/path/to/your/key"
        region  = "your-region"
    }
    # Experimental Features (Not Required)
    experiments = [ example ]
    # Passing Metadata to Providers (Super Advanced - Terraform)
    provider_meta "your-provider" {
        hello = "world"
    }
}   