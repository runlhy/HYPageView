//
//  HYPageView.h
//  HYNavigation
//
//  Created by runlhy on 16/9/27.
//  Copyright © 2016年 Pengcent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYPageView : UIView

//初始化方法
- (instancetype)initWithFrame:(CGRect)frame WithTitles:(NSArray *)titles WithViewControllers:(NSArray *)childViewControllers;

@end
