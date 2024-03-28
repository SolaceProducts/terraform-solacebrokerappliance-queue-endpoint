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

resource "solacebroker_msg_vpn_queue" "main" {
  count = var.endpoint_type == "queue" ? 1 : 0

  msg_vpn_name    = var.msg_vpn_name
  queue_name      = var.endpoint_name
  permission      = var.permission
  ingress_enabled = var.ingress_enabled
  egress_enabled  = var.egress_enabled

  access_type                                   = var.access_type
  consumer_ack_propagation_enabled              = var.consumer_ack_propagation_enabled
  dead_msg_queue                                = var.dead_msg_queue
  delivery_count_enabled                        = var.delivery_count_enabled
  delivery_delay                                = var.delivery_delay
  event_bind_count_threshold                    = var.event_bind_count_threshold
  event_msg_spool_usage_threshold               = var.event_msg_spool_usage_threshold
  event_reject_low_priority_msg_limit_threshold = var.event_reject_low_priority_msg_limit_threshold
  max_bind_count                                = var.max_bind_count
  max_delivered_unacked_msgs_per_flow           = var.max_delivered_unacked_msgs_per_flow
  max_msg_size                                  = var.max_msg_size
  max_msg_spool_usage                           = var.max_msg_spool_usage
  max_redelivery_count                          = var.max_redelivery_count
  max_ttl                                       = var.max_ttl
  owner                                         = var.owner
  partition_count                               = var.partition_count
  partition_rebalance_delay                     = var.partition_rebalance_delay
  partition_rebalance_max_handoff_time          = var.partition_rebalance_max_handoff_time
  redelivery_delay_enabled                      = var.redelivery_delay_enabled
  redelivery_delay_initial_interval             = var.redelivery_delay_initial_interval
  redelivery_delay_max_interval                 = var.redelivery_delay_max_interval
  redelivery_delay_multiplier                   = var.redelivery_delay_multiplier
  redelivery_enabled                            = var.redelivery_enabled
  reject_low_priority_msg_enabled               = var.reject_low_priority_msg_enabled
  reject_low_priority_msg_limit                 = var.reject_low_priority_msg_limit
  reject_msg_to_sender_on_discard_behavior      = var.reject_msg_to_sender_on_discard_behavior
  respect_msg_priority_enabled                  = var.respect_msg_priority_enabled
  respect_ttl_enabled                           = var.respect_ttl_enabled
}

resource "solacebroker_msg_vpn_queue_subscription" "main" {
  count = var.endpoint_type == "queue" ? length(var.queue_subscription_topics) : 0

  msg_vpn_name       = solacebroker_msg_vpn_queue.main[0].msg_vpn_name
  queue_name         = solacebroker_msg_vpn_queue.main[0].queue_name
  subscription_topic = var.queue_subscription_topics[count.index]
}

resource "solacebroker_msg_vpn_jndi_queue" "main" {
  count = var.endpoint_type == "queue" && var.jndi_queue_name != "" ? 1 : 0

  msg_vpn_name  = solacebroker_msg_vpn_queue.main[0].msg_vpn_name
  physical_name = solacebroker_msg_vpn_queue.main[0].queue_name
  queue_name    = var.jndi_queue_name
}

resource "solacebroker_msg_vpn_topic_endpoint" "main" {
  count = var.endpoint_type == "topic_endpoint" ? 1 : 0

  msg_vpn_name        = var.msg_vpn_name
  topic_endpoint_name = var.endpoint_name
  permission          = var.permission
  ingress_enabled     = var.ingress_enabled
  egress_enabled      = var.egress_enabled

  access_type                                   = var.access_type
  consumer_ack_propagation_enabled              = var.consumer_ack_propagation_enabled
  dead_msg_queue                                = var.dead_msg_queue
  delivery_count_enabled                        = var.delivery_count_enabled
  delivery_delay                                = var.delivery_delay
  event_bind_count_threshold                    = var.event_bind_count_threshold
  event_reject_low_priority_msg_limit_threshold = var.event_reject_low_priority_msg_limit_threshold
  event_spool_usage_threshold                   = var.event_spool_usage_threshold
  max_bind_count                                = var.max_bind_count
  max_delivered_unacked_msgs_per_flow           = var.max_delivered_unacked_msgs_per_flow
  max_msg_size                                  = var.max_msg_size
  max_redelivery_count                          = var.max_redelivery_count
  max_spool_usage                               = var.max_spool_usage
  max_ttl                                       = var.max_ttl
  owner                                         = var.owner
  redelivery_delay_enabled                      = var.redelivery_delay_enabled
  redelivery_delay_initial_interval             = var.redelivery_delay_initial_interval
  redelivery_delay_max_interval                 = var.redelivery_delay_max_interval
  redelivery_delay_multiplier                   = var.redelivery_delay_multiplier
  redelivery_enabled                            = var.redelivery_enabled
  reject_low_priority_msg_enabled               = var.reject_low_priority_msg_enabled
  reject_low_priority_msg_limit                 = var.reject_low_priority_msg_limit
  reject_msg_to_sender_on_discard_behavior      = var.reject_msg_to_sender_on_discard_behavior
  respect_msg_priority_enabled                  = var.respect_msg_priority_enabled
  respect_ttl_enabled                           = var.respect_ttl_enabled

}

