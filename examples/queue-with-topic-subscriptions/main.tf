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

provider "solacebroker" {
  username = "admin"
  password = "admin"
  url      = "http://localhost:8080" # adjust to your appliance management host and SEMP port
}

module "queue_with_topic_subscriptions" {
  # update with the module location
  source = "../.."

  msg_vpn_name  = "default"
  endpoint_type = "queue"
  endpoint_name = "testQS"

  # permission "consume" enables a messaging client to connect, read and consume messages to/from the queue
  permission = "consume"

  # this will add the listed subscriptions to the queue
  queue_subscription_topics = ["foo/bar", "baz>"]
}

output "provisioned_queue" {
  value       = module.queue_with_topic_subscriptions.queue
  description = "The provisioned queue resource"
}

output "provisioned_queue_subscriptions" {
  value       = module.queue_with_topic_subscriptions.queue_subscriptions
  description = "The provisioned queue subscription resources"
}


