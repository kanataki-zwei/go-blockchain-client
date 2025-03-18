# Go Blockchain Client    

## Summary Overview
This is a simple Go blockchain client that interacts with the Polygon JSON-RPC API.    
It has been containerized using Docker and configured for deployment on AWS ECS Fargate using Terraform.     

Since this is a test, there are **no actual deployment**. Placeholders have been used for when urls have been requested to ensure terraform validates.   

## Production Readiness    
The following enhancements are necessary to ensure the application is **production-ready**.

---

### **Improvements for Production Readiness**

#### **1. Security**
- **API Authentication**: Implement JWT or API key authentication to prevent unauthorized access.
- **Rate Limiting**: Use tools like **Nginx, Cloudflare, or AWS API Gateway** to prevent abuse.
- **Environment Variables**: Move sensitive configurations (e.g., API keys, database credentials) to **AWS Secrets Manager** or **.env files**.
- **IAM Role Restrictions**: Ensure ECS tasks have minimal AWS permissions.

#### **2. Monitoring & Logging**
- **Structured Logging**: Use **Zap or Logrus** for better log formatting.
- **Monitoring**:
  - Add **AWS CloudWatch Logs & Metrics** to track performance.
  - Use **Prometheus + Grafana** for real-time monitoring.
- **Distributed Tracing**: Integrate with **OpenTelemetry** for tracing API requests.

#### **3. Scalability & Performance**
- **Auto Scaling**: Configure **AWS ECS Fargate Auto Scaling** based on CPU/memory usage.
- **Load Balancing**: Deploy an **AWS Application Load Balancer (ALB)** for handling multiple API requests.
- **Database Optimization**: Ensure indexing & caching for blockchain queries.

#### **4. Fault Tolerance**
- **Multiple Availability Zones (AZs)**: Deploy in at least **two AWS AZs** for redundancy.
- **Retry Mechanism**: Implement exponential backoff for API failures.
- **Health Checks**:
  - Add **/health** endpoint to verify service health.
  - Configure **AWS ECS health checks**.

#### **5. Infrastructure Improvements**
- **Terraform Remote State**: Store Terraform state in **AWS S3 + DynamoDB Locking**.
- **CI/CD Pipeline**:
  - Use **GitHub Actions or AWS CodePipeline** for automated testing & deployment.
- **Docker Image Optimization**:
  - Use **multi-stage builds** to reduce image size.
  - Regularly scan for vulnerabilities (e.g., **Trivy**).