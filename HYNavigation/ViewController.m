//
//  ViewController.m
//  HYNavigation
//
//  Created by runlhy on 16/9/26.
//  Copyright © 2016年 Pengcent. All rights reserved.
//

#import "ViewController.h"
#import "HYPageView.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HYPageView *pageView = [[HYPageView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT) WithTitles:@[@"个性推介asdfasdf",@"歌单",@"主播电asdf台",@"排行榜",@"哦",@"欲罢不能"] WithViewControllers:@[@"FirstViewViewController",@"FirstViewViewController",@"FirstViewViewController",@"FirstViewViewController",@"FirstViewViewController",@"FirstViewViewController"]];
    [self.view addSubview:pageView];
    
    
}
@end
