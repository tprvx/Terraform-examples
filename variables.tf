variable "my_token" {
    type        = string
    description = "Terraform token"
    default       = ""
    # пометка что это secure переменная
    sensitive = true
}