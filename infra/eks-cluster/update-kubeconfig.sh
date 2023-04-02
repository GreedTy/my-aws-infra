#!/bin/sh

aws eks --region $(terraform output -raw aws_region) update-kubeconfig --name $(terraform output -raw cluster_id)
