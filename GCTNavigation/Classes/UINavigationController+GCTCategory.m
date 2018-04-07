//
//  UINavigationController+GCTCategory.m
//  GCTNavigationBarDemo
//
//  Created by 罗树新 on 2018/4/7.
//  Copyright © 2018年 GCT. All rights reserved.
//

#import "UINavigationController+GCTCategory.h"
#import <objc/runtime.h>

static BOOL _forceAppFullScreenPopEnable;

static NSString *const kGCTFullScreenPopGesture = @"com.geekcode.kGCTFullScreenPopGesture";
static NSString *const kGCTMaxAllowedInitialDistance = @"com.geekcode.kGCTMaxAllowedInitialDistance";
static NSString *const kGCTPopPanGesture = @"com.geekcode.kGCTPopPanGesture";
@interface UINavigationController ()<UIGestureRecognizerDelegate>
@property (strong, nonatomic, readwrite) UIPanGestureRecognizer *gct_popPanGesture;
@end
@implementation UINavigationController (GCTPopGestureCategory)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _forceAppFullScreenPopEnable = YES;
        [self _gct_swizzleInstanceMethod:@selector(init) with:@selector(gct_init)];
        [self _gct_swizzleInstanceMethod:@selector(initWithCoder:) with:@selector(gct_initWithCoder:)];
        [self _gct_swizzleInstanceMethod:@selector(initWithRootViewController:) with:@selector(gct_initWithRootViewController:)];
        [self _gct_swizzleInstanceMethod:@selector(preferredStatusBarStyle) with:@selector(gct_preferredStatusBarStyle)];
    });
}

- (instancetype)gct_initWithRootViewController:(UIViewController *)rootViewController {
    UINavigationController *nav = [self gct_initWithRootViewController:rootViewController];
    nav.gct_maxAllowedInitialDistance = [UIScreen mainScreen].bounds.size.width / 2.f;
    nav.gct_fullScreenPopGesture = YES;
    return nav;
}
- (instancetype)gct_init {
    UINavigationController *nav = [self gct_init];
    nav.gct_maxAllowedInitialDistance = [UIScreen mainScreen].bounds.size.width / 2.f;
    nav.gct_fullScreenPopGesture = YES;
    return nav;
}

- (instancetype)gct_initWithCoder:(NSCoder *)aDecoder {
    UINavigationController *nav = [self gct_initWithCoder:aDecoder];
    nav.gct_maxAllowedInitialDistance = [UIScreen mainScreen].bounds.size.width / 2.f;
    nav.gct_fullScreenPopGesture = YES;
    return nav;
}

+ (void)gct_setForceAppFullScreenPopEnable:(BOOL)force {
    _forceAppFullScreenPopEnable = force;
}
+ (BOOL)gct_forceAppFullScreenPopEnable {
    return _forceAppFullScreenPopEnable;
}
#pragma mark - Delegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
    
    
    if (_forceAppFullScreenPopEnable && self.gct_fullScreenPopGesture) {
        [gestureRecognizer.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isMemberOfClass:[UIScrollView class]]) {
                
            }
        }];
        CGPoint beginningLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
        CGFloat maxAllowedInitialDistance = self.gct_maxAllowedInitialDistance;
        if (maxAllowedInitialDistance > 0 && beginningLocation.x > maxAllowedInitialDistance) {
            return NO;
        }
        if (self.childViewControllers.count == 1 && ![self.childViewControllers[0] isKindOfClass:NSClassFromString(@"FBTWKWebViewController")]) {
            return NO;
        }
        if ([[self valueForKey:@"_isTransitioning"] boolValue]) {
            return NO;
        }
        CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
        
        if (translation.x <= 0) {
            return NO;
        }
        return YES;
        
    }
    return NO;
}
#pragma mark - Setter/Getter
- (UIStatusBarStyle)gct_preferredStatusBarStyle
{
    [self gct_preferredStatusBarStyle];
    UIViewController* topVC = self.topViewController;
    return [topVC preferredStatusBarStyle];
    
}
- (void)setGct_fullScreenPopGesture:(BOOL)gct_fullScreenPopGesture {
    if (gct_fullScreenPopGesture) {
        [self.view removeGestureRecognizer:self.gct_popPanGesture];
        [self.view addGestureRecognizer:self.gct_popPanGesture];
        self.gct_popPanGesture.maximumNumberOfTouches = 1;
        self.interactivePopGestureRecognizer.enabled = NO;
    } else {
        self.interactivePopGestureRecognizer.enabled = YES;
        [self.view removeGestureRecognizer:self.gct_popPanGesture];
    }
    objc_setAssociatedObject(self, &kGCTFullScreenPopGesture, @(gct_fullScreenPopGesture), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (BOOL)gct_fullScreenPopGesture {
    return [objc_getAssociatedObject(self, &kGCTFullScreenPopGesture) boolValue];
}
- (void)setGct_maxAllowedInitialDistance:(CGFloat)gct_maxAllowedInitialDistance {
    objc_setAssociatedObject(self, &kGCTMaxAllowedInitialDistance, @(gct_maxAllowedInitialDistance), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (CGFloat)gct_maxAllowedInitialDistance {
    return [objc_getAssociatedObject(self, &kGCTMaxAllowedInitialDistance) floatValue];
}
- (UIPanGestureRecognizer *)gct_popPanGesture {
    UIPanGestureRecognizer *gesture = objc_getAssociatedObject(self, &kGCTPopPanGesture);
    if (!gesture) {
        id target = self.interactivePopGestureRecognizer.delegate;
        SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
        gesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:internalAction];
        gesture.delegate = self;
        objc_setAssociatedObject(self, &kGCTPopPanGesture, gesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return gesture;
}
- (void)setGct_popPanGesture:(UIPanGestureRecognizer *)gct_popPanGesture {
    objc_setAssociatedObject(self, &kGCTPopPanGesture, gct_popPanGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (BOOL)_gct_swizzleInstanceMethod:(SEL)originalSelector with:(SEL)newSelector {
    
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, newSelector);
    BOOL didAddMethod =
    class_addMethod(self,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(self,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    return YES;
}
@end

static BOOL _forceHidesBottomBarWhenPush;
@implementation UINavigationController (GCTForceHidesBottomBarWhenPushCategory)
+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _forceHidesBottomBarWhenPush = YES;
        [self _gct_swizzleInstanceMethod:@selector(pushViewController:animated:) with:@selector(gct_pushViewController:animated:)];
    });
}
- (void)gct_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (_forceHidesBottomBarWhenPush) {
        if (self.childViewControllers.count > 0) {
            // 不是栈底控制器, 也就是子控制器
            viewController.hidesBottomBarWhenPushed = YES;
        }
    }
 
    [self gct_pushViewController:viewController animated:animated];
}
+ (void)gct_setForceHidesBottomBarWhenPushEnable:(BOOL)force {
    _forceHidesBottomBarWhenPush = force;
}
+ (BOOL)gct_forceHidesBottomBarWhenPushEnable {
    return _forceHidesBottomBarWhenPush;
}

@end
