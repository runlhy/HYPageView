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

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [UIView new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
}
- (HYPageView *)test1 {
     
     //    self.automaticallyAdjustsScrollViewInsets = NO;
     //    @[@"One",@"Two",@"Three",@"Four",@"Five",@"Six"]
     //    @[@"个性推介",@"歌单",@"主播电台"]
     //    @[@"精选",@"片库",@"电影",@"韩剧",@"德云社",@"动漫",@"电视剧",@"纪录片"]
     //    @[@"头条",@"精选",@"新好声音"]
     
     HYPageView *pageView = [[HYPageView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT) withTitles:@[@"头条",@"精选",@"新好声音"] withViewControllers:@[@"FirstViewViewController",@"FirstViewViewController",@"FirstViewViewController",@"FirstViewViewController",@"FirstViewViewController",@"FirstViewViewController"] withParameters:@[@"123",@"这是一片很寂寞的天"]];
     pageView.selectedColor = [UIColor blueColor];
     pageView.unselectedColor = [UIColor blackColor];
     pageView.font = [UIFont systemFontOfSize:17.5];
    pageView.font = [UIFont fontWithName:@"奇思古粗废墟体" size:20];
     
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
    return pageView;
}

- (HYPageView *)test0 {
    HYPageView *pageView = [[HYPageView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT) withTitles:@[@"头条",@"精选",@"新好声音"] withViewControllers:@[@"FirstViewViewController",@"FirstViewViewController",@"FirstViewViewController"] withParameters:@[@"123",@"这是一片很寂寞的天"]];
    
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
    
    return pageView;
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
    
    cell.textLabel.text = @"仿照优酷";
    
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
            v.view = [self test0];
            [self showViewController:v sender:nil];
            
        }
            break;
            
        default:
        {
            
        }
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