resource "solacebroker_msg_vpn_jndi_topic" "main" {
  count = var.endpoint_type == "topic_endpoint" && var.jndi_topic_name != "" ? 1 : 0

  msg_vpn_name  = solacebroker_msg_vpn_topic_endpoint.main[0].msg_vpn_name
  physical_name = solacebroker_msg_vpn_topic_endpoint.main[0].topic_endpoint_name
  topic_name    = var.jndi_topic_name
}

resource "solacebroker_msg_vpn_queue_template" "main" {
  count = var.endpoint_type == "queue_template" ? 1 : 0

  msg_vpn_name        = var.msg_vpn_name
  queue_template_name = var.endpoint_name
  permission          = var.permission

  access_type                                   = var.access_type
  consumer_ack_propagation_enabled              = var.consumer_ack_propagation_enabled
  dead_msg_queue                                = var.dead_msg_queue
  delivery_delay                                = var.delivery_delay
  durability_override                           = var.durability_override
  event_bind_count_threshold                    = var.event_bind_count_threshold
  event_msg_spool_usage_threshold               = var.event_msg_spool_usage_threshold
  event_reject_low_priority_msg_limit_threshold = var.event_reject_low_priority_msg_limit_threshold
  max_bind_count                                = var.max_bind_count
  max_delivered_unacked_msgs_per_flow           = var.max_delivered_unacked_msgs_per_flow
  max_msg_size                                  = var.max_msg_size
  max_msg_spool_usage                           = var.max_msg_spool_usage
  max_redelivery_count                          = var.max_redelivery_count
  max_ttl                                       = var.max_ttl
  queue_name_filter                             = var.queue_name_filter
  redelivery_delay_enabled                      = var.redelivery_delay_enabled
  redelivery_delay_initial_interval             = var.redelivery_delay_initial_interval
  redelivery_delay_max_interval                 = var.redelivery_delay_max_interval
  redelivery_delay_multiplier                   = var.redelivery_delay_multiplier
  redelivery_enabled                            = var.redelivery_enabled
  reject_low_priority_msg_enabled               = var.reject_low_priority_msg_enabled
  reject_low_priority_msg_limit                 = var.reject_low_priority_msg_limit
  reject_msg_to_sender_on_discard_behavior      = var.reject_msg_to_sender_on_discard_behavior
  respect_msg_priority_enabled                  = var.respect_msg_priority_enabled
  respect_ttl_enabled                           = var.respect_ttl_enabled
}

resource "solacebroker_msg_vpn_topic_endpoint_template" "main" {
  count = var.endpoint_type == "topic_endpoint_template" ? 1 : 0

  msg_vpn_name                 = var.msg_vpn_name
  topic_endpoint_template_name = var.endpoint_name
  permission                   = var.permission

  access_type                                   = var.access_type
  consumer_ack_propagation_enabled              = var.consumer_ack_propagation_enabled
  dead_msg_queue                                = var.dead_msg_queue
  delivery_delay                                = var.delivery_delay
  event_bind_count_threshold                    = var.event_bind_count_threshold
  event_msg_spool_usage_threshold               = var.event_msg_spool_usage_threshold
  event_reject_low_priority_msg_limit_threshold = var.event_reject_low_priority_msg_limit_threshold
  max_bind_count                                = var.max_bind_count
  max_delivered_unacked_msgs_per_flow           = var.max_delivered_unacked_msgs_per_flow
  max_msg_size                                  = var.max_msg_size
  max_msg_spool_usage                           = var.max_msg_spool_usage
  max_redelivery_count                          = var.max_redelivery_count
  max_ttl                                       = var.max_ttl
  redelivery_delay_enabled                      = var.redelivery_delay_enabled
  redelivery_delay_initial_interval             = var.redelivery_delay_initial_interval
  redelivery_delay_max_interval                 = var.redelivery_delay_max_interval
  redelivery_delay_multiplier                   = var.redelivery_delay_multiplier
  redelivery_enabled                            = var.redelivery_enabled
  reject_low_priority_msg_enabled               = var.reject_low_priority_msg_enabled
  reject_low_priority_msg_limit                 = var.reject_low_priority_msg_limit
  reject_msg_to_sender_on_discard_behavior      = var.reject_msg_to_sender_on_discard_behavior
  respect_msg_priority_enabled                  = var.respect_msg_priority_enabled
  respect_ttl_enabled                           = var.respect_ttl_enabled
  topic_endpoint_name_filter                    = var.topic_endpoint_name_filter
}


