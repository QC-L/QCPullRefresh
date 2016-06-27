//
//  UIScrollView+QCPullRefresh.h
//  QCPullRefresh
//
//  Created by QC.L on 16/6/26.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QCPullRefreshHeader;
@interface UIScrollView (QCPullRefresh)
@property (nonatomic, strong) QCPullRefreshHeader *qc_header;
- (NSInteger)qc_totalDataCount;
@property (nonatomic, copy) void (^qc_reloadDataBlock)(NSInteger totalDataCount);
@end
