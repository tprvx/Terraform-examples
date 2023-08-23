# какое API используем
terraform {
    required_providers {
        yandex = {
            source = "yandex-cloud/yandex"
        }
    }
    required_version = ">= 0.13"
}

# локальные переменные
locals {
    zone = "ru-central1-a"
}

# авторизация пользователя
provider "yandex" {
    token     = var.my_token
    cloud_id  = "b1g0b0v6u6g4ujsqt2k3"
    folder_id = "b1g7o5gbu8auje7uj2le"
    zone      = local.zone
}


# описание создаваемых ресурсов

resource "yandex_compute_instance" "vm-1" {

    name        = "vm-1"
    platform_id = "standard-v2"
    zone        = local.zone

    resources {
        core_fraction = 5
        cores         = 2
        memory        = 2
    }

    boot_disk {
        initialize_params {
            # debian 11
            image_id = "fd8gqjo661d83tv5dnv4"
            size     = 10
        }
    }

    network_interface {
        subnet_id = yandex_vpc_subnet.subnet-1.id
        nat       = true
    }

    scheduling_policy {
        # прерываемая
        preemptible = false
    }

    metadata = {
        user-data = "${file("./meta.yaml")}"
    }
}

resource "yandex_compute_instance" "vm-2" {
    name        = "vm-2"
    platform_id = "standard-v2"
    zone        = local.zone

    resources {
        core_fraction = 5
        cores         = 4
        memory        = 4
    }

    boot_disk {
        initialize_params {
            # CentOS
            image_id = "fd8b88l2b5mnj352lkdk"
            size     = 10
        }
    }

    network_interface {
        subnet_id = yandex_vpc_subnet.subnet-1.id
        nat       = true
    }

    scheduling_policy {
        # прерываемая
        preemptible = false
    }

    metadata = {
        user-data = "${file("./meta.yaml")}"
    }
}


resource "yandex_vpc_network" "network-1" {
    name = "network-1"
}

resource "yandex_vpc_subnet" "subnet-1" {
    name = "subnet1"
    zone = local.zone
    v4_cidr_blocks = ["192.168.10.0/24"]
    network_id = yandex_vpc_network.network-1.id
}

# выходные переменные после создания ресурсов
output "internal_ip_address_vm_1" {
    value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}
output "internal_ip_address_vm_2" {
    value = yandex_compute_instance.vm-2.network_interface.0.nat_ip_address
}