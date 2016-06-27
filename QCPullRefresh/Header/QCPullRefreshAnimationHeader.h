//
//  QCPullRefreshAnimationHeader.h
//  QCPullRefresh
//
//  Created by QC.L on 16/6/26.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "QCPullRefreshHeader.h"

@interface QCPullRefreshAnimationHeader : QCPullRefreshHeader
+ (instancetype)headerPullingTitle:(NSString *)pullingTitle
                   refreshingTitle:(NSString *)refreshingTitle
         headerWithRefreshingBlock:(QCRefreshBaseControlRefreshingBlock)refreshingBlock;
@property (nonatomic, strong) UILabel *refreshingLabel;
@end
