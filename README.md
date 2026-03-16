# SimpleTimeService Application

## Overview
This project demonstrates how to deploy a simple containerized web application on AWS using **Terraform and ECS Fargate**.  
The application returns the **current timestamp and the visitor’s IP address**.

The goal of this project was to practice a DevOps workflow: building an app, containerizing it with Docker, pushing it to Docker Hub, and deploying the infrastructure using Infrastructure as Code (Terraform).

---

## Application
The application is a small Python (Flask) service that returns:

```json
{
  "timestamp": "<current date and time>",
  "ip": "<visitor IP>"
}
```

When accessed from a browser, it also displays a simple web page showing the same information.

---

## Technologies Used
- Python (Flask)
- Docker
- Terraform
- AWS ECS (Fargate)
- Application Load Balancer
- AWS Certificate Manager (SSL)
- Amazon S3 (Terraform remote state)
- CloudWatch Logs

---

## Architecture
```
Internet
   │
   ▼
simpletimeservice.techmanship.in
   │
   ▼
Application Load Balancer (HTTP → HTTPS redirect)
   │
   ▼
Target Group
   │
   ▼
ECS Service (Fargate)
   │
   ▼
Docker Container (Flask App)
```

Infrastructure is created completely using **Terraform**.

---

## Repository Structure
```
.
├── app/
│   ├── app.py
│   └── requirements.txt
│
├── Dockerfile
│
├── terraform/
│   ├── ecs.tf
│   ├── ecs_service.tf
│   ├── iam_role.tf
│   ├── logs.tf
│   ├── provider.tf
│   ├── security.tf
│   ├── task_definition.tf
│   ├── alb.tf
│   └── s3_tfstate.tf
│
└── README.md
```

---

## Deployment Steps

### 1. Build and push Docker image
```
docker build -t simpletimeservice .
docker tag simpletimeservice <dockerhub-username>/simpletimeservice:latest
docker push <dockerhub-username>/simpletimeservice:latest
```

### 2. Configure AWS credentials
```
aws configure
```

### 3. Initialize Terraform
```
terraform init
```

### 4. Deploy infrastructure
```
terraform apply
```

Terraform creates:

- ECS cluster
- Fargate service
- Load balancer
- Target group
- IAM roles
- CloudWatch logs
- SSL certificate
- S3 backend for Terraform state

---

## Access the Application

After deployment the service can be accessed at:

```
https://simpletimeservice.techmanship.in
```

HTTP requests are automatically redirected to HTTPS.

---

## Notes
- Terraform state is stored remotely in **S3**.
- Application logs are available in **CloudWatch**.
- ECS service runs on **Fargate**, so no EC2 instances are required.

---

## Author
Lakshya Bhardwaj