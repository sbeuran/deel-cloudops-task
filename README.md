### To provision the infrastructure

1. Navigate to the terraform directory:
```bash
cd terraform
```

2. Update the `tfvars/default.tfvars` as necessary
3. Provision the infrastructure:
```bash
terraform apply -var-file="tfvars/default.tfvars" --auto-approve
```
4. To destroy it:
```bash
terraform destroy -var-file="tfvars/default.tfvars" --auto-approve
```

### How the custom image was built for the secondary task

1. The code dir is `custom-http-server`
2. The server's code is in `main.py`
3. The `Dockerfile` contains the docker image config
4. To build the image:
```bash
docker build -t sbeuran/custom-simple-http-server .
```
5. To push it to the remote repo in dockerhub:
```bash
docker push sbeuran/custom-simple-http-server
```