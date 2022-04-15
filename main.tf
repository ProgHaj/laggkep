provider "google" {
  project = "laggkep"
  region  = "europe-west1"
}

terraform {
  backend "gcs" {
    bucket = "laggkep-terraform"
  }
}

resource "google_cloudbuild_trigger" "alias" {
  name            = "deploy-alias"
  filename        = "src/functions/alias/cloudbuild.json"
  included_files  = ["src/functions/alias/**"]
  excluded_files  = ["src/functions/alias/readme.md"]
  service_account = var.service_account_email
  github {
    owner = "maakep"
    name  = "laggkep"
    push {
      branch = "^main$"
    }
  }
}


resource "google_cloudbuild_trigger" "result" {
  name            = "deploy-result"
  filename        = "src/functions/result/cloudbuild.json"
  included_files  = ["src/functions/result/**"]
  excluded_files  = ["src/functions/result/readme.md"]
  service_account = var.service_account_email
  github {
    owner = "maakep"
    name  = "laggkep"
    push {
      branch = "^main$"
    }
  }
}