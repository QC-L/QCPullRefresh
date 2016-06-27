//
//  QCHalfCandyAnimationRefresh.h
//  QCPullRefresh
//
//  Created by QC.L on 16/6/26.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>

@interface QCHalfCandyAnimationRefresh : NSObject
+ (QCHalfCandyAnimationRefresh *)defaultAnimationRefresh;
// Pulling Animation
- (CALayer *)qcHalfCandyAnimationRefreshWithTitle:(NSString *)title;
- (void)addRefreshingAnimation;
- (void)animationTimeOffset:(CGFloat)offset;

@end
