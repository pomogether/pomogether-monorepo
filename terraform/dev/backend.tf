terraform {
  backend "remote" {
    organization = "pomogether"

    workspaces {
      name = "dev"
    }
  }
}
