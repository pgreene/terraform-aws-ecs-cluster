resource "aws_ecs_cluster" "general" {
  name = var.name
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
  dynamic "configuration" {
    for_each = var.configuration ? [var.configuration] : []
    content {
      dynamic "execute_command_configuration" {
        for_each = try([configuration.value.execute_command_configuration], [])
        content {
          kms_key_id = try(execute_command_configuration.value.kms_key_id, null)
          logging = try(execute_command_configuration.value.logging, null)
          dynamic "log_configuration" {
            for_each = try([execute_command_configuration.value.log_configuration], [])
            content {
              cloud_watch_encryption_enabled = try(log_configuration.value.cloud_watch_encryption_enabled, null)
              cloud_watch_log_group_name = try(log_configuration.value.cloud_watch_log_group_name, null)
              s3_bucket_name = try(log_configuration.value.s3_bucket_name, null)
              s3_bucket_encryption_enabled = try(log_configuration.value.s3_bucket_encryption_enabled, null)
              s3_key_prefix = try(log_configuration.value.s3_key_prefix, null)
            }
          }
        }
      }
      dynamic "managed_storage_configuration" {
      for_each = try([configuration.value.managed_storage_configuration], [])
        content {
          fargate_ephemeral_storage_kms_key_id = try(managed_storage_configuration.value.fargate_ephemeral_storage_kms_key_id, null)
          kms_key_id = try(managed_storage_configuration.value.kms_key_id, null)
        }
      }
    }
  }
  tags = var.tags
}