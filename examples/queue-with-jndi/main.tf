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

module "queue_with_jndi" {
  # update with the module location
  source = "../.."

  msg_vpn_name  = "default"
  endpoint_type = "queue"
  endpoint_name = "testJQ"

  # permission "consume" enables a messaging client to connect, read and consume messages to/from the queue
  permission = "consume"

  # if the "jndi_queue_name" input variable is defined then the queue will be exposed to JNDI under this name
  jndi_queue_name = "/jndi/queue/testJQ"

  # ingress and egress are enabled by default in the module, no need to enable here
  # ingress_enabled = true
  # egress_enabled = true
}

output "provisioned_queue" {
  value       = module.queue_with_jndi.queue
  description = "The provisioned queue resource"
}

output "provisioned_jndi_queue" {
  value       = module.queue_with_jndi.jndi_queue
  description = "The provisioned JNDI queue resource"
}

