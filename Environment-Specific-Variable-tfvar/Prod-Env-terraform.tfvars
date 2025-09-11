// This file is used for initializing varibale not for declearation of variable, variable.tf file can be used for defining of variable.
// This file varibales have highest priority then i/p or default variables
vpc_cidr             = "10.40.0.0/24"
vpc_instance_tenancy = "default"
subnet_cidr          = "10.40.0.0/25"
subnet_az            = "ap-south-1b"

// Bydefault variable value considered from terraform.tfvar file 1st,
// And If while executing the commands, if we are passing the variable file like below ex.

// terraform plan or apply -var-file="Prod-Env-terraform.tfvars"

//then varable value consider from "Prod-Env-terraform.tfvar" instead of any other variable value.