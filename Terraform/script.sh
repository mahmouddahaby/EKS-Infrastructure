#!/bin/bash

# Wait for ec2 creation
sleep 60

# Moving to ansible dir
cd ../Ansible


# Apply ansible playbook
ansible-playbook configurations.yaml 