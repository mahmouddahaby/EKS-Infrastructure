#!/bin/bash

# Wait for ec2 creation
sleep 120

# Moving to ansible dir
cd ../Ansible


# Apply ansible playbook
ansible-playbook configurations.yaml 