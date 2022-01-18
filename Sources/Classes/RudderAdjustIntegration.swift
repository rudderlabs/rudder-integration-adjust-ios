//
//  RudderAdjustIntegration.swift
//  RudderAdjust
//
//  Created by Pallab Maiti on 18/01/22.
//

import Foundation
import Rudder
import Adjust

class RudderAdjustIntegration: RSIntegration {
    var eventDictionary: [String: String]?
    
    init(config: [String: Any], client: RSClient) {
        let apiToken = config["appToken"] as? String ?? ""
        if let eventArray = config["customMappings"] as? [[String: Any]] {
            var eventDictionary: [String: String]?
            for item in eventArray {
                if let from = item["from"] as? String, let to = item["to"] as? String {
                    eventDictionary?[from] = to
                }
            }
            self.eventDictionary = eventDictionary
        }
//        limitedDataUse = config["limitedDataUse"] as? Bool
//        dpoState = config["dpoState"] as? Int
//        if dpoState != 0, dpoState != 1000 {
//            dpoState = 0
//        }
//        dpoCountry = config["dpoCountry"] as? Int
//        if dpoCountry != 0, dpoCountry != 1 {
//            dpoCountry = 0
//        }
//        if limitedDataUse == true, let country = self.dpoCountry, let state = self.dpoState {
//            Settings.setDataProcessingOptions(["LDU"], country: Int32(country), state: Int32(state))
//            RSLogger.logDebug("[FBSDKSettings setDataProcessingOptions:[LDU] country:\(country) state:\(state)]")
//        } else {
//            Settings.setDataProcessingOptions([])
//            RSLogger.logDebug("[FBSDKSettings setDataProcessingOptions:[]]")
//        }
    }
    
    
    func dump(_ message: RSMessage) {
        
    }
    
    func reset() {
        
    }
    
    func flush() {
        
    }
    
    
}

/*
 - (instancetype)initWithConfig:(NSDictionary *)config
                  withAnalytics:(nonnull RSClient *)client
               withRudderConfig:(nonnull RSConfig *)rudderConfig{
     self = [super init];
     if (self) {
         self.config = config;
         self.client = client;
         
         NSString *apiToken = [config objectForKey:@"appToken"];
         // create eventmap
         NSArray *eventArray = [config objectForKey:@"customMappings"];
         if (eventArray != nil && eventArray.count > 0) {
             NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
             for (NSDictionary *eventDict in eventArray) {
                 NSString *from = [eventDict objectForKey:@"from"];
                 NSString *to  = [eventDict objectForKey:@"to"];
                 
                 [tempDict setValue:to forKey:from];
             }
             self.eventMap = tempDict;
         }
         NSNumber *delayTime = [config objectForKey:@"delay"];
         double delay = 0;
         if (delayTime != nil) {
             delay = [delayTime doubleValue];
         }
         if (delay < 0) {
             delay = 0;
         } else if (delay > 10) {
             delay = 10;
         }
         
         if (apiToken != nil && ![apiToken isEqualToString:@""]) {
             NSString *environment = ADJEnvironmentProduction;
             if (rudderConfig.logLevel >= 4) {
                 environment = ADJEnvironmentSandbox;
             }
             
             ADJConfig *adjustConfig = [ADJConfig configWithAppToken:apiToken environment:environment];
             [adjustConfig setLogLevel:rudderConfig.logLevel >= 4 ? ADJLogLevelVerbose : ADJLogLevelError];
             [adjustConfig setEventBufferingEnabled:YES];
             [adjustConfig setDelegate:self];
             if (delay > 0) {
                 [adjustConfig setDelayStart:delay];
             }
             [Adjust appDidLaunch:adjustConfig];
         }
     }
     return self;
 }

 - (void)dump:(nonnull RSMessage *)message {
     if (self.eventMap == nil) {
         return;
     }
     if([message.type isEqualToString:@"identify"]) {
         [self setPartnerParams:message];
     } else if ([message.type isEqualToString:@"track"]) {
         NSString *adjEventToken = [self.eventMap objectForKey:message.event];
         if (adjEventToken != nil) {
             [self setPartnerParams:message];
             ADJEvent *event = [[ADJEvent alloc] initWithEventToken:adjEventToken];
             NSDictionary *eventProperties = message.properties;
             if (eventProperties != nil) {
                 for (NSString *key in [eventProperties allKeys]) {
                     [event addCallbackParameter:key value:[NSString stringWithFormat:@"%@", [eventProperties objectForKey:key]]];
                 }
                 NSNumber *total = [eventProperties objectForKey:@"revenue"];
                 NSString *currency = [eventProperties objectForKey:@"currency"];
                 if (total != nil && currency != nil) {
                     [event setRevenue:[total doubleValue] currency:currency];
                 }
             }
             NSDictionary *userProperties = message.userProperties;
             if (userProperties != nil) {
                 for (NSString *key in [userProperties allKeys]) {
                     [event addCallbackParameter:key value:[NSString stringWithFormat:@"%@", [userProperties objectForKey:key]]];
                 }
             }
             [Adjust trackEvent:event];
         }
     } else if ([message.type isEqualToString:@"screen"]) {
         [RSLogger logWarn:@"MessageType is not supported"];
     } else {
         [RSLogger logWarn:@"MessageType is not specified"];
     }
 }

 -(void) setPartnerParams:(RSMessage*) message {
     [Adjust addSessionPartnerParameter:@"anonymousId" value:message.anonymousId];
     if (message.userId != nil && ![message.userId isEqualToString:@""]) {
         [Adjust addSessionPartnerParameter:@"userId" value:message.userId];
     }
 }

 - (void)reset {
     [Adjust resetSessionPartnerParameters];
 }

 */

