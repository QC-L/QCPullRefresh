//
//  QCRefreshHeader.h
//  QCPullRefresh
//
//  Created by QC.L on 16/6/26.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "QCPullRefreshBaseControl.h"

@interface QCPullRefreshHeader : QCPullRefreshBaseControl
/**
 *  默认下拉刷新创建方法
 *  @param refreshingBlock 刷新回调
 */
+ (instancetype)headerWithRefreshingBlock:(QCRefreshBaseControlRefreshingBlock)refreshingBlock;
/**
 *  默认下拉刷新target action
 */
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

@property (nonatomic, assign) CGFloat ignoredScrollViewContentInsetTop;
@end
