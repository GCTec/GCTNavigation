//
//  UINavigationController+GCTCategory.h
//  GCTNavigationBarDemo
//
//  Created by 罗树新 on 2018/4/7.
//  Copyright © 2018年 GCT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UINavigationController (GCTPopGestureCategory)

/**
 滑动返回的手势
 */
@property (strong, nonatomic, readonly) UIPanGestureRecognizer *gct_popPanGesture;

/**
 是否使全屏滑动返回有效
 默认：YES，即开启全屏滑动返回
 */
@property (nonatomic, assign) BOOL gct_fullScreenPopGesture;

/**
 设置滑动返回的范围，范围内触发滑动返回
 默认：屏幕宽度的一半，即左半屏幕触发
 */
@property (nonatomic, assign) CGFloat gct_maxAllowedInitialDistance;

/**
 强制全部NavigationController滑动返回有效或无效

 @param force 是否开启强制全部NavigationController滑动返回有效或无效
 */
+ (void)gct_setForceAppFullScreenPopEnable:(BOOL)force;

/**
 强制滑动返回是否有效

 @return 强制滑动返回的有效性
 */
+ (BOOL)gct_forceAppFullScreenPopEnable;
@end

@interface UINavigationController (GCTForceHidesBottomBarWhenPushCategory)

/**
 设置是否开启全部 UINavigationController push 新页面时，强制隐藏bottomBar

 @param force 是否强制启用
 */
+ (void)gct_setForceHidesBottomBarWhenPushEnable:(BOOL)force;

/**
 是否开启全部 UINavigationController push 新页面时，强制隐藏bottomBar
 默认：YES
 */
+ (BOOL)gct_forceHidesBottomBarWhenPushEnable;

@end

NS_ASSUME_NONNULL_END
