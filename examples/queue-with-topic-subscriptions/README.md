# Queue with Topic Subscriptions Example

Configuration in this directory creates a [queue with topic subscriptions](https://docs.solace.com/API/API-Developer-Guide/Adding-Topic-Subscriptio.htm) on the PubSub+ event broker leveraging the Queues & Endpoints Terraform module.

## Module Configuration in the Example

### Mandatory Inputs

* `msg_vpn_name` - Set to `default` in the example.
* `endpoint_type` - Set to `queue` in the example.
* `endpoint_name` - Set to `testQS` in the example.
* `permission` - Set to `consume` in the example to enable the receiver app to remove consumed messages from the queue.

### Optional Inputs

You can specify a list of subscriptions to one or more topics for the queue. Topics may include [wildcards](https://docs.solace.com/Messaging/Wildcard-Charaters-Topic-Subs.htm). Additional configuration details are provided in the [PubSub+ documentation](https://docs.solace.com/Messaging/Guaranteed-Msg/Configuring-Queues.htm#configure-partitioned-queues).

* `queue_subscription_topics`: the list of topics as strings to subscribe to. Omitting this parameter or an empty list means no subscription.

Optional module input variables have the same name as the attributes of the underlying provider resource. If omitted, then the default for the related resource attribute will be configured on the broker. For a list of attributes and the corresponding defaults, see the [documentation of "solacebroker_msg_vpn_queue"](https://registry.terraform.io/providers/SolaceProducts/solacebrokerappliance/latest/docs/resources/msg_vpn_queue#optional).

### Output

The module `provisioned_queue` output refers to the created queue.

The module `provisioned_queue_subscriptions` output lists the created subscription resources for the queue.

## Created Resources

This example will create the following resources:

* `solacebroker_msg_vpn_queue`
* zero or more `solacebroker_msg_vpn_queue_subscription` resources, depending on the number of subscription topics provided

## Running the Example

### Access to a PubSub+ Event Broker

If you don't already have access to a broker, see the [Developers page](https://www.solace.dev/) for options to get started.

### Sample Source Code

The sample is available from the module GitHub repo:

```bash
git clone https://github.com/SolaceProducts/terraform-solacebrokerappliance-queue-endpoint.git
cd examples/queue-with-topic-subscriptions
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

For more information, see [Configuring Queues](https://docs.solace.com/Messaging/Guaranteed-Msg/Configuring-Queues.htm#Configuring_Queues) section in the PubSub+ documentation.

