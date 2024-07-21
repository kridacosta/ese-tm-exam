# main.tf
provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_instance" "cdc_capture" {
  name         = "cdc-capture"
  machine_type  = "e2-standard-2"
  zone          = var.zone
  can_ip_forward = false

  # Machine Image and Boot Disk
  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/debian-12-bookworm"
      disk_size_gb = 10
    }
    auto_delete = true
  }

  # Disk configuration
  attached_disk {
    device_name = "cdc-capture"
    source      = "projects/ese-exam-sandbox-acosta-h/zones/us-central1-c/disks/cdc-capture"
    mode        = "READ_WRITE"
    interface   = "SCSI"
    auto_delete = true
  }

  # Network Interface
  network_interface {
    network    = "projects/ese-exam-sandbox-acosta-h/global/networks/private-network"
    subnetwork = "projects/ese-exam-sandbox-acosta-h/regions/us-central1/subnetworks/private-network"
    network_ip = "10.128.0.4"

    access_config {
      # Public IP
      nat_ip = "35.184.115.93"
    }
  }

  # Metadata and SSH Keys
  metadata = {
    ssh-keys = "hendrickacosta1594:ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBOT4gUkTmkEaDdtlGmo+skDIF3F7STC8QC3l+KbSW9i3irr8gquvGMrOrkPe1iyGo/MDkDJ0NcNAyjBkpyR+tz0= google-ssh {\"userName\":\"hendrickacosta1594@gmail.com\",\"expireOn\":\"2024-07-21T15:00:15+0000\"}\nhendrickacosta1594:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAGetfQkoe4T9aifV48PJdJFJJLbJ0SwnDZFDdkJ3euTWMoL2LpwMKaFYghl+vNGBp2ryox4FEg84b95rW2ysFeKgxbZJs+8W7eHHz1pjANiaRH20Fs80/YWRgF5n+uTCvG3l2+F32FsWDsDhCHe23r9ZI6ifRGJQrPYW4KbSYYcbWxaRRbo0luXhyx1m3rWsAhF42MBNvHG4pBJxaofXvFZoo463WMjn26dUo0d5hFAV5rApKUPS9XKCdvagWOOPxF6cEaKumxAp/f4/CkE8475rt/dLUxWY72K5bxM7xWOfIaEUmH4EuzKM3ThqpAxB7g1qnlqCyCQngLw7XNwzw/M= google-ssh {\"userName\":\"hendrickacosta1594@gmail.com\",\"expireOn\":\"2024-07-21T15:00:33+0000\"}"
  }

  # Service Account
  service_account {
    email  = "817310057512-compute@developer.gserviceaccount.com"
    scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append"
    ]
  }

  # Shielded VM Configuration
  shielded_instance_config {
    enable_secure_boot             = false
    enable_vtpm                    = true
    enable_integrity_monitoring    = true
  }

  # Scheduling Configuration
  scheduling {
    on_host_maintenance = "MIGRATE"
    automatic_restart   = true
    preemptible         = false
  }

  # Tags
  tags = ["http-server", "https-server"]

  # CPU Platform
  cpu_platform = "Intel Broadwell"

  # Confidential Compute Config
  confidential_instance_config {
    enable_confidential_compute = false
  }

  # Reservation Affinity
  reservation_affinity {
    consume_reservation_type = "ANY_RESERVATION"
  }

  # Labels (optional)
  labels = {
    environment = "production"
  }

  # Additional configuration
  metadata = {
    startup-script = file("startup-script.sh")
  }
}

output "instance_name" {
  value = google_compute_instance.cdc_capture.name
}

output "instance_self_link" {
  value = google_compute_instance.cdc_capture.self_link
}
