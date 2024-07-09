# Topic Endpoint Example

Configuration in this directory creates a [topic endpoint](https://docs.solace.com/Get-Started/topic-endpoints-queues.htm) on the PubSub+ event broker leveraging the Queues & Endpoints Terraform module.

Important: The topic subscription that a topic endpoint will spool messages for is not specified when a topic endpoint is provisioned. For more information, see the [PubSub+ documentation](https://docs.solace.com/Messaging/Guaranteed-Msg/Configuring-DTEs.htm).

## Module Configuration in the Example

### Mandatory Inputs

* `msg_vpn_name` - Set to `default` in the example.
* `endpoint_type` - Set to `topic_endpoint` in the example.
* `endpoint_name` - Set to `testTE` in the example.
* `permission` - Set to `consume` in the example to enable the receiver app to remove consumed messages from the topic endpoint.

### Optional Inputs

Note that the `access_type` module input variable defines if a topic endpoint is "exclusive" or "non-exclusive". The default is "exclusive".

Optional module input variables have the same name as the attributes of the underlying provider resource. If omitted, then the default for the related resource attribute will be configured on the broker. For a list of attributes and the corresponding defaults, see the [documentation of "solacebroker_msg_vpn_topic_endpoint"](https://registry.terraform.io/providers/SolaceProducts/solacebrokerappliance/latest/docs/resources/msg_vpn_topic_endpoint#optional).

### Output

The module `provisioned_topic endpoint` output refers to the created topic endpoint.

## Created Resources

This example will create the following resources:

* `solacebroker_msg_vpn_topic endpoint`

## Running the Example

### Access to a PubSub+ Event Broker

If you don't already have access to a broker, see the [Developers page](https://www.solace.dev/) for options to get started.

### Sample Source Code

The sample is available from the module GitHub repo:

```bash
git clone https://github.com/SolaceProducts/terraform-solacebrokerappliance-queue-endpoint.git
cd examples/topic-endpoint
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

