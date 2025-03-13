terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}



resource "github_repository" "terraform-example-yidgar" {
  name = "terraform-example"
  description = "My repo"
  visibility = "public"
}

# We can use this to create a repository for a group using a pipeline , with specific name and type (i.e docker repository)
# and then copy to it files from template - this is for a request by user.


