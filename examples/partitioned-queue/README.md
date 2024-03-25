# Partitioned Queue Example

Configuration in this directory creates a [partitioned queue](https://docs.solace.com/Messaging/Guaranteed-Msg/Queues.htm#partitioned-queues) on the PubSub+ event broker leveraging the Queues & Endpoints Terraform module.

## Module Configuration in the Example

### Mandatory Inputs

* `msg_vpn_name` - set to `default` in the example
* `endpoint_type` - set to `queue`
* `endpoint_name` - set to `testPQ` in the example
* `permission` - set to `consume` in the example to enable the receiver app to remove consumed messages from the queue

### Optional Inputs

A partitioned queue is a queue with "non-exclusive" access type and greater than zero partition count. Configuration details are provided in the [PubSub+ documentation](https://docs.solace.com/Messaging/Guaranteed-Msg/Configuring-Queues.htm#configure-partitioned-queues).

* `access_type`: must be set to "non-exclusive"
* `partition_count`: greater than zero partitionals needs to be specified
* `partition_rebalance_delay` and `partition_rebalance_max_handoff_time` are additional optional configurations specifically related to partitioned queues

Optional module input variables have the same name as the attributes of the underlying provider resource. If omitted then the default for the related resource attribute will be configured on the broker. For attributes and defaults, refer to the [documentation of "solacebroker_msg_vpn_queue"](https://registry.terraform.io/providers/SolaceProducts/solacebroker/latest/docs/resources/msg_vpn_queue#optional).

### Output

The module `provisioned_queue` output refers to the created queue.

## Created resources

This example will create following resources:

* `solacebroker_msg_vpn_queue`

## Running the Example

### Access to a PubSub+ broker

If you don't already have access to a broker, refer to the [Developers page](https://www.solace.dev/) for options to get started.

### Sample source code

The sample is available from the module GitHub repo:

```bash
git clone https://github.com/SolaceProducts/terraform-solacebroker-queue-endpoint.git
cd examples/partitioned-queue
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

Refer to the [Configuring Queues](https://docs.solace.com/Messaging/Guaranteed-Msg/Configuring-Queues.htm#Configuring_Queues) section in the PubSub+ documentation.

