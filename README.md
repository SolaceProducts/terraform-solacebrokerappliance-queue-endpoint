# Solace PubSub+ Appliance Queues & Endpoints Terraform Module

This Terraform module configures a "guaranteed messaging endpoint" or an "endpoint template" on the [Solace PubSub+ Appliance](https://solace.com/products/event-broker/). 

This module supports the configuration of one of the following:

- a "_queue_" or a "_topic endpoint_": applications that make use of [Guaranteed Messaging](https://docs.solace.com/Messaging/Guaranteed-Msg/Guaranteed-Messages.htm), need [endpoints](https://docs.solace.com/Messaging/Guaranteed-Msg/Endpoints.htm) configured on the event broker to persist messages. A queue may also have a list of [topic subscriptions](https://docs.solace.com/API/API-Developer-Guide/Adding-Topic-Subscriptio.htm).

- a "_queue template_" or a "_topic endpoint template_": [Endpoint templates](https://docs.solace.com/Messaging/Guaranteed-Msg/Endpoint-Templates.htm?Highlight=Endpoint%20templates) may be used for new client created endpoints.

The module also supports exposing a created queue or topic endpoint via JNDI for JMS applications.

Use case details are provided in the [Examples](#examples) section.

## Module input variables

### Required

* `msg_vpn_name` - Endpoints and endpoint templates are specific to a Message VPN on the broker.
* `endpoint_type` - The type of the endpoint or template to be created. Only one type is allowed at a time.
* `endpoint_name` - The name of the endpoint or template to be created.
* `permission` - Queues or topic endpoints must have a valid `owner` or `permission` for non-owners configured to enable clients to connect and consume messages. Consider the security implications when choosing a value. For more information, see the [PubSub+ documentation](https://docs.solace.com/Messaging/Guaranteed-Msg/Configuring-Queues.htm#Configuring_Permissions_for_Non-Owner_Clients_..57).


### Optional

Optional module variables are either shared by multiple types, or conditional to the type where incompatible variables will be ignored. For example, the `permission` variable is shared by all endpoint and template types but `queue_name_filter` is specific to the `queue_template` type and ignored for other types. To determine the variable name mappings, we recommend that you look for matching attribute names in the documentation for the endpoint or template resource:

| Resource name |
|---------------|
|[solacebroker_msg_vpn_queue](https://registry.terraform.io/providers/SolaceProducts/solacebrokerappliance/latest/docs/resources/msg_vpn_queue#optional)|
|[solacebroker_msg_vpn_topic_endpoint](https://registry.terraform.io/providers/SolaceProducts/solacebrokerappliance/latest/docs/resources/msg_vpn_topic_endpoint#optional)|
|[solacebroker_msg_vpn_queue_template](https://registry.terraform.io/providers/SolaceProducts/solacebrokerappliance/latest/docs/resources/msg_vpn_queue_template#optional)|
|[solacebroker_msg_vpn_topic_endpoint_template](https://registry.terraform.io/providers/SolaceProducts/solacebrokerappliance/latest/docs/resources/msg_vpn_topic_endpoint_template#optional)|

The default value for most of the optional variables is `null`, meaning that if you don’t provide a value then the default value of the resource is provisioned on the event broker.

-> The module defaults for `ingress_enabled` and `egress_enabled` optional variables are `true`, which differ from the resource attribute defaults.

## Module outputs

[Module outputs](https://developer.hashicorp.com/terraform/language/values/outputs) provide reference to created resources. Any reference to a resource that has not been created will be set to `(null)`.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_solacebrokerappliance"></a> [solacebrokerappliance](https://registry.terraform.io/providers/SolaceProducts/solacebrokerappliance/latest) | >= 1.0 |

## Resources

The following table shows the resources created for each `endpoint-type` value. "X" denotes a resource that is always created, "O" denotes a resource that you have the option to create.  

| Name | queue | topic_endpoint | queue_template | topic_endpoint_template |
|------|------|------|------|------|
| solacebroker_msg_vpn_queue | X | | | |
| solacebroker_msg_vpn_jndi_queue | O | | | |
| solacebroker_msg_vpn_queue_subscription | O | | | |
| solacebroker_msg_vpn_topic_endpoint | | X | | |
| solacebroker_msg_vpn_jndi_topic | | O | | |
| solacebroker_msg_vpn_queue_template | | | X | |
| solacebroker_msg_vpn_topic_endpoint_template | | | | X |

## Examples

The following examples demonstrate several specific use cases for this module:

- Queue
    - [Exclusive queue](examples/exclusive-queue)
    - [Non-exclusive queue](examples/non-exclusive-queue)
    - [Partitioned queue](examples/partitioned-queue)
    - [Queue with topic subscriptions](examples/queue-with-topic-subscriptions)
    - [Queue with exposed JNDI](examples/queue-with-jndi)
- [Queue template](examples/queue-template)
- [Topic endpoint](examples/topic-endpoint)
    - [Topic endpoint with exposed JNDI](examples/topic-endpoint-with-jndi)
- [Topic endpoint template](examples/topic-endpoint-template)

## Module use recommendations

This module is expected to be used primarily by application teams. It supports provisioning endpoints or templates required by a specific application. It may be forked and adjusted with private defaults.

## Resources

For more information about Solace technology in general please visit these resources:

- Solace [Technical Documentation](https://docs.solace.com/)
- The Solace Developer Portal website at: [solace.dev](//solace.dev/)
- Understanding [Solace technology](//solace.com/products/platform/)
- Ask the [Solace community](//dev.solace.com/community/).
