//
//  HYPageView.h
//  HYNavigation
//
//  Created by runlhy on 16/9/27.
//  Copyright © 2016年 Pengcent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYPageView : UIScrollView

@property (strong, nonatomic) UIColor *selectedColor;
@property (strong, nonatomic) UIColor *unselectedColor;
@property (strong, nonatomic) UIColor *topTabBottomLineColor;

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, assign) BOOL isTranslucent;
/**
 是否平均排布按钮，只在一页可以放下所有按钮时有效
 */
@property (nonatomic, assign) BOOL isAverage;


//初始化方法
- (instancetype)initWithFrame:(CGRect)frame WithTitles:(NSArray *)titles WithViewControllers:(NSArray *)childViewControllers;

@end
