To set up your Terraform project for "Smartcookie" on AWS infrastructure, here's a directory and file structure that follows Terraform best practices:

### Suggested Directory Structure:
```bash
smartcookie-terraform/
├── modules/
│   └── ec2/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── envs/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── backend.tf
│   │   ├── provider.tf
│   │   ├── variables.tf
│   │   └── terraform.tfvars
│   └── prod/
│       ├── main.tf
│       ├── backend.tf
│       ├── provider.tf
│       ├── variables.tf
│       └── terraform.tfvars
├── scripts/
│   └── init.sh
└── README.md
```

### Bash Script to Build the Terraform Directory Structure:

```bash
#!/bin/bash

# Define the root directory name
ROOT_DIR="smartcookie-terraform"

# Create the directory structure
mkdir -p $ROOT_DIR/{modules/ec2,envs/{dev,prod},scripts}

# Create main.tf, variables.tf, outputs.tf in modules/ec2
touch $ROOT_DIR/modules/ec2/{main.tf,variables.tf,outputs.tf}

# Create main.tf, backend.tf, provider.tf, variables.tf, terraform.tfvars in envs/dev and envs/prod
for env in dev prod; do
    touch $ROOT_DIR/envs/$env/{main.tf,backend.tf,provider.tf,variables.tf,terraform.tfvars}
done

# Create an init script for initialization
cat <<EOL > $ROOT_DIR/scripts/init.sh
#!/bin/bash
# Terraform initialization script
terraform init
EOL
chmod +x $ROOT_DIR/scripts/init.sh

# Create a README file
cat <<EOL > $ROOT_DIR/README.md
# Smartcookie Terraform Project

## Directory Structure
- **modules/**: Contains reusable modules for different services.
- **envs/**: Environment-specific configuration for 'dev' and 'prod'.
- **scripts/**: Useful scripts such as initialization.

## How to Use
1. Navigate to the environment directory:
   \`\`\`
   cd envs/dev
   \`\`\`
2. Run Terraform commands:
   \`\`\`
   terraform init
   terraform apply
   \`\`\`
EOL

echo "Terraform project structure created successfully."
```

### How to Use the Script:
1. Save the script to a file, e.g., `setup_terraform.sh`.
2. Give it execute permissions: `chmod +x setup_terraform.sh`.
3. Run the script: `./setup_terraform.sh`.

This will create the necessary directory structure for your Terraform project on AWS. Let me know if you'd like any adjustments!
