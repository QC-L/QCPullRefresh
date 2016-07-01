//
//  BaseCollectionViewViewController.h
//  QCPullRefreshDemo
//
//  Created by QC.L on 16/7/1.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface BaseCollectionViewViewController : BaseViewController
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *collectionView;
@end
