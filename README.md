# Terraform-examples

## Install Terraform

```
wget https://hashicorp-releases.yandexcloud.net/terraform/1.5.5/terraform_1.5.5_linux_amd64.zip
zcat terraform_1.5.5_linux_amd64.zip >> terraform
chmod 744 terraform
rm terraform_1.5.5_linux_amd64.zip
sudo mv terraform /usr/local/bin/terraform

# get OAuth token yandex.cloud
https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token
```

## Usage

```
cp .terraformrc ~/
ssh-keygen
./id-rsa
cat id-rsa.pub

terraform init
terraform validate
terraform plan
terraform apply

ssh vmuser@<ip-vm> -i id-rsa

terraform destroy
```

## Terraform Ad-hoc

```
terraform fmt
terraform validate
terraform console
```
