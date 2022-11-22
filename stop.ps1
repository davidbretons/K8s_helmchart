# run.ps1

terraform destroy -var-file .\global-variables.tfvars -auto-approve
#Stop-Job Hextris-PortFwd
