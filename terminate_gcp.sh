#!/bin/bash

INSTANCE_NAME="flask-instance"
ZONE="us-central1-a"
PROJECT="assignment-3-vcc"

echo "Stopping and deleting GCP instance..."
gcloud compute instances delete $INSTANCE_NAME --zone $ZONE --project $PROJECT --quiet

echo "GCP instance $INSTANCE_NAME terminated."
