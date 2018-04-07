//
//  UIViewController+GCTNavigationBarCategory.h
//  GCTNavigationBarDemo
//
//  Created by 罗树新 on 2018/4/7.
//  Copyright © 2018年 GCT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GCTUINavigationBar;
NS_ASSUME_NONNULL_BEGIN
@interface UIViewController (GCTUINavigationBarCategory)

/**
 ViewController的navigationBar控件，可通过该控件配置相关属性
 注意：VC需要遵循 GCTUINavigationBarProtcol 协议
 */
@property (nonatomic, strong, readonly) GCTUINavigationBar *navigationBar;

/**
 是否隐藏navigationBar
 */
@property(nonatomic, assign,getter=isNavigationBarHidden) BOOL navigationBarHidden;
@end

#pragma mark -- GCTUINavigationBar协议
/**
 GCTUINavigationBar协议。遵循该协议的VC，会创建 GCTUINavigationBar *navigationBar;
 */
@protocol GCTUINavigationBarProtcol <NSObject>
@optional

/**
 左侧点击事件

 @param leftBarButton 左侧按钮
 */
- (void)leftBarButtonClicked:(UIButton *)leftBarButton;

/**
 右侧点击事件

 @param rightBarButton 右侧按钮
 */
- (void)rightBarButtonClicked:(UIButton *)rightBarButton;
@end
NS_ASSUME_NONNULL_END
