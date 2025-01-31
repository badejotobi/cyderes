# cyderes


## AUTH INTO GOOGLE FOR TERRAFORM 

- first initialize into google, set up your configuration
`gcloud init`

- login with your google cloud account 
`gcloud auth login`

- make sure your service account is set up from google console before next
  step, you can also check for setup of service account [here](https://cloud.google.com/iam/docs/service-accounts-create)

- attach storage admin role to your service account, if not already there
```
gcloud projects add-iam-policy-binding<PROJECT_NAME> \
    --member="serviceAccount:<YOUR_SERVICE_ACCOUNT_EMAIL>” \
    --role="roles/storage.admin" 
```
## SERVICE ACCOUNT JSON FILE FOR TERRAFORM SETUP

- make sure you in the teraform folder to set up the service account json file
```

gcloud iam service-accounts keys create service_account.json
--iam-account=<YOUR_SERVICE_ACCOUNT_EMAIL>

```
- verify you have your service_account.json in your terraform folder before
  next step

##RUN TERRAFORM
- Initialize terraform `terraform init`

- if you see an error such as 
```
Initializing the backend...
╷
│ Error: storage.NewClient() failed: dialing: google: could not find default credentials. See https://cloud.google.com/docs/authentication/external/set-up-adc for more information
│ 
│ 
╵
```
go to documentation [here](https://cloud.google.com/docs/authentication/set-up-adc-local-dev-environment) to set up your google application default credentials for your environment, then initailize terraform again

- Plan `terraform plan`
- Apply your resources `terraform apply` and enter yes or `terraform apply
  --auto-approve` to by-pass the yes 

## CLEANUP

- Make sure you still have your service_account.json before destroying
- Destroy your resoruces `terraform destroy` and enter yes or `terraform
  destroy --auto-approve` to by-pass the yes
