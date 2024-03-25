# Input variable definitions

# Required variables

variable "endpoint_type" {
  description = "The endpoint or template type. Must be one of `queue`, `topic_endpoint`, `queue_template` or `topic_endpoint_template`."
  type        = string
  validation {
    condition     = contains(["queue", "topic_endpoint", "queue_template", "topic_endpoint_template"], var.endpoint_type)
    error_message = "The endpoint_type must be one of `queue`, `topic_endpoint`, `queue_template` or `topic_endpoint_template`."
  }
}

variable "msg_vpn_name" {
  description = "The name of the Message VPN"
  type        = string
}

variable "endpoint_name" {
  description = "The name of the endpoint or template"
  type        = string
}

variable "permission" {
  description = "The permission level for all consumers of the endpoint, excluding the owner. The allowed values and their meaning are: `no-access` - Disallows all access. `read-only` - Read-only access to the messages. `consume` - Consume (read and remove) messages. `modify-topic` - Consume messages or modify the topic/selector. `delete` - Consume messages, modify the topic/selector or delete the Client created endpoint altogether."
  type        = string
  validation {
    condition     = contains(["no-access", "read-only", "consume", "modify-topic", "delete"], var.permission)
    error_message = "Permission must be one of `no-access`, `read-only`, `consume`, `modify-topic` or `delete`."
  }
}

# Optional variables

variable "ingress_enabled" {
  description = "Enable or disable the reception of messages to the endpoint. The default value is `true`"
  type        = bool
  default     = true
}

variable "egress_enabled" {
  description = "Enable or disable the transmission of messages from the endpoint. The default value is `true`"
  type        = bool
  default     = true
}

variable "queue_subscription_topics" {
  description = "List of queue subscription topics. Only valid if endpoint type is `queue`."
  type        = list(string)
  default     = []
}

variable "jndi_queue_name" {
  description = "Name of the JNDI queue if provided"
  type        = string
  default     = ""
}

variable "jndi_topic_name" {
  description = "Name of the JNDI topic if provided"
  type        = string
  default     = ""
}

#AutoAddAttributes