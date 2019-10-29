//
//  RudderAdjustIntegration.m
//  FBSnapshotTestCase
//
//  Created by Arnab Pal on 29/10/19.
//

#import "RudderAdjustIntegration.h"

@implementation RudderAdjustIntegration

#pragma mark - Initialization

- (instancetype)initWithConfig:(NSDictionary *)config withAnalytics:(RudderClient *)client {
    if (self == [super init]) {
        self.config = config;
        self.client = client;
        
        NSString *apiToken = [config objectForKey:@"apiToken"];
        
        NSString *environment = ADJEnvironmentSandbox;
        
        NSString *env = [config objectForKey:@"environment"];
        if (env == nil) {
            environment = ADJEnvironmentProduction;
        } else {
            if ([env isEqualToString:@"sandbox"]) {
                environment = ADJEnvironmentSandbox;
            } else {
                environment = ADJEnvironmentProduction;
            }
        }
        
        if (apiToken != nil) {
            ADJConfig *adjustConfig = [ADJConfig configWithAppToken:apiToken environment:environment];
            [adjustConfig setEventBufferingEnabled:YES];
            [adjustConfig setDelegate:self];
            [Adjust appDidLaunch:adjustConfig];
            
            // create eventmap
            NSArray *eventArray = [config objectForKey:@"eventTokenMap"];
            if (eventArray != nil && eventArray.count > 0) {
                for (NSDictionary *eventDict in eventArray) {
                    NSString *from = [eventDict objectForKey:@"from"];
                    NSString *to  = [eventDict objectForKey:@"to"];
                    
                    [self.eventMap setValue:to forKey:from];
                }
            }
        }
    }
    return self;
}

- (void)dump:(nonnull RudderMessage *)message {
    if (self.eventMap == nil) {
        return;
    }
    
    NSString *adjEventToken = [self.eventMap objectForKey:message.event];
    if (adjEventToken != nil) {
        ADJEvent *event = [[ADJEvent alloc] initWithEventToken:adjEventToken];
        [event addCallbackParameter:@"type" value:message.type];
        NSDictionary *eventProperties = message.properties;
        if (eventProperties != nil) {
            for (NSString *key in [eventProperties allKeys]) {
                [event addPartnerParameter:key value:[eventProperties objectForKey:key]];
            }
            NSNumber *total = [eventProperties objectForKey:@"total"];
            NSString *currency = [eventProperties objectForKey:@"currency"];
            if (total != nil && currency != nil) {
                [event setRevenue:[total doubleValue] currency:currency];
            }
        }
        NSDictionary *userProperties = message.userProperties;
        if (userProperties != nil) {
            for (NSString *key in [userProperties allKeys]) {
                [event addCallbackParameter:key value:[userProperties objectForKey:key]];
            }
        }
        [Adjust trackEvent:event];
    }
}

@end
