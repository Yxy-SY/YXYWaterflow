//
//  ViewController.m
//  YXYWaterflow
//
//  Created by yuxiuyi on 2018/5/14.
//  Copyright © 2018年 yuxiuyi. All rights reserved.
//

#import "ViewController.h"
#import "YXYCollectionViewWaterFlowLayout.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *_collectionView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YXYCollectionViewWaterFlowLayout *layout = [[YXYCollectionViewWaterFlowLayout alloc] init];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark --
#pragma mark -- UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor redColor];
    NSInteger tag = 10;
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:tag];
    if (label == nil) {
        label = [[UILabel alloc] init];
        label.tag = tag;
        [cell.contentView addSubview:label];
    }
    
    label.text = [NSString stringWithFormat:@"%zd", indexPath.item];
    [label sizeToFit];
    return cell;
}




@end
