#!/usr/bin/env bash
ansible-playbook service-register.yml  --extra-vars "host="$1  --extra-vars "@vars/test/nginx-config.json"