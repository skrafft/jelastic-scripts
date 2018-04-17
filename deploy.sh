#!/bin/sh
echo "Deploying $JELASTIC_ENV_NAME on $JELASTIC_URL"
while [ $(curl -s "$JELASTIC_URL/1.0/environment/tracking/rest/getcurrentactions?session=$JELASTIC_TOKEN" | grep "\"env\":\"$JELASTIC_ENV_NAME\"" | wc -l) = "1" ]
do
  echo "Update already running, waiting 60 seconds"
  sleep 60
done

echo "Updating now..."
curl -X POST "$JELASTIC_URL/1.0/environment/control/rest/redeploycontainersbygroup" -d "envName=$JELASTIC_ENV_NAME&session=$JELASTIC_TOKEN&delay=$JELASTIC_DELAY&tag=$JELASTIC_TAG&nodeGroup=$JELASTIC_NODE_GROUP&isSequential=$JELASTIC_SEQUENTIAL"
echo "Update successful"
