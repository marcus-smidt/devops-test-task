# devops-test-task

This guide provides step-by-step instructions on how to deploy a Python application using Terraform and Ansible on an AWS EC2 instance.

## Prerequisites

1. **AWS Account**: Ensure you have an AWS account.
2. **AWS CLI**: Install and configure AWS CLI with the necessary permissions.
3. **Terraform**: Install Terraform from [Terraform Installation Guide](https://learn.hashicorp.com/tutorials/terraform/install-cli).
4. **Ansible**: Install Ansible from [Ansible Installation Guide](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html).
5. **SSH Key Pair**: Create an SSH key pair in the AWS Management Console and download the `.pem` file.

## Step 1: Deploy Infrastructure with Terraform

1. **Create Terraform Configuration**: Write your `main.tf` file to define your AWS infrastructure, including security groups and EC2 instances.

2. **Initialize Terraform**: Run the following command to initialize your Terraform configuration.

    ```bash
    terraform init
    ```

3. **Apply Terraform Configuration**: Apply the configuration to create the infrastructure.

    ```bash
    terraform apply
    ```

    Confirm the action by typing `yes` when prompted.

4. **Retrieve Public IP**: Note the public IP address of the EC2 instance from the Terraform output.

## Step 2: Configure and Deploy the Application with Ansible

1. **Create Ansible Playbook**: Write an Ansible playbook to install Nginx, Python, and the application on the EC2 instance.

2. **Configure Ansible Hosts**: Create an `inventory` file with the public IP of your EC2 instance.

    ```ini
    [web]
    <public-ip-address> ansible_user=ubuntu ansible_ssh_private_key_file=/path/to/your-key-name.pem
    ```

3. **Run Ansible Playbook**: Run the Ansible playbook to configure the instance and deploy the application.

    ```bash
    ansible-playbook -i hosts ansible/playbook.yml
    ```

## Step 3: Test the Deployment

1. **Access the Application**: Open a web browser and navigate to `http://<public-ip-address>/hello`. You should see the message "hello prozorro".

2. **Test User-Agent Restriction**:
    - Use a tool like `curl` to test the User-Agent restriction.

    ```bash
    curl -H "User-Agent: bad guy" http://<public-ip-address>/hello
    ```

    - You should receive a `403 Forbidden` response.

    ```bash
    curl -H "good guy" http://<public-ip-address>/hello
    ```

    - You should see the message "hello prozorro".

## Cleanup

To clean up the resources created by Terraform, run:

```bash
terraform destroy
