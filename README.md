<samp><h6 align="center">#infrastructure, #project, #module</h6></samp>
# <samp align="center"><h2 align="center">Artemis Terraform modules</h2></samp>

<p align="center">
  <img src="https://img.shields.io/badge/terraform-22272E?&style=for-the-badge&logo=terraform&logoColor=844FBA">
</p>
<br/>

## Overview

This repository contains a collection of reusable Terraform modules designed specifically for use with Terragrunt. These modules follow best practices and provide a standardized approach to provisioning and managing cloud infrastructure.

Each module is self-contained, well-documented, and configurable, allowing for flexible infrastructure deployments while maintaining consistency across environments. By leveraging these modules with Terragrunt, you can keep your infrastructure code DRY (Don't Repeat Yourself) and manage multiple environments efficiently.

### Available Modules

- **EC2 Modules**: Comprehensive set of EC2-related resources
  - `ec2/ami`: AMI lookup and management
  - `ec2/ec2`: EC2 instance provisioning
  - `ec2/key`: SSH key pair management
  - `ec2/sg`: Security group configuration

## Contribute

Want to be part of this project?

Whether it’s improving documentation, fixing bugs, or adding new features — your help is always welcome.

Just fork the repo, make your changes, and open a pull request. Let’s build something great together!

## License
MIT License. See `LICENSE` file for details.
