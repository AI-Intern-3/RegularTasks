
# DevOps Project - The Ultimate CICD Corporate DevOps Pipeline Project

## #devops
## #cicd
## #jenkins
## #kubernetes

### Introduction

In today's fast-paced development environment, continuous integration and continuous delivery (CI/CD) are essential practices for delivering high-quality software rapidly and reliably. In this project, we will walk through setting up a robust CI/CD pipeline from scratch, utilizing industry-standard tools like Jenkins, Docker, Trivy, SonarQube, and Nexus. This guide is designed for developers and DevOps enthusiasts who want to automate the process of building, testing, and deploying applications in a scalable and secure manner.

We will begin by setting up the necessary infrastructure on AWS, followed by the installation and configuration of Docker, Jenkins, Trivy, Nexus, and SonarQube. Finally, we will create a Jenkins pipeline that automates the entire CI/CD process, ensuring your applications are continuously built, scanned for vulnerabilities, analyzed for code quality, and deployed with minimal manual intervention.

Let’s dive in and transform your software delivery process with this powerful CI/CD setup.

---

### PHASE 1: INFRASTRUCTURE SETUP 🛠️

#### 1. Creating 3 Ubuntu 24.04 VM Instances on AWS 🌐

**Sign in to the AWS Management Console:**

- Go to AWS Management Console.
- Sign in with your AWS account credentials.

**Navigate to EC2:**

- Type "EC2" in the search bar or select "Services" > "EC2" under the "Compute" section.

**Launch Instance:**

- Click "Instances" in the EC2 dashboard sidebar.
- Click the "Launch Instance" button.

**Choose an Amazon Machine Image (AMI):**

- Select "Ubuntu" from the list of available AMIs.
- Choose "Ubuntu Server 24.04 LTS".
- Click "Select".

**Choose an Instance Type:**

- Select an instance type (e.g., t2.micro for testing).
- Click "Next: Configure Instance Details".

**Configure Instance Details:**

- Configure optional settings or leave them as default.
- Click "Next: Add Storage".

**Add Storage:**

- Specify the root volume size (default is usually fine).
- Click "Next: Add Tags".

**Add Tags:**

- Optionally, add tags for better organization.
- Click "Next: Configure Security Group".

**Configure Security Group:**

- Allow SSH access (port 22) from your IP address.
- Optionally, allow other ports (e.g., HTTP port 80, HTTPS port 443).
- Click "Review and Launch".

**Review and Launch:**

- Review the instance configuration.
- Click "Launch".

**Select Key Pair:**

- Select an existing key pair or create a new one.
- Check the acknowledgment box.
- Click "Launch Instances".

**Access Your Instance:**

Use an SSH client like MobaXterm:
- Open MobaXterm and click "Session" > "SSH".
- Enter the public IP address of your instance.
- Select "Specify username" and enter "ubuntu".
- Under "Advanced SSH settings", select "Use private key" and browse to your key pair file (.pem).
- Click "OK" to connect.

#### 2. Install Docker on All 3 VMs 🐳

**Step-by-Step Installation:**

Install prerequisite packages:

```bash
sudo apt-get update
sudo apt-get install ca-certificates curl
```

Download and add Docker's official GPG key:

```bash
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
```

Add Docker repository to Apt sources:

```bash
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

Update package index:

```bash
sudo apt-get update
```

Install Docker packages:

```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
```

Grant permission to Docker socket (optional, for convenience):

```bash
sudo chmod 666 /var/run/docker.sock
```

By following these steps, you should have successfully installed Docker on your Ubuntu system. You can now start using Docker to containerize and manage your applications.

---

### Setting Up Jenkins on Ubuntu 🔧

**Step-by-Step Installation:**

Update the system:

```bash
sudo apt-get update
sudo apt-get upgrade -y
```

Install Java (Jenkins requires Java):

```bash
sudo apt install -y fontconfig openjdk-17-jre
```

Add Jenkins repository key:

```bash
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
```

Add Jenkins repository:

```bash
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
```

Update the package index:

```bash
sudo apt-get update
```

Install Jenkins:

```bash
sudo apt-get install -y jenkins
```

Start and enable Jenkins:

```bash
sudo systemctl start jenkins
sudo systemctl enable jenkins
```

**Access Jenkins:**

Open a web browser and go to `http://your_server_ip_or_domain:8080`.  
You will see a page asking for the initial admin password. Retrieve it using:

