# What is RudderStack?

[RudderStack](https://rudderstack.com/) is a **customer data pipeline** tool for collecting, routing and processing data from your websites, apps, cloud tools, and data warehouse.

More information on RudderStack can be found [here](https://github.com/rudderlabs/rudder-server).

## Getting Started with the RudderStack iOS SDK for Adjust

1. Add [Adjust](https://www.adjust.com) as a destination in the [Dashboard](https://app.rudderstack.com/) and define ```apiToken``` and ```eventMapping```

2. Rudder-Adjust is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'Rudder-Adjust'
```

## Initialize ```RudderClient```

Put this code in your ```AppDelegate.m``` file under the method ```didFinishLaunchingWithOptions```
```
RSConfigBuilder *builder = [[RSConfigBuilder alloc] init];
[builder withDataPlaneUrl:<YOUR_DATA_PLANE_URL>];
[builder withFactory:[RudderAdjustFactory instance]];
[RSClient getInstance:<YOUR_WRITE_KEY> config:[builder build]];
```

## Send Events

Follow the steps from the [documentation](https://docs.rudderstack.com/destinations/adjust) to send the events.

## Contact Us

If you come across any issues while configuring or using this SDK, please feel free to start a conversation on our [Slack](https://resources.rudderstack.com/join-rudderstack-slack) channel. We will be happy to help you.
