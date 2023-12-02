variable "region" {
    default = "us-east-1"
}

variable "list-string" {
    type = list()
    default = 
}


variable "map-string" {
    type = list("ngochung1", "ngochung2","ngochung3")
}