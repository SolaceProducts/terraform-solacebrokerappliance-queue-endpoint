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

# Output variable definitions

output "queue" {
  value       = try(solacebroker_msg_vpn_queue.main[0], null)
  description = "A Queue acts as both a destination that clients can publish messages to, and as an endpoint that clients can bind consumers to and consume messages from"
}

output "topic_endpoint" {
  value       = try(solacebroker_msg_vpn_topic_endpoint.main[0], null)
  description = "A Topic Endpoint attracts messages published to a topic for which the Topic Endpoint has a matching topic subscription. The topic subscription for the Topic Endpoint is specified in the client request to bind a Flow to that Topic Endpoint. Queues are significantly more flexible than Topic Endpoints and are the recommended approach for most applications. The use of Topic Endpoints should be restricted to JMS applications"
}

output "queue_template" {
  value       = try(solacebroker_msg_vpn_queue_template.main[0], null)
  description = "A Queue Template provides a mechanism for specifying the initial state for client created queues"
}

output "topic_endpoint_template" {
  value       = try(solacebroker_msg_vpn_topic_endpoint_template.main[0], null)
  description = "A Topic Endpoint Template provides a mechanism for specifying the initial state for client created topic endpoints"
}

output "queue_subscriptions" {
  value = try({
    for instance in solacebroker_msg_vpn_queue_subscription.main :
    instance.subscription_topic => instance
  }, null)
  description = "One or more Queue Subscriptions can be added to a durable queue so that Guaranteed messages published to matching topics are also delivered to and spooled by the queue"
}

output "jndi_queue" {
  value       = try(solacebroker_msg_vpn_jndi_queue.main[0], null)
  description = "The message broker provides an internal JNDI store for provisioned Queue objects that clients can access through JNDI lookups"
}

output "jndi_topic" {
  value       = try(solacebroker_msg_vpn_jndi_topic.main[0], null)
  description = "The message broker provides an internal JNDI store for provisioned Topic objects that clients can access through JNDI lookups"
}


