//
//  UIScrollView+QCAttribute.h
//  QCPullRefresh
//
//  Created by QC.L on 16/6/25.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (QCAttribute)
@property (nonatomic, assign) CGFloat qc_offsetX;
@property (nonatomic, assign) CGFloat qc_offsetY;

@property (nonatomic, assign) CGFloat qc_insetTop;
@property (nonatomic, assign) CGFloat qc_insetBottom;
@property (nonatomic, assign) CGFloat qc_insetLeft;
@property (nonatomic, assign) CGFloat qc_insetRight;

@property (nonatomic, assign) CGFloat qc_contentWidth;
@property (nonatomic, assign) CGFloat qc_contentHeight;
@end