/*
 class RudderFacebookIntegration: RSIntegration {
     var limitedDataUse: Bool?
     var dpoState: Int?
     var dpoCountry: Int?
     let events = ["identify", "track", "screen"]
     
     init(config: [String: Any], client: RSClient) {
         limitedDataUse = config["limitedDataUse"] as? Bool
         dpoState = config["dpoState"] as? Int
         if dpoState != 0, dpoState != 1000 {
             dpoState = 0
         }
         dpoCountry = config["dpoCountry"] as? Int
         if dpoCountry != 0, dpoCountry != 1 {
             dpoCountry = 0
         }
         if limitedDataUse == true, let country = self.dpoCountry, let state = self.dpoState {
             Settings.setDataProcessingOptions(["LDU"], country: Int32(country), state: Int32(state))
             RSLogger.logDebug("[FBSDKSettings setDataProcessingOptions:[LDU] country:\(country) state:\(state)]")
         } else {
             Settings.setDataProcessingOptions([])
             RSLogger.logDebug("[FBSDKSettings setDataProcessingOptions:[]]")
         }
     }
     
     
     func dump(_ message: RSMessage) {
         switch message.type {
         case "identify":
             let address = message.context?.traits?["address"] as? [String: Any]
             AppEvents.userID = message.userId
             AppEvents.shared.setUser(email: message.context?.traits?["email"] as? String, firstName: message.context?.traits?["firstName"] as? String, lastName: message.context?.traits?["lastName"] as? String, phone: message.context?.traits?["phone"] as? String, dateOfBirth: message.context?.traits?["birthday"] as? String, gender: message.context?.traits?["gender"] as? String, city: address?["city"] as? String, state: address?["state"] as? String, zip: address?["postalcode"] as? String, country: address?["country"] as? String)
         case "track":
             if let event = message.event {
                 let index = event.index(event.startIndex, offsetBy: min(40, event.count))
                 let truncatedEvent = String(event[..<index])
                 if let revenue = RSFBUtility.extractRevenue(from: message.properties, revenueKey: "revenue") {
                     let currency = RSFBUtility.extractCurrency(from: message.properties, withKey: "currency")
                     AppEvents.logPurchase(revenue, currency: currency)
                     var properties = message.properties
                     properties?[AppEvents.ParameterName.currency.rawValue] = currency
                     AppEvents.logEvent(AppEvents.Name(rawValue: truncatedEvent), valueToSum: revenue, parameters: properties)
                 } else {
                     AppEvents.logEvent(AppEvents.Name(rawValue: truncatedEvent), parameters: message.properties)
                 }
             }
         case "screen":
             if let event = message.event {
                 // FB Event Names must be <= 40 characters
                 // 'Viewed' and 'Screen' with spaces take up 14
                 let index = event.index(event.startIndex, offsetBy: min(26, event.count))
                 let truncatedEvent = String(event[..<index])
                 AppEvents.logEvent(AppEvents.Name(rawValue: "Viewed \(truncatedEvent) Screen"), parameters: message.properties)
             }
         default:
             RSLogger.logWarn("MessageType is not supported")
         }
     }
     
     func reset() {
         AppEvents.clearUserID()
         AppEvents.shared.clearUserData()
     }
     
     func flush() {
         
     }
 }

 */
