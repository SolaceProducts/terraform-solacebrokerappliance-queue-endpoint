# Output variable definitions

output "queue" {
  value = try(solacebroker_msg_vpn_queue.main[0], null)
}

output "topic_endpoint" {
  value = try(solacebroker_msg_vpn_topic_endpoint.main[0], null)
}

output "queue_template" {
  value = try(solacebroker_msg_vpn_queue_template.main[0], null)
}

output "topic_endpoint_template" {
  value = try(solacebroker_msg_vpn_topic_endpoint_template.main[0], null)
}

output "queue_subscriptions" {
  value = try({
    for instance in solacebroker_msg_vpn_queue_subscription.main :
    instance.subscription_topic => instance
  }, null)
}

output "jndi_queue" {
  value = try(solacebroker_msg_vpn_jndi_queue.main[0], null)
}

output "jndi_topic" {
  value = try(solacebroker_msg_vpn_jndi_topic.main[0], null)
}

