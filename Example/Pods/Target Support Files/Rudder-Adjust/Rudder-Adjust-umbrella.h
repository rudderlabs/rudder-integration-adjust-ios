#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "RudderAdjustFactory.h"
#import "RudderAdjustIntegration.h"

FOUNDATION_EXPORT double Rudder_AdjustVersionNumber;
FOUNDATION_EXPORT const unsigned char Rudder_AdjustVersionString[];

