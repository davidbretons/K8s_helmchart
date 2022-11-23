# run.ps1

terraform apply -var-file .\global-variables.tfvars -auto-approve

Start-Sleep 10
kind load docker-image hextris:0.1.0 --name cluster-local
Write-Output "Waiting for the echo web server service..."
helm install hextris-chart .\hextris-chart
Write-Output "Waiting for pods to start..."
Start-Sleep 20
Write-Output "Executing command: kubectl port-forward --namespace default service/hextris-chart 80:80"
kubectl port-forward --namespace default service/hextris-chart 80:80
Write-Output "Execution Completed."