//
//  GCTNavigationBar.m
//  GCTNavigationBarDemo
//
//  Created by 罗树新 on 2018/3/21.
//  Copyright © 2018年 GCT. All rights reserved.
//

#import "GCTUINavigationBar.h"

static NSMutableDictionary *const _appearanceImagesForStates() {
    static NSMutableDictionary *dic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dic = [[NSMutableDictionary alloc] init];
    });
    return dic;
}
static NSMutableDictionary <NSNumber *,UIColor *> *const _appearanceBarButtonColorsForStates() {
    static NSMutableDictionary *dic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dic = [[NSMutableDictionary alloc] init];
    });
    return dic;
}
@interface GCTUINavigationBar()
@property (nonatomic, strong) UIButton *leftBarButton;
@property (nonatomic, strong) UIButton *rightBarButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIVisualEffectView *backBar;
@property (nonatomic, strong) UIColor *titleViewBackgroundColor;
@property (nonatomic, strong) UIColor *backColor;
@property (nonatomic, strong) NSMutableDictionary <NSNumber *,UIColor *> *barButtonColorsForStates;
@property (nonatomic, strong) NSMutableDictionary *imagesForStates;
@end
@implementation GCTUINavigationBar

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self setDefaultAppearance];
    });
}
+ (void)setDefaultAppearance {
    GCTUINavigationBar *appearance = [GCTUINavigationBar appearance];
    appearance.bottomLineColor = [UIColor clearColor];
    appearance.leftBarButtonEdgeSpace = 10;
    appearance.rightBarButtonEdgeSpace = 10;
    appearance.leftBarButtonType = -1;
    appearance.rightBarButtonType = -1;
    appearance.rightBarButtonType = -1;
    appearance.leftBarButtonFont = [UIFont systemFontOfSize:17];
    appearance.rightBarButtonFont = [UIFont systemFontOfSize:17];
    appearance.titleTextColor = [UIColor colorWithRed:((CGFloat)((0x333333 & 0xff0000) >> 16)) / 255.0 green:((CGFloat)((0x333333 & 0xff00) >> 8)) / 255.0 blue:((CGFloat)(0x333333 & 0xff)) / 255.0 alpha:1.0f];

    appearance.titleFont = [UIFont systemFontOfSize:17];


}
- (instancetype)init {
    if (self = [super init]) {
        [self defaultInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self defaultInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self defaultInit];
    }
    return self;
}
- (void)defaultInit {
    
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.backBar];
    [self addSubview:self.leftBarButton];
    [self addSubview:self.rightBarButton];
    [self addSubview:self.titleLabel];
    [self addSubview:self.bottomLine];
    
    GCTUINavigationBar *appearance = [GCTUINavigationBar appearance];
    
    self.leftBarButtonFont = appearance.leftBarButtonFont;
    self.rightBarButtonFont = appearance.leftBarButtonFont;
    self.titleFont = appearance.titleFont;
    self.titleTextColor = appearance.titleTextColor;
    self.bottomLineColor = appearance.bottomLineColor;
    self.leftBarButtonEdgeSpace = appearance.leftBarButtonEdgeSpace;
    self.rightBarButtonEdgeSpace = appearance.rightBarButtonEdgeSpace;
    self.leftBarButtonType = appearance.leftBarButtonType;
    self.rightBarButtonType = appearance.rightBarButtonType;
    if (appearance.barStyle >= 0) {
        self.barStyle = appearance.barStyle;
    }

}

- (void)setLeftBarButtonType:(GCTUINavigationBarButtonType)leftBarButtonType  {
    [self setImageForBarButtonType:leftBarButtonType controlState:UIControlStateNormal left:YES];
    if (@available(iOS 9.0, *)) {
        [self setImageForBarButtonType:leftBarButtonType controlState:UIControlStateFocused left:YES];
    }
    [self setImageForBarButtonType:leftBarButtonType controlState:UIControlStateDisabled left:YES];
    [self setImageForBarButtonType:leftBarButtonType controlState:UIControlStateSelected left:YES];
 }

- (void)setRightBarButtonType:(GCTUINavigationBarButtonType)rightBarButtonType {
    [self setImageForBarButtonType:rightBarButtonType controlState:UIControlStateNormal left:NO];
    if (@available(iOS 9.0, *)) {
        [self setImageForBarButtonType:rightBarButtonType controlState:UIControlStateFocused left:NO];
    }
    [self setImageForBarButtonType:rightBarButtonType controlState:UIControlStateDisabled left:NO];
    [self setImageForBarButtonType:rightBarButtonType controlState:UIControlStateSelected left:NO];
    [self setImageForBarButtonType:rightBarButtonType controlState:UIControlStateHighlighted left:NO];
}


