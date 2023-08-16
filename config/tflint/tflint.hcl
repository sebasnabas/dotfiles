plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

plugin "azurerm" {
    enabled = true
    source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}