```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

- Enter the password, install suggested plugins, and create your first admin user.

---

### Installing Trivy on Jenkins Server 🔍

**Step-by-Step Installation:**

Install prerequisite packages:

```bash
sudo apt-get install wget apt-transport-https gnupg lsb-release
```

Add Trivy repository key:

```bash
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
```

Add Trivy repository to sources:

```bash
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
```

Update package index:

```bash
sudo apt-get update
```

Install Trivy:

```bash
sudo apt-get install trivy
```

---

### Setting Up Nexus Repository Manager Using Docker 📦

**Step-by-Step Installation:**

Pull the Nexus Docker image:

```bash
sudo docker pull sonatype/nexus3
```

Run the Nexus container:

```bash
sudo docker run -d -p 8081:8081 --name nexus -v nexus-data:/nexus-data sonatype/nexus3
```

**Access Nexus:**

Open a web browser and go to `http://your_server_ip_or_domain:8081`.  
The default username is `admin`. Retrieve the initial admin password from the log:

```bash
sudo docker logs nexus 2>&1 | grep -i password
```

- Complete the setup wizard.

---

### Setting Up SonarQube Using Docker 📈

**Step-by-Step Installation:**

Create a network for SonarQube and PostgreSQL:

```bash
sudo docker network create sonarnet
```

Run PostgreSQL container:

```bash
sudo docker run -d --name sonarqube_db --network sonarnet -e POSTGRES_USER=sonar -e POSTGRES_PASSWORD=sonar -e POSTGRES_DB=sonarqube -v postgresql:/var/lib/postgresql -v postgresql_data:/var/lib/postgresql/data postgres:latest
```

Run SonarQube container:

```bash
sudo docker run -d --name sonarqube --network sonarnet -p 9000:9000 -e sonar.jdbc.url=jdbc:postgresql://sonarqube_db:5432/sonarqube -e sonar.jdbc.username=sonar -e sonar.jdbc.password=sonar -v sonarqube_data:/opt/sonarqube/data -v sonarqube_extensions:/opt/sonarqube/extensions sonarqube:latest
```

**Access SonarQube:**

Open a web browser and go to `http://your_server_ip_or_domain:9000`.  
The default login is `admin` with the password `admin`.  
Complete the setup by configuring the SonarQube server.

---

### Setting Up a Jenkins Pipeline to Automate CI/CD Process 🚀

**Step-by-Step Pipeline Setup:**

**Create a New Pipeline Job:**

- In Jenkins, click on "New Item" and select "Pipeline".
- Name the pipeline and click "OK".

**Configure the Pipeline:**

- Scroll down to the "Pipeline" section.
- Select "Pipeline script" and define your pipeline stages using Groovy.

**Sample Pipeline Script:**

```groovy
pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/your-repo.git'
            }
        }
        stage('Build with Maven') {
            steps {
                sh 'mvn clean install'
            }
        }
        stage('Docker Build and Push') {
            steps {
                script {
                    docker.build("your-app:latest").push("your-docker-repo/your-app:latest")
               

 }
            }
        }
        stage('Trivy Security Scan') {
            steps {
                sh 'trivy image your-docker-repo/your-app:latest'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn sonar:sonar'
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    kubernetesDeploy(
                        configs: 'k8s/deployment.yaml',
                        kubeConfig: 'path/to/kubeconfig'
                    )
                }
            }
        }
    }
}
```

---

This project equips you with a production-ready CI/CD pipeline, ensuring your application is continuously built, tested, and deployed in an efficient and automated manner. With tools like Docker, Jenkins, Trivy, Nexus, and SonarQube, your pipeline will not only streamline deployments but also enhance the security and quality of your codebase.

---
### PHASE 2: SETTING UP KUBERNETES CLUSTER 🌍

#### 1. Install Kubernetes on All 3 VM Instances 🖥️

First, SSH into each VM and follow the steps below to install Kubernetes:

**Update your system:**

```bash
sudo apt-get update && sudo apt-get upgrade -y
```

**Install prerequisite packages:**

```bash
sudo apt-get install -y apt-transport-https ca-certificates curl
```

**Add Kubernetes signing key:**

```bash
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
```

**Add Kubernetes repository:**

```bash
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
```

**Install Kubernetes components:**

```bash
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
```

**Disable swap:**

```bash
sudo swapoff -a
```

Now you have Kubernetes installed on all VMs.

---

#### 2. Initialize Kubernetes Cluster on the Master Node 🚀

Choose one of the VMs to be the master node. SSH into that VM.

**Initialize the cluster:**

```bash
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
```

After initialization, you will receive a command to join the worker nodes to the master. Save this token.

**Set up kubeconfig for the master:**

