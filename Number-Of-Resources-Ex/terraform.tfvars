// This file is used for initializing varibale not for declearation of variable, variable.tf file can be used for defining of variable.
// This file varibales have highest priority then i/p or default variables
vpc_cidr_ranges = ["10.40.0.0/24","10.50.0.0/24","10.60.0.0/24"]  //Initializing multiple value
vpc_instance_tenancy = "default"