- (void)setImageForBarButtonType:(GCTUINavigationBarButtonType)barButtonType controlState:(UIControlState)state left:(BOOL)left {
    UIImage *stateImage = [[GCTUINavigationBar appearance] imageForNavigationBarButtonType:barButtonType controlState:state];
    if (stateImage) {
        if (left) {
            [self.leftBarButton setImage:stateImage forState:state];
        } else {
            [self.rightBarButton setImage:stateImage forState:state];
        }
    }
}
- (void)setImage:(UIImage *)image forNavigationBarButtonType:(GCTUINavigationBarButtonType)buttonType controlState:(UIControlState)controlState {
    NSString *key = [NSString stringWithFormat:@"GCTUINavigationBarButtonType_%@_UIControlState_%@",@(buttonType), @(controlState)];
    if (image && key) {
        [_appearanceImagesForStates() setObject:image forKey:key];
    }
}
- (UIImage *)imageForNavigationBarButtonType:(GCTUINavigationBarButtonType)buttonType controlState:(UIControlState)controlState  {
    NSString *key = [NSString stringWithFormat:@"GCTUINavigationBarButtonType_%@_UIControlState_%@",@(buttonType), @(controlState)];
    if (key) {
        return [_appearanceImagesForStates() objectForKey:key];
    }
    return nil;
}

- (void)setBarButtonTextColor:(UIColor *)color forControlState:(UIControlState)controlState {
    NSLog(@"color = %@ - %@", color, _appearanceBarButtonColorsForStates());

    if (color) {
        [_appearanceBarButtonColorsForStates() setObject:color forKey:@(controlState)];
        [self.leftBarButton setTitleColor:color forState:controlState];
        [self.rightBarButton setTitleColor:color forState:controlState];
    } else {
        [_appearanceBarButtonColorsForStates() removeObjectForKey:@(controlState)];
        [self.leftBarButton setTitleColor:nil forState:controlState];
        [self.rightBarButton setTitleColor:nil forState:controlState];
    }
}
- (UIColor *)barButtonTextColorForState:(UIControlState)state {
    if ([_appearanceBarButtonColorsForStates().allKeys containsObject:@(state)]) {
        return [_appearanceBarButtonColorsForStates() objectForKey:@(state)];
    }
    return nil;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _backBar.frame = self.bounds;
    _backBar.backgroundColor = self.backgroundColor;
    
    _backgroundImageView.frame = self.bounds;
    _backgroundImageView.alpha = (_backgroundImageView.image && self.navigationBarStyle == GCTUINavigationBarStyleDefault );
    self.backgroundColor = _backgroundImageView.alpha ? [UIColor clearColor] : self.backColor;
    if (_leftBarButton) {
        self.leftBarButton.frame = CGRectMake(0, CGRectGetHeight([UIApplication sharedApplication].statusBarFrame), 44, 44);
        CGFloat leftWidth = [self titleWidthWithButton:self.leftBarButton];
        if (leftWidth > 0) {
            self.leftBarButton.frame = CGRectMake(self.leftBarButtonEdgeSpace > 0 ? self.leftBarButtonEdgeSpace : 15, CGRectGetHeight([UIApplication sharedApplication].statusBarFrame), leftWidth+2*(self.leftBarButtonEdgeSpace > 0 ? self.leftBarButtonEdgeSpace : 15), 44);
        }
    }
    if (_rightBarButton) {
        self.rightBarButton.frame = CGRectMake(CGRectGetWidth(self.bounds) - 44, CGRectGetHeight([UIApplication sharedApplication].statusBarFrame), 44, 44);
        
        CGFloat rightWidth = [self titleWidthWithButton:self.rightBarButton];
        
        if (rightWidth > 0) {
            self.rightBarButton.frame = CGRectMake(CGRectGetWidth(self.bounds) - rightWidth - 2* (self.leftBarButtonEdgeSpace > 0 ? self.leftBarButtonEdgeSpace : 15), CGRectGetHeight([UIApplication sharedApplication].statusBarFrame), rightWidth + 2*(self.leftBarButtonEdgeSpace > 0 ? self.leftBarButtonEdgeSpace : 15), 44);
        }
    }
    self.titleLabel.frame = CGRectMake(64, CGRectGetHeight([UIApplication sharedApplication].statusBarFrame) + 7, CGRectGetWidth(self.bounds) - 128, 30);
    self.bottomLine.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - 0.5, CGRectGetWidth(self.bounds), 0.5);
    
    if (_titleView) {
        self.titleView.center = self.titleLabel.center;
        [self insertSubview:self.bottomLine belowSubview:self.titleView];
    }
}
#pragma mark -- Setter/Getter
- (void)setNavigationBarStyle:(GCTUINavigationBarStyle)navigationBarStyle {
    _navigationBarStyle = navigationBarStyle;
    switch (navigationBarStyle) {
        case GCTUINavigationBarStyleDefault:
        {
            self.backgroundColor = self.backColor;
            self.backgroundImageView.alpha = self.backgroundImageView.image ? 1 : 0;
            self.titleLabel.backgroundColor = [UIColor clearColor];
            self.titleView.backgroundColor = self.titleViewBackgroundColor;
            break;
        }
        case GCTUINavigationBarStyleOnlyItem:
        {
            self.titleViewBackgroundColor = self.titleView.backgroundColor;
            self.backgroundImageView.alpha = 0;
            self.backgroundColor = [UIColor clearColor];
            self.titleView.backgroundColor = [UIColor clearColor];
            break;
        }
    }
}
- (void)setBarStyle:(UIBarStyle)barStyle {
    if (barStyle < 0) {
        return;
    }
    UIBlurEffect *effet = nil;
    switch (barStyle) {
        case UIBarStyleDefault:
        {
            effet = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        }
            break;
        case UIBarStyleBlack:
        {
            effet = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        }
            break;
        case UIBarStyleBlackTranslucent:
        {
            effet = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        }
            break;
            
    }
    _backBar.effect = effet;
    _backBar.alpha = self.navigationBarStyle == GCTUINavigationBarStyleDefault;
}
- (void)setAlpha:(CGFloat)alpha {
    [super setAlpha:alpha];
    switch (self.navigationBarStyle) {
        case GCTUINavigationBarStyleDefault:
        {
            self.backBar.alpha = 1;
            self.backgroundImageView.alpha = 1;
            self.alpha = 1;
        }
            break;
        case GCTUINavigationBarStyleOnlyItem:
        {
            self.alpha = 0;
            self.backBar.alpha = 0;
            self.backgroundImageView.alpha = 0;
            self.leftBarButton.alpha = 1;
            self.rightBarButton.alpha = 1;
            self.titleLabel.alpha = 1;
            self.titleView.alpha = 1;
        }
            break;
    }
}
- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    self.backColor = backgroundColor;
}
- (void)setBottomLineColor:(UIColor *)bottomLineColor {
    _bottomLineColor = bottomLineColor;
    if (bottomLineColor) {
        self.bottomLine.backgroundColor = _bottomLineColor;
    }
}
- (void)setTitleView:(UIView *)titleView {
    if (_titleView) {
        [_titleView removeFromSuperview];
    }
    _titleView = titleView;
    if (_titleView) {
        [self addSubview:_titleView];
    }
}

