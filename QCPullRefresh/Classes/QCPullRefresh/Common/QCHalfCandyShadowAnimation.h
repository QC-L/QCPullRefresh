//
//  QCHalfCandyShaowAnimation.h
//  QCPullRefresh
//
//  Created by QC.L on 16/6/27.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QCHalfCandyShadowAnimation : NSObject
// 需要展示动画的View
@property (weak, nonatomic) UIView *animatedView;
// 动画时长
@property (assign, nonatomic) NSTimeInterval duration;
// 阴影宽度
@property (assign, nonatomic) CGFloat shadowWidth;
// 重复次数
@property (assign, nonatomic) CGFloat repeatCount;
// 阴影背景
@property (strong, nonatomic) UIColor *shadowBackgroundColor;
@property (strong, nonatomic) UIColor *shadowForegroundColor;
- (void)start;
- (void)stop;
@end
