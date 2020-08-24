//
//  RudderAdjustFactory.m
//  FBSnapshotTestCase
//
//  Created by Arnab Pal on 29/10/19.
//

#import "RudderAdjustFactory.h"
#import "RudderAdjustIntegration.h"

@implementation RudderAdjustFactory

+ (instancetype)instance {
    static RudderAdjustFactory *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (nonnull NSString *)key {
    return @"Adjust";
}

- (nonnull id<RSIntegration>)initiate:(nonnull NSDictionary *)config client:(nonnull RSClient *)client rudderConfig:(nonnull RSConfig *)rudderConfig {
    return [[RudderAdjustIntegration alloc] initWithConfig:config withAnalytics:client withRudderConfig:rudderConfig];
}


@end
