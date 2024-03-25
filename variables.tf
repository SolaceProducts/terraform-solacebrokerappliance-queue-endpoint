# Copyright 2024 Solace Corporation. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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

variable "access_type" {
  description = "The access type for delivering messages to consumer flows bound to the Queue"
  type        = string
  default     = null
}

variable "consumer_ack_propagation_enabled" {
  description = "Enable or disable the propagation of consumer acknowledgments (ACKs) received on the active replication Message VPN to the standby replication Message VPN"
  type        = bool
  default     = null
}

variable "dead_msg_queue" {
  description = "The name of the Dead Message Queue (DMQ) used by the Queue"
  type        = string
  default     = null
}

variable "delivery_count_enabled" {
  description = "Enable or disable the ability for client applications to query the message delivery count of messages received from the Queue"
  type        = bool
  default     = null
}

variable "delivery_delay" {
  description = "The delay, in seconds, to apply to messages arriving on the Queue before the messages are eligible for delivery"
  type        = number
  default     = null
}

variable "durability_override" {
  description = "Controls the durability of queues created from this template"
  type        = string
  default     = null
}

variable "event_bind_count_threshold" {
  description = "The thresholds for the Queue consumer flows event, relative to `max_bind_count`"
  type = object({
    set_percent   = optional(number)
    clear_percent = optional(number)
    set_value     = optional(number)
    clear_value   = optional(number)
  })
  default = null
}

variable "event_msg_spool_usage_threshold" {
  description = "The thresholds for the message spool usage event of the Queue, relative to `max_msg_spool_usage`"
  type = object({
    set_percent   = optional(number)
    clear_percent = optional(number)
    set_value     = optional(number)
    clear_value   = optional(number)
  })
  default = null
}

variable "event_reject_low_priority_msg_limit_threshold" {
  description = "The thresholds for the maximum allowed number of any priority messages queued in the Queue event, relative to `reject_low_priority_msg_limit`"
  type = object({
    set_percent   = optional(number)
    clear_percent = optional(number)
    set_value     = optional(number)
    clear_value   = optional(number)
  })
  default = null
}

variable "event_spool_usage_threshold" {
  description = "The thresholds for the message spool usage event of the Topic Endpoint, relative to `max_spool_usage`"
  type = object({
    set_percent   = optional(number)
    clear_percent = optional(number)
    set_value     = optional(number)
    clear_value   = optional(number)
  })
  default = null
}

variable "max_bind_count" {
  description = "The maximum number of consumer flows that can bind to the Queue"
  type        = number
  default     = null
}

variable "max_delivered_unacked_msgs_per_flow" {
  description = "The maximum number of messages delivered but not acknowledged per flow for the Queue"
  type        = number
  default     = null
}

variable "max_msg_size" {
  description = "The maximum message size allowed in the Queue, in bytes (B)"
  type        = number
  default     = null
}

variable "max_msg_spool_usage" {
  description = "The maximum message spool usage allowed by the Queue, in megabytes (MB)"
  type        = number
  default     = null
}

variable "max_redelivery_count" {
  description = "The maximum number of times the Queue will attempt redelivery of a message prior to it being discarded or moved to the DMQ"
  type        = number
  default     = null
}

variable "max_spool_usage" {
  description = "The maximum message spool usage allowed by the Topic Endpoint, in megabytes (MB)"
  type        = number
  default     = null
}

variable "max_ttl" {
  description = "The maximum time in seconds a message can stay in the Queue when `respect_ttl_enabled` is `\"true\"`"
  type        = number
  default     = null
}

variable "owner" {
  description = "The Client Username that owns the Queue and has permission equivalent to `\"delete\"`"
  type        = string
  default     = null
}

variable "partition_count" {
  description = "The count of partitions of the queue"
  type        = number
  default     = null
}

variable "partition_rebalance_delay" {
  description = "The delay (in seconds) before a partition rebalance is started once needed"
  type        = number
  default     = null
}

variable "partition_rebalance_max_handoff_time" {
  description = "The maximum time (in seconds) to wait before handing off a partition while rebalancing"
  type        = number
  default     = null
}

variable "queue_name_filter" {
  description = "A pattern used to determine which Queues use settings from this Template"
  type        = string
  default     = null
}

variable "redelivery_delay_enabled" {
  description = "Enable or disable a message redelivery delay"
  type        = bool
  default     = null
}

variable "redelivery_delay_initial_interval" {
  description = "The delay to be used between the first 2 redelivery attempts"
  type        = number
  default     = null
}

variable "redelivery_delay_max_interval" {
  description = "The maximum delay to be used between any 2 redelivery attempts"
  type        = number
  default     = null
}

variable "redelivery_delay_multiplier" {
  description = "The amount each delay interval is multiplied by after each failed delivery attempt"
  type        = number
  default     = null
}

variable "redelivery_enabled" {
  description = "Enable or disable message redelivery"
  type        = bool
  default     = null
}

variable "reject_low_priority_msg_enabled" {
  description = "Enable or disable the checking of low priority messages against the `reject_low_priority_msg_limit`"
  type        = bool
  default     = null
}

variable "reject_low_priority_msg_limit" {
  description = "The number of messages of any priority in the Queue above which low priority messages are not admitted but higher priority messages are allowed"
  type        = number
  default     = null
}

variable "reject_msg_to_sender_on_discard_behavior" {
  description = "Determines when to return negative acknowledgments (NACKs) to sending clients on message discards"
  type        = string
  default     = null
}

variable "respect_msg_priority_enabled" {
  description = "Enable or disable the respecting of message priority"
  type        = bool
  default     = null
}

variable "respect_ttl_enabled" {
  description = "Enable or disable the respecting of the time-to-live (TTL) for messages in the Queue"
  type        = bool
  default     = null
}

variable "topic_endpoint_name_filter" {
  description = "A pattern used to determine which Topic Endpoints use settings from this Template"
  type        = string
  default     = null
}

