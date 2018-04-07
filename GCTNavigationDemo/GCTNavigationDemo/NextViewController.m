//
//  NextViewController.m
//  GCTNavigationDemo
//
//  Created by 罗树新 on 2018/4/7.
//  Copyright © 2018年 RRC. All rights reserved.
//

#import "NextViewController.h"
#import "GCTNavigation.h"
@interface NextViewController ()<GCTUINavigationBarProtcol>

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Next";
    self.navigationBar.leftBarButtonType = GCTUINavigationBarButtonTypeBack;
    [self.navigationBar.leftBarButton setTitle:@"返回" forState:UIControlStateNormal];
}

- (void)leftBarButtonClicked:(UIButton *)leftBarButton {
    NSLog(@"%@ left clicked", NSStringFromClass(self.class));
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
