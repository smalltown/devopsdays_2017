# variables

variable "base_cidr_block" {}
variable "name" {}
variable "phase" {}

# outputs
output "id" { value = "${ aws_vpc.main.id }" }
output "primary_subnet_id" { value = "${ module.primary_subnet.subnet_id }" }
output "secondary_subnet_id" { value = "${ module.secondary_subnet.subnet_id }" }
output "tertiary_subnet_id" { value = "${ module.tertiary_subnet.subnet_id }" }
