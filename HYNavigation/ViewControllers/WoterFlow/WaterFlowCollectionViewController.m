//
//  WaterFlowCollectionViewController.m
//  CollectionPictures
//
//  Created by runlhy on 16/7/2.
//  Copyright © 2016年 runlhy. All rights reserved.
//

#import "WaterFlowCollectionViewController.h"
#import "WaterFlowLayout.h"
#import "YYWebImage.h"
#import "WaterFlowCollectionViewCell.h"

@interface WaterFlowCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
}

@property (nonatomic, strong) NSMutableArray *allDataArray;
@property (nonatomic, strong) NSMutableArray *randomDataArray;

@end

@implementation WaterFlowCollectionViewController

- (void)dealloc{
    //NSLog(@"%@",self.class);
}

- (NSMutableArray *)randomDataArray
{
    if (!_randomDataArray){
        _randomDataArray = [NSMutableArray array];
    }
    return _randomDataArray;
}

- (NSMutableArray *)allDataArray
{
    if (!_allDataArray){
        _allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WaterFlowLayout *waterFlowLayout = [WaterFlowLayout new];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:waterFlowLayout];
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource  = self;
    
    [_collectionView registerNib:[UINib nibWithNibName:@"WaterFlowCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"WaterFlowCollectionViewCell"];
    self.view = _collectionView;
//    [self.view addSubview:_collectionView];
    [self requestData];
    
}

- (void)requestData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"x" ofType:@"txt"];
    NSString *string = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *array = [string componentsSeparatedByString:@"\n"];
    for (NSString *obj in array) {
        if ([obj containsString:@"http"] && [obj containsString:@"_240x426"] && ![obj containsString:@"_480x852"]) {
            [self.allDataArray addObject:obj];
        }
    }
    
    for (NSInteger i=0; i<27; i++) {
        [self.randomDataArray addObject:self.allDataArray[arc4random() % self.allDataArray.count]];
    }
    [_collectionView reloadData];
    
}

#pragma mark - UICollectionView DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.randomDataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WaterFlowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WaterFlowCollectionViewCell" forIndexPath:indexPath];
    NSURL *url = [NSURL URLWithString:self.randomDataArray[indexPath.row]];
    [cell.imgView yy_setImageWithURL:url options:YYWebImageOptionProgressive];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.navigationController) {
        [self.navigationController pushViewController:[WaterFlowCollectionViewController new] animated:YES];
    }
    
}

@end
