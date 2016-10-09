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

- (void)loadView{
    [super loadView];
    UIScrollView *view = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    view.contentSize = CGSizeMake(view.bounds.size.width, 1000);
    
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    UIColor *randomColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    UIView *redView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    redView.backgroundColor = randomColor;
    [view addSubview:redView];
    //view.backgroundColor = randomColor;
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.parameter);
}

@end
