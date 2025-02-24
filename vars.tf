variable "name" {
  description = "(Required) The name of the cluster (up to 255 letters, numbers, hyphens, and underscores)"
  default = ""
}

variable "capacity_providers" {
  description = "(Optional) List of short names of one or more capacity providers to associate with the cluster. Valid values also include FARGATE and FARGATE_SPOT."
  default = null
}

variable "default_capacity_provider_strategy" {
  description = "(Optional) The capacity provider strategy to use by default for the cluster. Can be one or more. Defined below."
  default = null
}

variable "setting" {
  description = "(Optional) Configuration block(s) with cluster settings. For example, this can be used to enable CloudWatch Container Insights for a cluster. Defined below."
  default = null
}

variable "configuration" {
  description = "(Optional) Configuration block."
  default = false
}

variable "tags" {
  default = {}
}