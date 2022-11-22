
# Synopsis

This project is an example on how to deploy an app using Helm Charts in a Kubernetes Cluster (KinD) using ingress-nginx as a reverse proxy. We use Terraform to automate the deployment.

For this project we would create a docker image for Hextris using Apache httpd.

**Default sources for the content used in this project**

Hextris Game:\
https://github.com/Hextris/hextris


# Results from execution

The creation of a local Kubernetes cluster that will allow you to access a service of Hextris over localhost. 

# Prerequisites

* terraform [Installation](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)\
`terraform -version`
* kind [Installation](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)\
`kind --version`
* docker [Installation](https://docs.docker.com/get-docker/)\
`docker --version`
* helm [Installation](https://helm.sh/docs/intro/install/)\
`helm`
* kubectl [Installation](https://kubernetes.io/docs/tasks/tools/#kubectl)\
`kubectl`
* git [Installation](https://git-scm.com/downloads)
`git -v`

# Procedure

Review `global-variables.tfvars` file if you want to modify any predefined value.

We will first create the docker image that will be used in the project

1) Stand on the Path you want to have this project saves and use git to clone this repository:
`git clone https://github.com/davidbretons/K8s_helmchart`

2) Change path to the directory
`cd K8s_helmchart`

3) Now lets clone Hextris repository
`git clone https://github.com/Hextris/hextris`

4) Now lets create the docker image, for this exercise we will call it 'example/hextris'. This will use the Dockerfile.
`docker build -t example/hextris .`

5) Confirm the image was created using
`docker images`

6) Now lets initiate Terraform in this project by running the following command:
`terraform init`

7) Now lets create the cluster using terraform
`terraform apply -var-file .\global-variables.tfvars -auto-approve`

You can review the status of the cluster by using the following command
`kubectl get all -A`

8) Use Helm to install the Helm Chart. 
`helm install hextris-chart .\hextris-chart\ --values .\hextris-chart\values.yaml`

9) Declare a port portwarding to be able to open the game in localhost
`kubectl port-forward --namespace default service/hextris-chart 80:80`

10) On a browser navigate to the following url to open the game
`http://localhost`

11) Once completed. To destroy the cluster execute the following command:
`terraform destroy -var-file .\global-variables.tfvars -auto-approve`

## On Windows

A powershell script has been provided to facilitate the creation of the project. 

Content of the Powershell script:

```
# run.ps1

terraform apply -var-file .\global-variables.tfvars -auto-approve

Start-Sleep 10
Write-Output "Waiting for the echo web server service..."
helm install hextris-chart .\hextris-chart\ --values .\hextris-chart\values.yaml
Write-Output "Waiting for pods to start..."
Start-Sleep 20
Write-Output "Executing command: kubectl port-forward --namespace default service/hextris-chart 80:80"
kubectl port-forward --namespace default service/hextris-chart 80:80
Write-Output "Execution Completed."
```

Execute: \
`.\run.ps1`

Wait for the execution to complete. This might take time depending on your machine and if its the first time you execute the script. Once completed the script you can verify the state of the cluster with the followin command:\

`kubectl get all -A`

Make sure all pods have a Running state to ensure the expected output.

Once you are sure the cluster was properly created and running, open a browser window and type:\

`http://localhost`

You should be able to see a new session of Hextris game. Have fun!

Once you are done playing, destroy the cluster by executing:\
`.\stop.ps1`


# Known problems and limitations

* It is recommended to open a new private window on your broser to prevent any previous execution to be cached.


# Examples

# Support

**Author Information**

David Breton - Solution Architect

## License
