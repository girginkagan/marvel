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

#import "Object+Unrealm.h"
#import "ObjectiveCRuntime.h"

FOUNDATION_EXPORT double UnrealmVersionNumber;
FOUNDATION_EXPORT const unsigned char UnrealmVersionString[];

