//
//  HYPageView.m
//  HYNavigation
//
//  Created by runlhy on 16/9/27.
//  Copyright © 2016年 Pengcent. All rights reserved.
//

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define TOP_SPACE 20
#define LEFT_SPACE 0
#define RIGHT_SPACE 0



#define MIN_SPACING 20
#define TAB_HEIGHT 40


#define LINEBOTTOM_HEIGHT 3
#define TOPBOTTOMLINEBOTTOM_HEIGHT 1


#define SELECTED_COLOR [UIColor colorWithRed:65/255.0 green:105/255.0 blue:225/255.0 alpha:1.0]
#define UNSELECTED_COLOR [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]

#define TPOTABBOTTOMLINE_COLOR [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]

#import "HYPageView.h"

@interface HYPageView () <UIScrollViewDelegate>

@property (strong, nonatomic) UIView       *topTabView;
@property (strong, nonatomic) UIScrollView *topTabScrollView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (assign, nonatomic) NSInteger    currentPage;

@end

@implementation HYPageView{
    
    CGRect _selfFrame;
    NSInteger _topTabScrollViewWidth;
    
    NSArray        <NSString *> *_titles;
    NSMutableArray *_viewControllers;
    UIView         *_lineBottom;
    NSMutableArray *_titleButtons;
    NSMutableArray *_titleSizeArray;
    NSMutableArray *_centerPoints;
    
    NSMutableArray *_width_k_array;
    NSMutableArray *_width_b_array;
    NSMutableArray *_point_k_array;
    NSMutableArray *_point_b_array;
    
    UIColor *__selectedColor;
    UIColor *__unselectedColor;
    
    UIViewController *_viewController;
}

- (void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor = selectedColor;
    __selectedColor = selectedColor;
    _lineBottom.backgroundColor = selectedColor;
    [self updateSelectedPage:0];
}

- (void)setUnselectedColor:(UIColor *)unselectedColor{
    _unselectedColor = unselectedColor;
    __unselectedColor = unselectedColor;
    [self updateSelectedPage:0];
}

- (void)setTopTabBottomLineColor:(UIColor *)topTabBottomLineColor{
    _topTabBottomLineColor = topTabBottomLineColor;
}

