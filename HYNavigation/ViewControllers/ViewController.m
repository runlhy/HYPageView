//
//  ViewController.m
//  HYNavigation
//
//  Created by runlhy on 16/9/26.
//  Copyright © 2016年 Pengcent. All rights reserved.
//

#import "ViewController.h"
#import "HYPageView.h"
#import "WaterFlowCollectionViewController.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *_titles;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.view addSubview:_tableView];
    
    _tableView.tableFooterView = [UIView new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    _titles = @[@"样例1.仿照优酷首页",@"样例2.仿照优酷Vip会员页面",@"样例3.仿照网易云音乐首页",@"样例4.瞎写",@"每页最后一页是返回"];
}


- (HYPageView *)test0 {
    HYPageView *pageView = [[HYPageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withTitles:@[@"头条",@"精选",@"新好声音"] withViewControllers:@[@"WaterFlowCollectionViewController",@"WaterFlowCollectionViewController",@"FirstViewViewController"] withParameters:@[@"123",@"这是一片很寂寞的天"]];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftButton setImage:[UIImage imageNamed:@"search_"] forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 0, 50, 40);
    [leftButton setTintColor:[UIColor blackColor]];
    leftButton.transform = CGAffineTransformMakeScale(.7, .7);
    pageView.leftButton = leftButton;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightButton setImage:[UIImage imageNamed:@"more_"] forState:UIControlStateNormal];
    rightButton.frame = CGRectMake(0, 0, 50, 40);
    [rightButton setTintColor:[UIColor blackColor]];
    rightButton.transform = CGAffineTransformMakeScale(.5, .5);
    pageView.rightButton = rightButton;
    pageView.defaultSubscript = 0;
    return pageView;
}

- (HYPageView *)test1 {
    
    WaterFlowCollectionViewController *vc = [WaterFlowCollectionViewController new];
    
    HYPageView *pageView = [[HYPageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withTitles:@[@"精选",@"片库",@"电影",@"韩剧",@"德云社",@"动漫",@"电视剧",@"纪录片"] withViewControllers:@[@"WaterFlowCollectionViewController",@"WaterFlowCollectionViewController",@"WaterFlowCollectionViewController",@"WaterFlowCollectionViewController",@"WaterFlowCollectionViewController",@"WaterFlowCollectionViewController",vc,@"FirstViewViewController"] withParameters:nil];
    pageView.pageViewStyle = HYPageViewStyleB;
    
    pageView.isTranslucent = NO;
    pageView.topTabViewColor = [UIColor colorWithRed:211/255. green:111/255. blue:39/255. alpha:.5];
    pageView.selectedColor = [UIColor yellowColor];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftButton setImage:[UIImage imageNamed:@"search_"] forState:UIControlStateNormal];
    pageView.isAdapteNavigationBar = NO;
    leftButton.frame = CGRectMake(0, 0, 50, 40);
    [leftButton setTintColor:[UIColor blackColor]];
    leftButton.transform = CGAffineTransformMakeScale(.7, .7);
    pageView.leftButton = leftButton;
    pageView.defaultSubscript = 1;
    return pageView;
}

- (HYPageView *)test2 {
    HYPageView *pageView = [[HYPageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withTitles:@[@"个性推介",@"歌单",@"主播电台",@"排行榜"] withViewControllers:@[@"WaterFlowCollectionViewController",@"WaterFlowCollectionViewController",@"WaterFlowCollectionViewController",@"FirstViewViewController"] withParameters:nil];
    pageView.pageViewStyle = HYPageViewStyleB;
    pageView.selectedColor = [UIColor redColor];
    pageView.unselectedColor = [UIColor blackColor];
    pageView.defaultSubscript = 2;
    
    return pageView;
}

- (HYPageView *)test3 {
    HYPageView *pageView = [[HYPageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withTitles:@[@"One",@"Two",@"Three",@"Four",@"Five",@"Six"] withViewControllers:@[@"WaterFlowCollectionViewController",@"WaterFlowCollectionViewController",@"WaterFlowCollectionViewController",@"WaterFlowCollectionViewController",@"WaterFlowCollectionViewController",@"FirstViewViewController"] withParameters:nil];
    pageView.pageViewStyle = HYPageViewStyleB;
    pageView.selectedColor = [UIColor redColor];
    pageView.unselectedColor = [UIColor blackColor];
    pageView.font = [UIFont fontWithName:@"Zapfino" size:16];
    pageView.defaultSubscript = 2;
    return pageView;
}

- (HYPageView *)test4 {
    
    HYPageView *pageView = [[HYPageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withTitles:@[@"我实在",@"也",@"想不出",@"头上",@"写",@"点啥了"] withViewControllers:@[@"WaterFlowCollectionViewController",@"WaterFlowCollectionViewController",@"WaterFlowCollectionViewController",@"WaterFlowCollectionViewController",@"WaterFlowCollectionViewController",@"FirstViewViewController"] withParameters:nil];
    pageView.pageViewStyle = HYPageViewStyleB;
    
    pageView.isAnimated = YES;
    pageView.selectedColor = [UIColor blueColor];
    pageView.unselectedColor = [UIColor blackColor];
    pageView.font = [UIFont fontWithName:@"HoeflerText-Black" size:18];
    pageView.defaultSubscript = 4;
    return pageView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - DataSource & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    cell.textLabel.text = _titles[indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            UIViewController *v = [UIViewController new];
            [self.navigationController setNavigationBarHidden:YES animated:NO];
            [v.view addSubview:[self test0]];
            [self showViewController:v sender:nil];
            
        }
            break;
        case 1:
        {
            UIViewController *v = [UIViewController new];
            [v.view addSubview:[self test1]];
            [self showViewController:v sender:nil];
            
        }
            break;
        case 2:
        {
            UIViewController *v = [UIViewController new];
            UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:v];
            [v.view addSubview:[self test2]];
            [self showViewController:nv sender:nil];
        }
            break;
            
        case 3:
        {
            UIViewController *v = [UIViewController new];
            [v.view addSubview:[self test3]];
            [self showViewController:v sender:nil];
        }
            break;
            
        default:
        {
            UIViewController *v = [UIViewController new];
            [v.view addSubview:[self test4]];
            [self showViewController:v sender:nil];
        }
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
