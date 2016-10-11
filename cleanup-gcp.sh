#!/bin/bash

set -e
gcloud config set project $GCLOUD_PROJECT

#delete forwarding rules
for i in $(gcloud compute forwarding-rules list | awk 'NR>1 {print $1}'); do
	gcloud compute forwarding-rules delete -q $i --region "us-central1";
done

#delete target pools
for i in $(gcloud compute target-pools list | awk 'NR>1 {print $1}'); do
	gcloud compute target-pools delete -q $i --region "us-central1";
done

#delete static address
for i in $(gcloud compute addresses list | awk 'NR>1 {print $1}'); do
	gcloud compute addresses delete -q $i --region "us-central1";
done

#delete VMs
for k in us-central1-a us-central1-b us-central1-c; do
 for i in $(gcloud compute instances list --zones $k| awk 'NR>1 {print $1}'); do
gcloud compute instances delete $i -q --zone "$k";
 done;
done	


#delete disks
for k in us-central1-a us-central1-b us-central1-c; do
 for i in $(gcloud compute disks list --zones $k | awk 'NR>1 {print $1}'); do
gcloud compute disks delete -q $i --zone $k;
 done;
done