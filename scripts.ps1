# Create docker image
docker build -t dio-blog-app:latest .

# Start the container locally to confirm it is working
docker run -d -p 8088:80 dio-blog-app:latest


# Azure
az login

# Create a resource group
az group create --name dio-cloud-native-lab003 --location eastus

# Create Container Registry
az acr create --resource-group dio-cloud-native-lab003 --name diocloudnativearlb02 -sku Basic

# Login to ACR
az acr login --name diocloudnativearlb02

# Tag the image
docker tag dio-blog-app:latest diocloudnativearlb02.azurecr.io/dio-blog-app:latest

# Login to the ACR
 # username = diocloudnativearlb02
 # password = rAe*****************************************XQ
docker login diocloudnativearlb02.azurecr.io

# Push the image
docker push diocloudnativearlb02.azurecr.io/dio-blog-app:latest

 # containerID = diocloudnativearlb02.azurecr.io/dioazure-landpet:latest
 # username = diocloudnativearlb02
 # password = rAe*****************************************XQ

 # Create Environment container app
az containerapp env create `
    --name dio-blog-env-lab3 `
    --resource-group dio-cloud-native-lab003 `
    --location eastus `
    --image diocloudnativearlb02.azurecr.io/dio-blog-app

# Create Container App
az containerapp create `
    --name dio-blog-lab3 `
    --resource-group dio-cloud-native-lab003 `
    --image diocloudnativearlb02.azurecr.io/dio-blog-app `
    --target-port 8088 `
    --ingress external `
    --registry-username diocloudnativearlb02 `
    --registry-password rAe*****************************************XQ `
    --registry-server diocloudnativearlb02.azurecr.io
