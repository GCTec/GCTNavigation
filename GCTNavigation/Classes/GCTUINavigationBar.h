//
//  GCTUINavigationBar.h
//  GCTUINavigationBarDemo
//
//  Created by 罗树新 on 2018/3/21.
//  Copyright © 2018年 GCT. All rights reserved.
//

#import <UIKit/UIKit.h>

///按钮类型，图片设置根据GCTNavigationBarSourceBundle.bundle内图片文件设置
typedef NS_ENUM(NSInteger, GCTUINavigationBarButtonType) {
    GCTUINavigationBarButtonTypeBack,   //  返回
    GCTUINavigationBarButtonTypeClose,  //  关闭
    GCTUINavigationBarButtonTypeList,   //  列表
    GCTUINavigationBarButtonTypeSearch, //  搜索
    GCTUINavigationBarButtonTypeDelete, //  删除
    GCTUINavigationBarButtonTypeScan,   //  扫描
    GCTUINavigationBarButtonTypeSet,    //  设置
    GCTUINavigationBarButtonTypeShare,  //  分享
    GCTUINavigationBarButtonTypeMore,   //  更多
    GCTUINavigationBarButtonTypeWrite,  //  书写
    GCTUINavigationBarButtonTypeRefresh,//  刷新
    GCTUINavigationBarButtonTypeAdd
};

/**
 navigationBar样式
 
 - GCTUINavigationBarStyleDefault: 默认样式，全部显示
 - GCTUINavigationBarStyleOnlyItem: 只显示item的样式
 */
typedef NS_ENUM(NSInteger, GCTUINavigationBarStyle) {
    GCTUINavigationBarStyleDefault,
    GCTUINavigationBarStyleOnlyItem
};
@interface GCTUINavigationBar : UIView


/**
 左侧按钮
 */
@property (nonatomic, strong, readonly) UIButton *leftBarButton;

/**
 左侧文字字体
 */
@property (nonatomic, strong) UIFont *leftBarButtonFont UI_APPEARANCE_SELECTOR;

/**
 右侧按钮
 */
@property (nonatomic, strong, readonly) UIButton *rightBarButton;

/**
 右侧文字字体
 */
@property (nonatomic, strong) UIFont *rightBarButtonFont UI_APPEARANCE_SELECTOR;

/**
 标题label
 */
@property (nonatomic, strong, readonly) UILabel *titleLabel;

/**
 设置标题的文字颜色
 */
@property (nonatomic, strong) UIColor *titleTextColor UI_APPEARANCE_SELECTOR;

/**
 设置标题的字体
 */
@property (nonatomic, strong) UIFont *titleFont UI_APPEARANCE_SELECTOR;

/**
 指定设置头视图view
 */
@property (nonatomic, strong) UIView *titleView;

/**
 底部边缘线的颜色
 */
@property (nonatomic, strong) UIColor *bottomLineColor UI_APPEARANCE_SELECTOR;

/**
 左侧按钮边距
 */
@property (nonatomic, assign) CGFloat leftBarButtonEdgeSpace UI_APPEARANCE_SELECTOR;

/**
 右侧按钮边距
 */
@property (nonatomic, assign) CGFloat rightBarButtonEdgeSpace UI_APPEARANCE_SELECTOR;

/**
 navigationBar的样式
 */
@property (nonatomic, assign) GCTUINavigationBarStyle navigationBarStyle UI_APPEARANCE_SELECTOR;

/**
 设置背景图片视图
 */
@property (nonatomic, strong, readonly) UIImageView *backgroundImageView;

/**
 navigationBar的样式
 */
@property (nonatomic, assign) UIBarStyle barStyle UI_APPEARANCE_SELECTOR;

/**
 左侧按钮类型
 */
@property (nonatomic, assign) GCTUINavigationBarButtonType leftBarButtonType;

/**
 右侧按钮类型
 */
@property (nonatomic, assign) GCTUINavigationBarButtonType rightBarButtonType;

/**
 设置 naigationBar 不同类型、不同状态下的图片

 @param image 按钮图片
 @param buttonType 按钮类型
 @param controlState 按钮状态
 */
- (void)setImage:(UIImage *)image forNavigationBarButtonType:(GCTUINavigationBarButtonType)buttonType controlState:(UIControlState)controlState UI_APPEARANCE_SELECTOR;

/**
 navigationBar 不同类型、不同状态下的图片

 @param buttonType 按钮类型
 @param controlState 按钮状态
 @return 图片
 */
- (UIImage *)imageForNavigationBarButtonType:(GCTUINavigationBarButtonType)buttonType controlState:(UIControlState)controlState;

/**
 设置不同状态下的按钮字体颜色

 @param color 字体颜色
 @param controlState 按钮状态
 */
- (void)setBarButtonTextColor:(UIColor *)color forControlState:(UIControlState)controlState UI_APPEARANCE_SELECTOR;

@end
