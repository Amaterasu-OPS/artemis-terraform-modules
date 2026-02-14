#!/bin/bash
echo "* soft nofile 800000" >> /etc/security/limits.conf
echo "* hard nofile 800000" >> /etc/security/limits.conf

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
sudo sh -c "echo "vm.max_map_count=800000" >> /etc/sysctl.conf
sudo sysctl -p

sudo yum install amazon-cloudwatch-agent -y

/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c ssm:/cloudwatch-agent/config/${cluster_name}/${cluster_type}/${cluster_instance_type}

source /home/ec2-user/.bashrc
EOF

# END OF BASE EC2 USER DATA
