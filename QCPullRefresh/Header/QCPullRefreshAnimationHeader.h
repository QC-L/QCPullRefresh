//
//  QCPullRefreshAnimationHeader.h
//  QCPullRefresh
//
//  Created by QC.L on 16/6/26.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "QCPullRefreshHeader.h"

@interface QCPullRefreshAnimationHeader : QCPullRefreshHeader
/**
 *  自定义刷新回调
 *
 *  @param pullingTitle    自定义下拉标题
 *  @param refreshingTitle 正在刷新标题
 *  @param refreshingBlock 刷新回调
 *
 *  @return
 */
+ (instancetype)headerPullingTitle:(NSString *)pullingTitle
                   refreshingTitle:(NSString *)refreshingTitle
         headerWithRefreshingBlock:(QCRefreshBaseControlRefreshingBlock)refreshingBlock;
@end
