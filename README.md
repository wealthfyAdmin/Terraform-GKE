# 🚀 GKE Autopilot Bootstrap with Terraform (Two-Stage Architecture)

## 📌 Overview

This repository demonstrates a **real-world, production-ready Terraform architecture** for:

- Provisioning a **GKE Autopilot cluster**
- Bootstrapping Kubernetes using **Terraform Kubernetes + Helm providers**
- Installing workloads using **Helm (OCI charts)**
- Maintaining **strict separation** between infrastructure and workloads

This pattern is used by **platform engineering teams** to ensure safety, scalability, and clean ownership boundaries.

---

## 🧱 Architecture at a Glance

```
┌────────────────────────────┐
│ Stage 1: GKE Infrastructure│
│ - Autopilot cluster        │
│ - Networking + maintenance │
└──────────────┬─────────────┘
               │ terraform_remote_state
               ▼
┌────────────────────────────┐
│ Stage 2: Bootstrap Layer   │
│ - Kubernetes provider      │
│ - Helm provider            │
│ - NGINX (example workload) │
└────────────────────────────┘
```

---

## 📂 Repository Structure

### Stage 1 – GKE Autopilot

```
gke-autopilot/
├── backend.tf
├── versions.tf
├── providers.tf
├── variables.tf
├── main.tf
└── outputs.tf
```

### Stage 2 – Helm Bootstrap

```
terraform-helm-nginx/
├── backend.tf
├── versions.tf
├── variables.tf
├── data.tf
├── providers.tf
├── namespace.tf
├── nginx-helm.tf
└── outputs.tf
```

---

## 🔐 Credentials & Authentication

Terraform connects to GCP using **Application Default Credentials (ADC)**.

### ✅ Recommended (Local Development & CI)

```bash
gcloud auth application-default login
```

This:
- Creates short-lived OAuth tokens
- Works with Terraform automatically
- Avoids storing sensitive files in the repo

---

### ⚠️ Alternative (Service Account Key – CI Only)

```bash
export GOOGLE_APPLICATION_CREDENTIALS="/absolute/path/to/key.json"
```

> ❗ Never commit service account keys to Git.

---

## ▶️ Execution Flow

### Step 1 – Create the GKE Autopilot Cluster

```bash
cd gke-autopilot
terraform init
terraform apply
```

### Step 2 – Bootstrap the Cluster with Helm

```bash
cd terraform-helm-nginx
terraform init
terraform apply
```

---

## 🗑 Safe Deletion Strategy

### ✅ Correct Deletion Order

```bash
cd terraform-helm-nginx
terraform destroy
```

```bash
cd gke-autopilot
terraform destroy
```

Destroying the cluster first will break provider connections.

---

## 📦 Deploying Other Helm Charts

This project can deploy **any Helm chart**.

### Example: cert-manager

```hcl
resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  namespace  = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "1.14.5"

  create_namespace = true

  values = [
    file("${path.module}/values/cert-manager.yaml")
  ]
}

```

### Example: Argo CD

```hcl
resource "helm_release" "sealed_secrets" {
  name       = "sealed-secrets"
  namespace  = "kube-system"
  repository = "https://bitnami-labs.github.io/sealed-secrets"
  chart      = "sealed-secrets"
  version    = "2.15.3"

  values = [
    file("${path.module}/values/sealed-secrets.yaml")
  ]
}

```

---

## 🔐 Security Best Practices

- No kubeconfig files
- OAuth-based authentication
- Least privilege IAM
- Autopilot-enforced security defaults

---

## 🧠 Key Takeaways

- Separate infrastructure and workloads
- Use terraform_remote_state for clean dependencies
- Always destroy in the correct order
- Autopilot bills only for pod resources

---

## 🏁 Final Thought

Infrastructure should be **stable and boring**.
Applications should be **fast and flexible**.