- (instancetype)initWithFrame:(CGRect)frame WithTitles:(NSArray *)titles WithViewControllers:(NSArray *)childViewControllers{
    self = [super initWithFrame:frame];
    if (self) {
        _selfFrame = frame;
        __selectedColor = SELECTED_COLOR;
        __unselectedColor = UNSELECTED_COLOR;
        _titles = titles;
        _viewControllers = [NSMutableArray arrayWithArray:childViewControllers];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _viewController = [self viewController];
    
    
    [self addSubview:self.scrollView];
    [self addSubview:self.topTabView];
    [self addSubview:self.topTabScrollView];
    [self addObserver:self forKeyPath:@"currentPage" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    
    self.currentPage = 0;
    
    NSLog(@"layoutSubviews");
}


- (UIView *)topTabView
{
    if (!_topTabView){
        
        CGRect frame = CGRectMake(0, 0, _selfFrame.size.width, TAB_HEIGHT+TOP_SPACE);
        _topTabView = [[UIView alloc] initWithFrame:frame];
        if (_isTranslucent) {
            UIToolbar *backView = [[UIToolbar alloc] initWithFrame:_topTabView.bounds];
            backView.barStyle = UIBarStyleDefault;
            [_topTabView addSubview:backView];
        }
        
        if (self.leftButton) {
            self.leftButton.center = CGPointMake(self.leftButton.bounds.size.width/2, TAB_HEIGHT/2 + TOP_SPACE);
            [_topTabView addSubview:self.leftButton];
        }
        if (self.rightButton) {
            self.rightButton.center = CGPointMake(_selfFrame.size.width- self.leftButton.bounds.size.width/2, TAB_HEIGHT/2 + TOP_SPACE);
            [_topTabView addSubview:self.rightButton];
        }
        
        //创建tabTop下方总览线
        UIView *topTabBottomLine = [UIView new];
        topTabBottomLine.frame = CGRectMake(0, TAB_HEIGHT + TOP_SPACE - TOPBOTTOMLINEBOTTOM_HEIGHT, _selfFrame.size.width, TOPBOTTOMLINEBOTTOM_HEIGHT);
        topTabBottomLine.backgroundColor = TPOTABBOTTOMLINE_COLOR;
        [_topTabView addSubview:topTabBottomLine];
    }
    return _topTabView;
}

- (UIScrollView *)topTabScrollView
{
    if (!_topTabScrollView){
        
        CGFloat leftWidth = 0;
        CGFloat rightWidth = 0;
        if (self.leftButton) {
            leftWidth = self.leftButton.bounds.size.width;
        }
        if (self.rightButton) {
            rightWidth = self.rightButton.bounds.size.width;
        }
        
        _topTabScrollViewWidth = _selfFrame.size.width - leftWidth - rightWidth;
        
        CGRect frame = CGRectMake(leftWidth, TOP_SPACE, _topTabScrollViewWidth, TAB_HEIGHT);
        
        _topTabScrollView = [[UIScrollView alloc] initWithFrame:frame];
        _topTabScrollView.showsHorizontalScrollIndicator = NO;
        
        
        
//        _topTabScrollView.backgroundColor = [UIColor whiteColor];
        _topTabScrollView.alwaysBounceHorizontal = YES;
        
        CGFloat totalWidth = 0;
        _titleSizeArray = [NSMutableArray array];
        CGFloat equalX = LEFT_SPACE;
        NSMutableArray *equalIntervals = [NSMutableArray array];
        
        for (NSInteger i=0; i<_titles.count; i++) {
            CGSize titleSize = [_titles[i] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
            [_titleSizeArray addObject:[NSValue valueWithCGSize:titleSize]];
            totalWidth += titleSize.width;
            [equalIntervals addObject:[NSNumber numberWithFloat:(equalX + titleSize.width/2)]];
            equalX += MIN_SPACING + titleSize.width;
        }
        
        CGFloat dividend = _titles.count>1?_titles.count-1:1;
        
        CGFloat minWidth = (_topTabScrollViewWidth - totalWidth - LEFT_SPACE - RIGHT_SPACE) / dividend;
        CGFloat averageX = LEFT_SPACE;
        
        if (_isAverage) {
            minWidth = (_topTabScrollViewWidth - totalWidth) / (_titles.count + 1);
            averageX = minWidth;
        }
        NSMutableArray *averageIntervals = [NSMutableArray array];
        for (NSInteger i=0; i<_titles.count; i++) {
            [averageIntervals addObject:[NSNumber numberWithDouble:(averageX + [_titleSizeArray[i] CGSizeValue].width/2)]];
            averageX += minWidth + [_titleSizeArray[i] CGSizeValue].width;
        }
        
        //确定当前宽能否放下，继而确定等间距排布，还是均匀排布
        totalWidth += (_titles.count - 1) * MIN_SPACING + LEFT_SPACE + RIGHT_SPACE;
        
        NSMutableArray *centerPoints = [NSMutableArray array];
        
        if (totalWidth > _topTabScrollViewWidth){
            centerPoints = equalIntervals;
        }else{
            centerPoints = averageIntervals;
            totalWidth = _topTabScrollViewWidth;
        }
        _centerPoints = centerPoints;
        NSLog(@"centerPoints %@ %@",centerPoints,_titleSizeArray);
        
        _width_k_array = [NSMutableArray array];
        _width_b_array = [NSMutableArray array];
        _point_k_array = [NSMutableArray array];
        _point_b_array = [NSMutableArray array];
        
        for (NSInteger i=0; i<_titles.count-1; i++) {
            CGFloat k = ([_centerPoints[i+1] floatValue] - [_centerPoints[i] floatValue])/_selfFrame.size.width;
            CGFloat b = [_centerPoints[i] floatValue] - k * i * _selfFrame.size.width;
            [_width_k_array addObject:[NSNumber numberWithFloat:k]];
            [_width_b_array addObject:[NSNumber numberWithFloat:b]];
        }
        for (NSInteger i=0; i<_titles.count-1; i++) {
            CGFloat k = ([_titleSizeArray[i+1] CGSizeValue].width - [_titleSizeArray[i] CGSizeValue].width)/_selfFrame.size.width;
            CGFloat b = [_titleSizeArray[i] CGSizeValue].width - k * i * _selfFrame.size.width;
            
            [_point_k_array addObject:[NSNumber numberWithFloat:k]];
            [_point_b_array addObject:[NSNumber numberWithFloat:b]];
        }
        
        _topTabScrollView.contentSize = CGSizeMake(totalWidth, 0);
        
        _titleButtons = [NSMutableArray array];
        for (NSInteger i=0; i<_titles.count; i++) {
            UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
            titleButton.tag = i;
            [_titleButtons addObject:titleButton];
            titleButton.titleLabel.font = [UIFont systemFontOfSize:16];
            
            [titleButton setTitle:_titles[i] forState:UIControlStateNormal];
            
            CGFloat x = [_centerPoints[i] floatValue];
            CGFloat width = [_titleSizeArray[i] CGSizeValue].width;
            
            CGRect buttonFrame = CGRectMake(x-width/2, 0, width, TAB_HEIGHT);
            //标签位置
            titleButton.frame = buttonFrame;
            [_topTabScrollView addSubview:titleButton];
            
            //添加点击事件
            [titleButton addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        [self updateSelectedPage:0];
        
        UIView *topTabBottomLine = [UIView new];
        topTabBottomLine.frame = CGRectMake(-totalWidth, TAB_HEIGHT - TOPBOTTOMLINEBOTTOM_HEIGHT, totalWidth*3, TOPBOTTOMLINEBOTTOM_HEIGHT);
        topTabBottomLine.backgroundColor = TPOTABBOTTOMLINE_COLOR;
        [_topTabScrollView addSubview:topTabBottomLine];
        //创建选中移动线
        _lineBottom = [[UIView alloc] initWithFrame:CGRectMake(0, TAB_HEIGHT - LINEBOTTOM_HEIGHT,[_titleSizeArray[0] CGSizeValue].width, LINEBOTTOM_HEIGHT)];
        _lineBottom.center = CGPointMake([centerPoints[0] floatValue], _lineBottom.center.y);
        _lineBottom.backgroundColor = __selectedColor;
        [_topTabScrollView addSubview:_lineBottom];
    }
    return _topTabScrollView;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        
        CGFloat y = 0;
        if (_viewController.navigationController) {
            y = -64;
        }
        
        _scrollView.frame = CGRectMake(0, y, _selfFrame.size.width, _selfFrame.size.height);
        _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.contentSize = CGSizeMake(_selfFrame.size.width * _titles.count, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = YES;
        //        _scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    }
    return _scrollView;
}

- (CGFloat)getTitleWidth:(CGFloat)offset{
    NSInteger index = (NSInteger)(offset / _selfFrame.size.width);
    CGFloat k = [_width_k_array[index] floatValue];
    CGFloat b = [_width_b_array[index] floatValue];
    CGFloat x = offset;
    return  k * x + b;
}
- (CGFloat)getTitlePoint:(CGFloat)offset{
    NSInteger index = (NSInteger)(offset / _selfFrame.size.width);
    CGFloat k = [_point_k_array[index] floatValue];
    CGFloat b = [_point_b_array[index] floatValue];
    CGFloat x = offset;
    return  k * x + b;
}


- (void)touchAction:(UIButton *)button {
    [_scrollView setContentOffset:CGPointMake(_selfFrame.size.width * button.tag, 0) animated:YES];
    self.currentPage = (_selfFrame.size.width * button.tag + _selfFrame.size.width / 2) / _selfFrame.size.width;
    
}

#pragma mark - UIScrollViewDelegate

//开始减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.currentPage = (NSInteger)((scrollView.contentOffset.x + _selfFrame.size.width / 2) / _selfFrame.size.width);
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
}
//滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.x<=0 || scrollView.contentOffset.x >= _selfFrame.size.width * (_titles.count-1)) {
        return;
    }
    
    _lineBottom.center = CGPointMake([self getTitleWidth:scrollView.contentOffset.x], _lineBottom.center.y);
    
    _lineBottom.bounds = CGRectMake(0, 0, [self getTitlePoint:scrollView.contentOffset.x], LINEBOTTOM_HEIGHT);
    
    CGFloat page = (NSInteger)((scrollView.contentOffset.x + _selfFrame.size.width / 2) / _selfFrame.size.width);
    [self updateSelectedPage:page];
    
}

- (void)updateSelectedPage:(NSInteger)page{
    for (UIButton *button in _titleButtons) {
        if (button.tag == page) {
            [button setTitleColor:__selectedColor forState:UIControlStateNormal];
//            [UIView animateWithDuration:0.3 animations:^{
//                button.transform = CGAffineTransformMakeScale(1.1, 1.1);
//            }];
        }else{
            [button setTitleColor:__unselectedColor forState:UIControlStateNormal];
//            [UIView animateWithDuration:0.3 animations:^{
//                button.transform = CGAffineTransformIdentity;
//            }];
        }
    }
}

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"currentPage"]) {

        NSInteger page = [change[@"new"] integerValue];
        
        CGFloat offset = [_centerPoints[page] floatValue];
        if (offset < _topTabScrollViewWidth/2) {
            [_topTabScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }else if(offset+_topTabScrollViewWidth/2 <_topTabScrollView.contentSize.width) {
            [_topTabScrollView setContentOffset:CGPointMake(offset-_topTabScrollViewWidth/2, 0) animated:YES];
        }else{
            [_topTabScrollView setContentOffset:CGPointMake(_topTabScrollView.contentSize.width-_topTabScrollViewWidth, 0) animated:YES];
        }
        
        for (NSInteger i=0; i<_viewControllers.count; i++) {
            if (page == i) {
                NSString *className = _viewControllers[page];
                //Create only once
                if ([className isEqualToString:@"HYPAGEVIEW_AlreadyCreated"]) {
                    return;
                }
                Class class = NSClassFromString(className);
                UIViewController *viewController = class.new;
                
                UIScrollView *view = (UIScrollView *)viewController.view;
                
                
                view.frame = CGRectMake(_selfFrame.size.width * i, 0, _selfFrame.size.width, _scrollView.bounds.size.height);
                
                CGFloat offset = TOP_SPACE + TAB_HEIGHT;
                if (_viewController.navigationController) {
                    offset += 64;
                }
                
                
                view.contentInset = UIEdgeInsetsMake(offset, 0, 0, 0);
                view.contentOffset = CGPointMake(0,-offset);
                
                [_scrollView addSubview:viewController.view];
                _viewControllers[page] = @"HYPAGEVIEW_AlreadyCreated";
                
            }
        }
    }
}
@end
