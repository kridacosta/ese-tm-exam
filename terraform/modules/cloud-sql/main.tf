provider "google-beta" {
  project = "ese-exam-sandbox-acosta-h"
  region  = "us-central1"
  credentials = "/Users/hendrickacosta/Downloads/ese-exam-sandbox-acosta-h-b111477628ec.json"
}

resource "google_compute_network" "private_network" {
  provider = google-beta

  name = "private-network"
}

resource "google_compute_global_address" "private_ip_address" {
  provider = google-beta

  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.private_network.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider = google-beta

  network                 = google_compute_network.private_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "google_sql_database_instance" "default" {
  provider = google-beta
  name             = var.instance_name
  database_version = "POSTGRES_13"
  region           = var.region

  settings {
    tier = "db-f1-micro"
    
    backup_configuration {
      enabled = true
    }

    ip_configuration {
      ipv4_enabled                                  = false
      private_network                               = google_compute_network.private_network.id
      enable_private_path_for_google_cloud_services = true
    }

    database_flags {
      name  = "cloudsql.logical_decoding"
      value = "on"
    }

    user_labels = {
      environment = "dev"
    }
  }
}

resource "google_sql_database" "default" {
  name     = var.database_name
  instance = google_sql_database_instance.default.name
}

resource "google_sql_user" "default" {
  name     = var.database_user
  instance = google_sql_database_instance.default.name
  password = var.database_password
}

# resource "null_resource" "setup_replication" {
#   provisioner "local-exec" {
#     command = <<EOT
#       gcloud sql connect ${google_sql_database_instance.default.name} --user=${var.database_user} --quiet <<EOF
#       CREATE PUBLICATION ${var.publication_name} FOR ALL TABLES;
#       ALTER SYSTEM SET wal_level = logical;
#       ALTER SYSTEM SET max_replication_slots = 10;
#       ALTER SYSTEM SET max_wal_senders = 10;
#       SELECT pg_reload_conf();
#       EOF
#     EOT
#     environment = {
#       GOOGLE_APPLICATION_CREDENTIALS = var.credentials_file
#     }
#   }

#   depends_on = [google_sql_database_instance.default]
# }
