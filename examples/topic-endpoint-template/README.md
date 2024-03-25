# Topic Endpoint Template Example

Configuration in this directory creates a [topic endpoint template](https://docs.solace.com/Messaging/Guaranteed-Msg/Configuring-Endpoint-Templates.htm) on the PubSub+ event broker leveraging the Queues & Endpoints Terraform module.

Important: The topic subscription that a topic endpoint will spool messages for is not specified when a topic endpoint template is provisioned. For additional details refer to the [PubSub+ documentation](https://docs.solace.com/Messaging/Guaranteed-Msg/Configuring-DTEs.htm).

## Module Configuration in the Example

### Mandatory Inputs

* `msg_vpn_name` - set to `default` in the example
* `endpoint_type` - set to `topic_endpoint`
* `endpoint_name` - set to `testTT` in the example
* `permission` - set to `consume` in the example to enable the receiver app to remove consumed messages from the topic endpoint, that has been created from the template

### Optional Inputs

This example specifies an optional attribute `respect_ttl_enabled` of the topic endpoint template for demo purposes.

Optional module input variables have the same name as the attributes of the underlying provider resource. If omitted then the default for the related resource attribute will be configured on the broker. For attributes and defaults, refer to the [documentation of "solacebroker_msg_vpn_topic_endpoint_template"](https://registry.terraform.io/providers/SolaceProducts/solacebroker/latest/docs/resources/msg_vpn_topic_endpoint_template#optional).

### Output

The module `provisioned_topic endpoint_template` output refers to the created topic endpoint template.

## Created resources

This example will create following resources:

* `solacebroker_msg_vpn_topic endpoint_template`

## Running the Example

### Access to a PubSub+ broker

If you don't already have access to a broker, refer to the [Developers page](https://www.solace.dev/) for options to get started.

### Sample source code

The sample is available from the module GitHub repo:

```bash
git clone https://github.com/SolaceProducts/terraform-solacebroker-queue-endpoint.git
cd examples/topic-endpoint-template
```

### Adjust Provider Configuration

Adjust the [provider parameters](https://registry.terraform.io/providers/SolaceProducts/solacebroker/latest/docs#schema) in `main.tf` according to your broker. The example configuration shows settings for a local broker running in Docker.

### Create the resource

Hint: You can verify configuration changes on the broker, before and after, using the [PubSub+ Broker Manager Web UI](https://docs.solace.com/Admin/Broker-Manager/PubSub-Manager-Overview.htm)

Execute from this folder:

```bash
terraform init
terraform plan
terraform apply
```

Run `terraform destroy` to clean up created resources when no longer needed.

## Additional Documentation

Refer to the [Configuring Topic Endpoints](https://docs.solace.com/Messaging/Guaranteed-Msg/Configuring-DTEs.htm) section in the PubSub+ documentation.

