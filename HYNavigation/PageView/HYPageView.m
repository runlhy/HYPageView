//
//  HYPageView.m
//  HYNavigation
//
//  Created by runlhy on 16/9/27.
//  Copyright © 2016年 Pengcent. All rights reserved.
//

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define MIN_WIDTH 20
#define TAB_HEIGHT 40
#define LINEBOTTOM_HEIGHT 3
#define SELECTED_COLOR [UIColor colorWithRed:65/255.0 green:105/255.0 blue:225/255.0 alpha:1.0]
#define UNSELECTED_COLOR [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]
#define TPOTABBOTTOMLINE_COLOR [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]

#import "HYPageView.h"

@interface HYPageView () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *topTabScrollView;

@property (strong, nonatomic) UIScrollView *scrollView;

@property (assign, nonatomic) NSInteger currentPage;

@end

@implementation HYPageView{
    
    NSArray <NSString *> *_titles;
    NSArray *_viewControllers;
    UIView  *_lineBottom;
    NSMutableArray *_titleButtons;
    NSMutableArray *_titleSizeArray;
    NSMutableArray *_centerPoints;
    CGFloat _contentOffset_x;

}

- (instancetype)initWithFrame:(CGRect)frame WithTitles:(NSArray *)titles WithViewControllers:(NSArray *)childViewControllers{
    self = [super initWithFrame:frame];
    if (self) {
        _titles = titles;
        _viewControllers = childViewControllers;
        [self addSubview:self.topTabScrollView];
        [self addSubview:self.scrollView];
        
        [self addObserver:self forKeyPath:@"currentPage" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
        self.currentPage = 0;
        
    }
    return self;
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0, TAB_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - 60);
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * _titles.count, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = YES;
//        _scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    }
    return _scrollView;
}

