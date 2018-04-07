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

#import "GCTNavigation.h"
#import "GCTUINavigationBar.h"
#import "UINavigationController+GCTCategory.h"
#import "UIViewController+GCTUINavigationBarCategory.h"

FOUNDATION_EXPORT double GCTNavigationVersionNumber;
FOUNDATION_EXPORT const unsigned char GCTNavigationVersionString[];

