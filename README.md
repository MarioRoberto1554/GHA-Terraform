
# Dojo's Real Life Application Infraestructure as Code Repository

This repository contains all neccessary code to build up the infraestucture needed by the Node Application

# Branching strategy:

We want to follow GitHub Flow as branching strategy.
More information here:

Allowed branches are:

 - **feature/*** 
 - **development**
 - **main (*production*)**

# Workflow Files

There are three main files used to complete the whole Terraform Workflow, all of them implemented on GitHub Actions

- **terraform-plan.yml** Shows to be created cloud resources on screen; Runs on **approved Pull request** form **feature** branch to **Development** branch.
- **terraform-apply.yml** Builds infraesturture on Cloud Provider, Runs only on **approved Pull Request** from the **Development** brabcho to the main branch. 
- **tf_checks.yml** Runs on every P**ush to feature/* branch**
		-	Makes three checks over Terraform code:
			-	*TF Lint*: It is a linter that checks possible errors (like invalid instance types) for Major Cloud providers 		(AWS/Azure/GCP). It also help identify provider-specific issues before errors occur during a Terraform run. It warns you about deprecated syntax, unused declarations and enforce best practices, naming conventions.
			-	*TF Sec*: This tool uses static analysis of your terraform code to spot potential security issues. It checks for different misconfigurations across all major (and some minor) cloud providers( GCP, AWS, Azure ) based on hundreds of built-in-rules. It evaluates relationships between Terraform resources and is compatible with the Terraform CDK and supports multiple output formats like lovely (default), JSON, SARIF, CSV, CheckStyle, JUnit, text, Gif.
			-	*Checkov*: It is a static code analysis tool for scanning infrastructure as code (IaC) files for misconfigurations that may lead to security or compliance problems. Checkov includes more than 750 predefined policies to check for common misconfiguration issues. It has wide ranging use-cases like Terraform, Terraform plan, Cloudformation, Kubernetes, Dockerfile, Serverless or ARM Templates, and GitHub Actions


