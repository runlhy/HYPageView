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
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    @[@"One",@"Two",@"Three",@"Four",@"Five",@"Six"]
//    @[@"个性推介",@"歌单",@"主播电台"]
//    @[@"精选",@"片库",@"电影",@"韩剧",@"德云社",@"动漫",@"电视剧",@"纪录片"]
//    @[@"头条",@"精选",@"新好声音"]
    
    HYPageView *pageView = [[HYPageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withTitles:@[@"头条",@"精选",@"新好声音"] withViewControllers:@[@"FirstViewViewController",@"FirstViewViewController",@"FirstViewViewController",@"FirstViewViewController",@"FirstViewViewController",@"FirstViewViewController"] withParameters:@[@"123",@"这是一片很寂寞的天"]];
//    pageView.isAnimated = YES;
    
    pageView.selectedColor = [UIColor blueColor];
    pageView.unselectedColor = [UIColor blackColor];
    pageView.font = [UIFont systemFontOfSize:20];
//    pageView.font = [UIFont fontWithName:@"奇思古粗废墟体" size:20];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setImage:[UIImage imageNamed:@"search_"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 50, 40);
    [button setTintColor:[UIColor blackColor]];
    button.transform = CGAffineTransformMakeScale(.7, .7);
    pageView.leftButton = button;
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button2 setImage:[UIImage imageNamed:@"more_"] forState:UIControlStateNormal];
    button2.frame = CGRectMake(0, 0, 50, 40);
    [button2 setTintColor:[UIColor blackColor]];
    button2.transform = CGAffineTransformMakeScale(.5, .5);
    pageView.rightButton = button2;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:pageView];
    
    
}
@end