```bash
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

---

#### 3. Join Worker Nodes to the Cluster 🔗

SSH into the other two VMs (worker nodes), and run the token command you received after initializing the master node, like this:

```bash
sudo kubeadm join <MASTER_IP>:6443 --token <TOKEN> --discovery-token-ca-cert-hash <HASH>
```

This will connect the worker nodes to the master node, forming the Kubernetes cluster.

---

#### 4. Install a Pod Network (Flannel) 🕸️

On the master node, run the following command to install Flannel, a pod network required for the nodes to communicate:

```bash
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```

Now, your Kubernetes cluster is ready with the master and worker nodes successfully connected.

---

### PHASE 3: DEPLOYING APPLICATION TO KUBERNETES 🚀

#### 1. Prepare Kubernetes YAML Files 📝

Create a directory for your Kubernetes configuration files:

```bash
mkdir ~/k8s
cd ~/k8s
```

Create a `deployment.yaml` file:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: my-app
        image: your-docker-repo/your-app:latest
        ports:
        - containerPort: 8080
---
apiVersion: v1
kind: Service
metadata:
  name: my-app-service
spec:
  type: NodePort
  ports:
    - port: 8080
      targetPort: 8080
      nodePort: 30007
  selector:
    app: my-app
```

This file creates a deployment of 3 replicas of your Docker container and exposes the application on port 8080 via a Kubernetes service.

#### 2. Deploy to Kubernetes 🎯

**Apply the deployment:**

```bash
kubectl apply -f deployment.yaml
```

This will deploy your application to the Kubernetes cluster.

**Check the status of your pods:**

```bash
kubectl get pods
```

You should see the pods running, and your application will be accessible via the service.

---

### PHASE 4: SETTING UP A FULL CI/CD PIPELINE USING JENKINS WITH KUBERNETES ⚙️

#### 1. Configure Jenkins for Kubernetes Deployment 🌟

**Install Kubernetes Plugin in Jenkins:**

- Go to Jenkins dashboard.
- Navigate to "Manage Jenkins" > "Manage Plugins".
- Search for "Kubernetes" plugin and install it.

**Configure Kubernetes in Jenkins:**

- Go to "Manage Jenkins" > "Configure System".
- Scroll down to the "Cloud" section and add a new Kubernetes cloud.
- Enter the details of your Kubernetes cluster, such as the API server URL, credentials, and namespace.
- Configure Jenkins to use Kubernetes as a cloud agent.

#### 2. Update Jenkins Pipeline Script for Kubernetes Deployment 🌐

Modify the Jenkins pipeline script to include Kubernetes deployment steps:

```groovy
pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/your-repo.git'
            }
        }
        stage('Build with Maven') {
            steps {
                sh 'mvn clean install'
            }
        }
        stage('Docker Build and Push') {
            steps {
                script {
                    docker.build("your-app:latest").push("your-docker-repo/your-app:latest")
                }
            }
        }
        stage('Trivy Security Scan') {
            steps {
                sh 'trivy image your-docker-repo/your-app:latest'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn sonar:sonar'
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    kubernetesDeploy(
                        configs: 'k8s/deployment.yaml',
                        kubeConfig: 'path/to/kubeconfig'
                    )
                }
            }
        }
    }
}
```

This updated pipeline will deploy the application to your Kubernetes cluster after building, scanning, and analyzing the code.

---

### PHASE 5: MONITORING AND SCALING APPLICATION 📊

#### 1. Monitoring Your Kubernetes Cluster 🔍

To monitor the health and performance of your Kubernetes cluster, you can use tools like:

- **Prometheus**: For collecting metrics from your Kubernetes environment.
- **Grafana**: For visualizing those metrics.
- **Kubernetes Dashboard**: For a web UI to monitor your cluster.

#### 2. Scaling Applications in Kubernetes 📈

**Scale the deployment manually:**

```bash
kubectl scale deployment my-app --replicas=5
```

This command will scale your application to 5 replicas.

**Auto-scaling based on resource usage:**

```bash
kubectl autoscale deployment my-app --min=2 --max=10 --cpu-percent=80
```

This sets up horizontal pod autoscaling based on CPU usage.

---

### Conclusion 🎯

By following these steps, you will have a complete CI/CD pipeline that automatically builds, tests, secures, and deploys your application to a Kubernetes cluster. With Jenkins, Docker, Trivy, SonarQube, and Nexus integrated into the pipeline, you'll ensure high-quality, secure, and scalable software delivery.

This setup can be customized and extended to fit your organization's specific needs, enabling you to streamline your development and deployment processes.

---

With this pipeline, you're well on your way to mastering CI/CD and DevOps practices that will keep your applications running smoothly and securely in production environments.
