//
//  FirstViewViewController.m
//  HYNavigation
//
//  Created by runlhy on 16/9/27.
//  Copyright © 2016年 Pengcent. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#import "FirstViewViewController.h"

@interface FirstViewViewController ()

@end

@implementation FirstViewViewController

- (UIViewController *)getPresentedViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

- (void)viewDidLoad {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width);
    [button addTarget:self action:@selector(dismisVC:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor cyanColor];
    [button setTitle:@"disappear😛" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    [super viewDidLoad];
}
- (void)dismisVC:(UIButton *)button{
    [[self getPresentedViewController] dismissViewControllerAnimated:YES completion:nil];
    
}

@end
