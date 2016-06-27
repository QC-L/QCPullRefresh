//
//  UIView+QCAttribute.h
//  QCPullRefresh
//
//  Created by QC.L on 16/6/26.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (QCAttribute)
@property (nonatomic, assign) CGFloat qc_x;
@property (nonatomic, assign) CGFloat qc_y;
@property (nonatomic, assign) CGFloat qc_width;
@property (nonatomic, assign) CGFloat qc_height;
@property (nonatomic, assign) CGPoint qc_origin;
@property (nonatomic, assign) CGSize qc_size;
@end
