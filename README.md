### To provision the infrastructure

1. Navigate to the terraform directory:
```bash
cd terraform
```
2. Install modules and dependencies:
```bash
terraform init
```
3. Update the `tfvars/default.tfvars` as necessary
4. Provision the infrastructure:
```bash
terraform apply -var-file="tfvars/default.tfvars" --auto-approve
```
5. To destroy it:
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

# 

# Considerations

1. The task 2. Advanced Networking Configuration states that the custom http server needs to be behind NAT in private network, so I'd like to better understand the purpose of this service, eventhough it's still possible to use it in private VPC-only flows, it could've been a mistake in the task, since there are no more servers running in this net to test it from.
Adding it is not a problem, the purpose of it for this specific task is blurry.
2. There is still plenty of room for code optimization, like: many things still can be moved to variables, and structure itself can be improved, which would require more time now. But with enough time spent it could've been done right away.


# Verifying

Output of the terraform apply will provide you with output like this:
```bash
primary_ec2_public_ip = "3.124.209.97"
primary_task_ssh_private_key = <sensitive>
secondary_ec2_public_ip = "18.184.226.131"
secondary_task_ssh_private_key = <sensitive>
```
primary node's port is 80.
secondary node's port is 8080

you'll be able to access them with browser
