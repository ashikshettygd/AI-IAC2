module "module_main_20251031_070908" {
  source = "./modules/module_main"

  lambda_function_name = var.lambda_function_name
  iam_role_name        = var.iam_role_name
}
