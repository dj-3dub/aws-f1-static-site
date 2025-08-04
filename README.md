## 🚀 Deployment Workflow

1. **Ubuntu VM Setup**  
   Created a dedicated VM (`ubuntu-aws`) with static IP `192.168.2.44` (Hamilton tribute ✨)

2. **SSH Key Integration**  
   Connected from Windows via `ssh ubuntu-aws` using secure key-based login

3. **Terraform Init & Apply**  
   Provisioned AWS S3 bucket and uploaded a custom F1-themed website

4. **Version Control**  
   Clean repo pushed to [GitHub](https://github.com/dj-3dub/aws-f1-static-site), excluding Terraform state and cache files

## 🛡️ Security

- IAM user with scoped-down permissions used for Terraform
- `.terraform/` and `.tfstate` files excluded via `.gitignore`

## 🔗 Live Website

🌐 [f1-homelab-site-49c3df1f.s3-website-us-east-1.amazonaws.com](http://f1-homelab-site-49c3df1f.s3-website-us-east-1.amazonaws.com/)

## 🎯 Next Goals

- [ ] Add **CloudFront** CDN
- [ ] Enable **Route 53** custom domain (`f1.djhomelab.com`)
- [ ] Set up **GitHub Actions** for CI/CD deployments
- [ ] Monitor access logs via **CloudWatch**

---

## 🙌 Why This Matters

This project isn't just a tech demo — it's a personal reflection of my passion for Formula 1 and cloud engineering. It's also part of my journey toward becoming a **Solutions Architect** or **DevOps/Infrastructure Engineer**, backed by hands-on AWS and Terraform experience.
