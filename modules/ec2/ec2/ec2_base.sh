#!/bin/bash
export AWS_ACCESS_KEY_ID=${access_key}
export AWS_SECRET_ACCESS_KEY=${secret_key}

sudo -u ec2-user -i <<'EOF'
cd /home/ec2-user

sudo yum update -y

while sudo yum install cronie nc jq htop -y; [[ $? -ne 0 ]];
do
    echo "<base> Will retry in 5 seconds. $(date)"
    sleep 5
done

while sudo yum groupinstall -y "Development tools"; [[ $? -ne 0 ]]
do
    echo "Retrying Development tools installation..."
    sleep 5
done

sudo yum install -y yum-utils

sudo sysctl -w vm.max_map_count=800000
sudo sh -c "echo "vm.max_map_count=800000" >> /etc/sysctl.conf"
sudo sh -c "echo "* soft nofile 800000" >> /etc/security/limits.conf"
sudo sh -c "echo "* hard nofile 800000" >> /etc/security/limits.conf"
sudo sysctl -p

sudo ./aws/install --bin-dir /usr/bin --install-dir /usr/local/aws-cli --update
unzip awscliv2.zip

aws configure set aws_access_key_id ${access_key}
aws configure set aws_secret_access_key ${secret_key}
aws configure set aws_region ${region}

echo "export AWS_ACCESS_KEY_ID=${access_key}" >> /home/ec2-user/.bashrc
echo "export AWS_SECRET_ACCESS_KEY=${secret_key}" >> /home/ec2-user/.bashrc

source /home/ec2-user/.bashrc
EOF

# END OF BASE EC2 USER DATA