- (UIScrollView *)topTabScrollView
{
    if (!_topTabScrollView){
        _topTabScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        _topTabScrollView.backgroundColor = [UIColor whiteColor];
        _topTabScrollView.alwaysBounceHorizontal = YES;
        
        CGFloat totalWidth = 0;
        NSMutableArray *titleSizeArray = [NSMutableArray array];
        _titleSizeArray = titleSizeArray;
        CGFloat equalX = MIN_WIDTH;
        NSMutableArray *equalIntervals = [NSMutableArray array];
        
        for (NSInteger i=0; i<_titles.count; i++) {
            CGSize titleSize = [_titles[i] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
            [titleSizeArray addObject:[NSValue valueWithCGSize:titleSize]];
            totalWidth += titleSize.width;
            [equalIntervals addObject:[NSNumber numberWithFloat:(equalX + titleSize.width/2)]];
            equalX += MIN_WIDTH + titleSize.width;
        }
        
        CGFloat minWidth = (SCREEN_WIDTH - totalWidth) / (_titles.count + 1);
        CGFloat averageX = minWidth;
        NSMutableArray *averageIntervals = [NSMutableArray array];
        for (NSInteger i=0; i<_titles.count; i++) {
            [averageIntervals addObject:[NSNumber numberWithDouble:(averageX + [titleSizeArray[i] CGSizeValue].width/2)]];
            averageX += minWidth + [titleSizeArray[i] CGSizeValue].width;
        }
        
        //确定当前宽能否放下，继而确定等间距排布，还是均匀排布
        totalWidth += _titles.count * (MIN_WIDTH + 1);
        
        NSMutableArray *centerPoints = [NSMutableArray array];
        
        if (totalWidth > SCREEN_WIDTH){
            centerPoints = equalIntervals;
        }else{
            centerPoints = averageIntervals;
            totalWidth = SCREEN_WIDTH;
        }
        _centerPoints = centerPoints;
        _topTabScrollView.contentSize = CGSizeMake(totalWidth, 0);
        
        _titleButtons = [NSMutableArray array];
        for (NSInteger i=0; i<_titles.count; i++) {
            UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
            titleButton.tag = i;
            [_titleButtons addObject:titleButton];
            titleButton.titleLabel.font = [UIFont systemFontOfSize:18];
            
            [titleButton setTitle:_titles[i] forState:UIControlStateNormal];
            
            CGFloat x = [_centerPoints[i] floatValue];
            CGFloat width = [titleSizeArray[i] CGSizeValue].width;
            
            CGRect buttonFrame = CGRectMake(x-width/2, 0, width, TAB_HEIGHT);
            //标签位置
            titleButton.frame = buttonFrame;
            [_topTabScrollView addSubview:titleButton];
            
            //添加点击事件
            [titleButton addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
            
            //设置默认选中标签
            if (i == 0) {
                [titleButton setTitleColor:SELECTED_COLOR forState:UIControlStateNormal];
            }else{
                [titleButton setTitleColor:UNSELECTED_COLOR forState:UIControlStateNormal];
            }
            
        }
        //创建tabTop下方总览线
        
        UIView *topTabBottomLine = [UIView new];
        topTabBottomLine.frame = CGRectMake(0, TAB_HEIGHT - 1, totalWidth, 1);
        topTabBottomLine.backgroundColor = TPOTABBOTTOMLINE_COLOR;
        [_topTabScrollView addSubview:topTabBottomLine];
        
        //创建选中移动线
        UIView *lineBottom = [UIView new];
        _lineBottom = lineBottom;

        lineBottom.frame = CGRectMake(0, TAB_HEIGHT - LINEBOTTOM_HEIGHT,[titleSizeArray[0] CGSizeValue].width, LINEBOTTOM_HEIGHT);
        lineBottom.center = CGPointMake([centerPoints[0] floatValue], lineBottom.center.y);
        lineBottom.backgroundColor = SELECTED_COLOR;
        [_topTabScrollView addSubview:lineBottom];
    }
    return _topTabScrollView;
}

- (void)touchAction:(UIButton *)button {
    [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * button.tag, 0) animated:YES];
    self.currentPage = (SCREEN_WIDTH * button.tag + SCREEN_WIDTH / 2) / SCREEN_WIDTH;
    
}

#pragma mark - UIScrollViewDelegate

//开始减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.currentPage = (NSInteger)((scrollView.contentOffset.x + SCREEN_WIDTH / 2) / SCREEN_WIDTH);
    [UIView animateWithDuration:.1 animations:^{
        _lineBottom.frame = CGRectMake(0, TAB_HEIGHT - LINEBOTTOM_HEIGHT,[_titleSizeArray[self.currentPage] CGSizeValue].width, LINEBOTTOM_HEIGHT);
        _lineBottom.center = CGPointMake([_centerPoints[self.currentPage] floatValue], _lineBottom.center.y);
    }];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    _lineBottom.frame = CGRectMake(0, TAB_HEIGHT - LINEBOTTOM_HEIGHT,[_titleSizeArray[self.currentPage] CGSizeValue].width, LINEBOTTOM_HEIGHT);
    _lineBottom.center = CGPointMake([_centerPoints[self.currentPage] floatValue], _lineBottom.center.y);
}
//滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (_contentOffset_x < 1600 && scrollView.contentOffset.x > 1600) {
        NSLog(@"%lf",scrollView.contentOffset.x - 1600);
    }
    if (_contentOffset_x > 1600 && scrollView.contentOffset.x < 1600) {
        NSLog(@"%lf",scrollView.contentOffset.x - 1600);
    }
    
    CGFloat offset = scrollView.contentOffset.x - _contentOffset_x;
    _contentOffset_x = scrollView.contentOffset.x;
    //NSLog(@"%f",scrollView.contentOffset.x);
    if (scrollView.contentOffset.x<=0 || scrollView.contentOffset.x > SCREEN_WIDTH * (_titles.count-1)) {
        return;
    }
    
    CGFloat widthScale = 0;
    CGFloat offsetScale = 0;
    
    for (NSInteger i=0; i<_titles.count; i++) {
        //寻找下一个点
        CGFloat maxPointx = [_centerPoints[i] floatValue];
        if (i==_titles.count-1) {
            maxPointx += 1;
        }
        if (_lineBottom.center.x < maxPointx) {
            if (i==0)break;
            offsetScale = (([_centerPoints[i] floatValue] - [_centerPoints[i-1] floatValue]) / SCREEN_WIDTH) * offset;
            CGFloat rightWidth = [_titleSizeArray[i] CGSizeValue].width;
            CGFloat leftWidth = [_titleSizeArray[i-1] CGSizeValue].width;
            widthScale = (rightWidth - leftWidth)/SCREEN_WIDTH * offset;
            break;
        }
    }
    
    _lineBottom.center = CGPointMake(_lineBottom.center.x + offsetScale, _lineBottom.center.y);
    _lineBottom.bounds = CGRectMake(0, 0, _lineBottom.frame.size.width + widthScale, LINEBOTTOM_HEIGHT);
    
    CGFloat page = (NSInteger)((scrollView.contentOffset.x + SCREEN_WIDTH / 2) / SCREEN_WIDTH);
    for (UIButton *button in _titleButtons) {
        if (button.tag == page) {
            [button setTitleColor:SELECTED_COLOR forState:UIControlStateNormal];
//            [UIView animateWithDuration:0.3 animations:^{
//                button.transform = CGAffineTransformMakeScale(1.1, 1.1);
//            }];
        }else{
            [button setTitleColor:UNSELECTED_COLOR forState:UIControlStateNormal];
//            [UIView animateWithDuration:0.3 animations:^{
//                button.transform = CGAffineTransformIdentity;
//            }];
        }
    }
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"currentPage"]) {

        NSInteger page = [change[@"new"] integerValue];
        
        CGFloat offset = [_centerPoints[page] floatValue];
        if (offset < SCREEN_WIDTH/2) {
            [_topTabScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }else if(offset+SCREEN_WIDTH/2 <_topTabScrollView.contentSize.width) {
            [_topTabScrollView setContentOffset:CGPointMake(offset-SCREEN_WIDTH/2, 0) animated:YES];
        }else{
            [_topTabScrollView setContentOffset:CGPointMake(_topTabScrollView.contentSize.width-SCREEN_WIDTH, 0) animated:YES];
        }
        
        for (NSInteger i=0; i<_viewControllers.count; i++) {
            if (page == i) {
                NSString *className = _viewControllers[page];
                Class class = NSClassFromString(className);
                //NSLog(@"%@",class);
                UIViewController *viewController = class.new;
                viewController.view.frame = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TAB_HEIGHT);
                [_scrollView addSubview:viewController.view];
            }
        }
    }
}
@end
