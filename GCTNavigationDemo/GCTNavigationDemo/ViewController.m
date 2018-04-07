//
//  ViewController.m
//  GCTNavigationDemo
//
//  Created by 罗树新 on 2018/4/7.
//  Copyright © 2018年 GCT. All rights reserved.
//

#import "ViewController.h"
#import "GCTNavigation.h"
#import "NextViewController.h"

@interface ViewController ()<GCTUINavigationBarProtcol>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试";
}

- (void)leftBarButtonClicked:(UIButton *)leftBarButton {
    NSLog(@"leftClicked");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NextViewController *nextVC = [[NextViewController alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
