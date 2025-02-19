//
//  RudderAdjustIntegration.h
//  FBSnapshotTestCase
//
//  Created by Arnab Pal on 29/10/19.
//

#import <Foundation/Foundation.h>
#import <Rudder/Rudder.h>
#import <AdjustSdk/AdjustSdk.h>

NS_ASSUME_NONNULL_BEGIN

@interface RudderAdjustIntegration : NSObject<RSIntegration, AdjustDelegate>

@property (nonatomic, strong) NSDictionary *config;
@property (nonatomic, strong) RSClient *client;
@property (nonatomic, strong) NSMutableDictionary<NSString*, NSString*>* eventMap;

- (instancetype)initWithConfig:(NSDictionary *)config withAnalytics:(RSClient *)client withRudderConfig:(RSConfig*) rudderConfig;

@end

NS_ASSUME_NONNULL_END
