provider "github" {
  token = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}
resource "github_repository" "terraform" {
  name        = "hw-git-terraform"
  description = "My hw with git terraform"
  auto_init   = true
  private     = false
}
resource "github_branch" "dev" {
  depends_on = [github_repository.terraform]
  repository = "hw-git-terraform"
  branch     = "dev"
}
resource "github_branch_protection" "terraform" {
  repository_id  = github_repository.terraform.node_id
  pattern     = "main"
  enforce_admins = true
}
resource "github_user_ssh_key" "hw-git-terraform" {
  title = "My PC"
  key   = "${file("C:/Users/user/.ssh/id_rsa.pub")}"
}