# Topic Endpoint with JNDI Example

Configuration in this directory creates a [topic endpoint that is also exposed as a JNDI administered object](https://docs.solace.com/API/Solace-JMS-API/Managing-Solace-JNDI-Objects.htm) on the PubSub+ event broker leveraging the Queues & Endpoints Terraform module.

Note that exposing topics as JNDI objects requires that you enable JNDI at the Message VPN level and configure a connection factory. You can use the [Service Module](https://registry.terraform.io/modules/SolaceProducts/service/solacebrokerappliance/latest) and the [JNDI Connection Factory Module](https://registry.terraform.io/modules/SolaceProducts/jndi/solacebrokerappliance/latest) to perform these tasks. This module will not check if the requirements are in place, however, if they aren't the configuration will fail.

## Module Configuration in the Example

### Mandatory Inputs

* `msg_vpn_name` - Set to `default` in the example.
* `endpoint_type` - Set to `topic_endpoint` in the example.
* `endpoint_name` - Set to `testJT` in the example.
* `permission` - Set to `consume` in the example to enable the receiver app to remove consumed messages from the topic endpoint.

### Optional Inputs

* `jndi_topic_name`: if provided then the topic endpoint will be exposed to JNDI under this name

Optional module input variables have the same name as the attributes of the underlying provider resource. If omitted, then the default for the related resource attribute will be configured on the broker. For a list of attributes and the corresponding defaults, see the [documentation of "solacebroker_msg_vpn_topic_endpoint"](https://registry.terraform.io/providers/SolaceProducts/solacebrokerappliance/latest/docs/resources/msg_vpn_topic_endpoint#optional).

### Output

The module `provisioned_topic endpoint` output refers to the created topic endpoint.

The module `provisioned_jndi_topic endpoint` output refers to the created JNDI topic resource.

## Created Resources

This example will create the following resources:

* `solacebroker_msg_vpn_topic endpoint`
* `solacebroker_msg_vpn_jndi_topic endpoint` if `jndi_topic_name` has been provided

## Running the Example

### Access to a PubSub+ Event Broker

If you don't already have access to a broker, see the [Developers page](https://www.solace.dev/) for options to get started.

### Sample Source Code

The sample is available from the module GitHub repo:

```bash
git clone https://github.com/SolaceProducts/terraform-solacebrokerappliance-queue-endpoint.git
cd examples/topic-endpoint-with-jndi
```

### Adjust the Provider Configuration

Adjust the [provider parameters](https://registry.terraform.io/providers/SolaceProducts/solacebrokerappliance/latest/docs#schema) in `main.tf` according to your broker. The example configuration shows settings for a local broker running in Docker.

### Create the Resource

Tip: You can verify configuration changes on the broker, before and after, using the [PubSub+ Broker Manager Web UI](https://docs.solace.com/Admin/Broker-Manager/PubSub-Manager-Overview.htm).

Execute from this folder:

```bash
terraform init
terraform plan
terraform apply
```

Run `terraform destroy` to clean up the created resources when they are no longer needed.

## Additional Documentation

For more information, see [Configuring Topic Endpoints](https://docs.solace.com/Messaging/Guaranteed-Msg/Configuring-DTEs.htm) section in the PubSub+ documentation.

