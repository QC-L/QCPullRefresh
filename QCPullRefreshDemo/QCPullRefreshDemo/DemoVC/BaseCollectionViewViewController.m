//
//  BaseCollectionViewViewController.m
//  QCPullRefreshDemo
//
//  Created by QC.L on 16/7/1.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "BaseCollectionViewViewController.h"

static NSString * const kCollectionViewReuse = @"reuse";
@interface BaseCollectionViewViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation BaseCollectionViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(self.view.qc_width / 2 - 10, self.view.qc_width / 2 - 10);
    _flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:_flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCollectionViewReuse];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewReuse forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