- (UIButton *)leftBarButton {
    if (!_leftBarButton) {
        _leftBarButton = [[UIButton alloc] init];
        [_leftBarButton setTitleColor:[UIColor colorWithRed:((CGFloat)((0x333333 & 0xff0000) >> 16)) / 255.0 green:((CGFloat)((0x333333 & 0xff00) >> 8)) / 255.0 blue:((CGFloat)(0x333333 & 0xff)) / 255.0 alpha:1.0f] forState:UIControlStateNormal];
        [_leftBarButton setTitleColor:[UIColor colorWithRed:((CGFloat)((0x939393 & 0xff0000) >> 16)) / 255.0 green:((CGFloat)((0x939393 & 0xff00) >> 8)) / 255.0 blue:((CGFloat)(0x939393 & 0xff)) / 255.0 alpha:1.0f] forState:UIControlStateHighlighted];
    }
    return _leftBarButton;
}
- (void)setLeftBarButtonFont:(UIFont *)leftBarButtonFont {
    _leftBarButtonFont = leftBarButtonFont;
    self.leftBarButton.titleLabel.font = leftBarButtonFont;
}

- (UIButton *)rightBarButton {
    if (!_rightBarButton) {
        _rightBarButton = [[UIButton alloc] init];
        [_rightBarButton setTitleColor:[UIColor colorWithRed:((CGFloat)((0x333333 & 0xff0000) >> 16)) / 255.0 green:((CGFloat)((0x333333 & 0xff00) >> 8)) / 255.0 blue:((CGFloat)(0x333333 & 0xff)) / 255.0 alpha:1.0f] forState:UIControlStateNormal];
        [_rightBarButton setTitleColor:[UIColor colorWithRed:((CGFloat)((0x939393 & 0xff0000) >> 16)) / 255.0 green:((CGFloat)((0x939393 & 0xff00) >> 8)) / 255.0 blue:((CGFloat)(0x939393 & 0xff)) / 255.0 alpha:1.0f] forState:UIControlStateHighlighted];
    }
    return _rightBarButton;
}
- (void)setRightBarButtonFont:(UIFont *)rightBarButtonFont {
    _rightBarButtonFont = rightBarButtonFont;
    self.rightBarButton.titleLabel.font = rightBarButtonFont;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    self.titleLabel.font = titleFont;
}
- (void)setTitleTextColor:(UIColor *)titleTextColor {
    _titleTextColor = titleTextColor;
    self.titleLabel.textColor = titleTextColor;
}
- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor clearColor];
    }
    return _bottomLine;
}
- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.alpha = 0;
    }
    return _backgroundImageView;
}
- (UIVisualEffectView *)backBar {
    if (!_backBar) {
        _backBar = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        _backBar.alpha = 0;
    }
    return _backBar;
}
- (CGFloat)titleWidthWithButton:(UIButton *)button {
    NSString *title = [button titleForState:button.state];
    if (title.length > 0) {
        UIFont *font = button.titleLabel.font;
        CGFloat width = [title boundingRectWithSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds)/2.f, 44) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size.width;
        return width;
    }
    return 0;
}


@end
