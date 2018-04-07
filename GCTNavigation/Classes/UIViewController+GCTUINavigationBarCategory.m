//
//  UIViewController+GCTUINavigationBarCategory.m
//  GCTNavigationBarDemo
//
//  Created by 罗树新 on 2018/4/7.
//  Copyright © 2018年 GCT. All rights reserved.
//

#import "UIViewController+GCTUINavigationBarCategory.h"
#import "GCTUINavigationBar.h"
#import <objc/runtime.h>

static NSString *const kGCTNavigationBar = @"com.geekcode.kGCTNavigationBar";

@interface UIViewController ()
@property (nonatomic, strong) GCTUINavigationBar *navigationBar;
@end
@implementation UIViewController (GCTUINavigationBarCategory)
+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self _gct_swizzleInstanceMethod:@selector(viewDidLoad) with:@selector(_gct_viewDidLoad)];
        [self _gct_swizzleInstanceMethod:@selector(viewDidLayoutSubviews) with:@selector(_gct_viewDidLayoutSubviews)];
        [self _gct_swizzleInstanceMethod:@selector(setTitle:) with:@selector(_gct_setTitle:)];
    });
}
- (void)_gct_viewDidLoad {
    if ([self checkGCTUINavigationBarCanUse]) {
        self.navigationController.navigationBarHidden = YES;
        if ([self.navigationBar isKindOfClass:[GCTUINavigationBar class]]) {
            [self.navigationBar.leftBarButton addTarget:self action:@selector(leftBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.navigationBar.rightBarButton addTarget:self action:@selector(rightBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:self.navigationBar];
            
        }
    }
    [self _gct_viewDidLoad];
}

- (void)_gct_viewDidLayoutSubviews {
    [self _gct_viewDidLayoutSubviews];
    if ([self checkGCTUINavigationBarCanUse]) {
        
        if ([self.navigationBar isKindOfClass:[GCTUINavigationBar class]]) {
            self.navigationBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight([UIApplication sharedApplication].statusBarFrame) + 44);
        }
        
    }
}
-(void)_gct_setTitle:(NSString *)title {
    [self _gct_setTitle:title];
    if ([self checkGCTUINavigationBarCanUse]) {
        self.navigationBar.titleLabel.text = title;
    }
}

- (BOOL)checkGCTUINavigationBarCanUse {
    return (![self isKindOfClass:[UINavigationController class]]) && [self conformsToProtocol:@protocol(GCTUINavigationBarProtcol)];
}
- (void)setNavigationBarHidden:(BOOL)navigationBarHidden {
    if ([self checkGCTUINavigationBarCanUse]) {
        self.navigationBar.hidden = navigationBarHidden;
    }
}
- (BOOL)isNavigationBarHidden {
    if ([self checkGCTUINavigationBarCanUse]) {
        
        return self.navigationBar.hidden;
    }
    return YES;
}
- (void)leftBarButtonClicked:(UIButton *)leftBarButton {
    
}
- (void)rightBarButtonClicked:(UIButton *)rightBarButton {
    
}
- (GCTUINavigationBar *)navigationBar {
    GCTUINavigationBar *bar = objc_getAssociatedObject(self, &kGCTNavigationBar);
    if (!bar) {
        bar = [[GCTUINavigationBar alloc] init];
        objc_setAssociatedObject(self, &kGCTNavigationBar, bar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if ([self conformsToProtocol:@protocol(GCTUINavigationBarProtcol)]) {
        return bar;
    }
    return nil;
}
- (void)setNavigationBar:(GCTUINavigationBar *)navigationBar {
    objc_setAssociatedObject(self, &kGCTNavigationBar, navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
