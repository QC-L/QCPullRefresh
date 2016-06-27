//
//  QCRefreshHeader.h
//  QCPullRefresh
//
//  Created by QC.L on 16/6/26.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "QCPullRefreshBaseControl.h"

@interface QCPullRefreshHeader : QCPullRefreshBaseControl
+ (instancetype)headerWithRefreshingBlock:(QCRefreshBaseControlRefreshingBlock)refreshingBlock;
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;
@property (nonatomic, assign) BOOL isHaveEndRefreshAnimation;
@property (nonatomic, assign) CGFloat ignoredScrollViewContentInsetTop;
@end
