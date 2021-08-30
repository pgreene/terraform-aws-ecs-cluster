resource "aws_ecs_cluster" "general" {
  name = var.name
  capacity_providers = var.capacity_providers
  dynamic "default_capacity_provider_strategy" {
    for_each = var.default_capacity_provider_strategy == null ? [] : [var.default_capacity_provider_strategy]
    content {
      capacity_provider = default_capacity_provider_strategy.value.capacity_provider
      weight = default_capacity_provider_strategy.value.weight
      base = default_capacity_provider_strategy.value.base
    }
  }
  dynamic "setting" {
    for_each = var.setting == null ? [] : [var.setting]
    content {
      name = setting.value.name
      value = setting.value.value
    }
  }
  tags = var.tags
}