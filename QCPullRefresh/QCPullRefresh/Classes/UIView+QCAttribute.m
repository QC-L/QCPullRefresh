//
//  UIView+QCAttribute.m
//  QCPullRefresh
//
//  Created by QC.L on 16/6/26.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "UIView+QCAttribute.h"

@implementation UIView (QCAttribute)

- (void)setQc_x:(CGFloat)qc_x {
    CGRect rect = self.frame;
    rect.origin.x = qc_x;
    self.frame = rect;
}

- (CGFloat)qc_x {
    return self.frame.origin.x;
}

- (void)setQc_y:(CGFloat)qc_y {
    CGRect rect = self.frame;
    rect.origin.y = qc_y;
    self.frame = rect;
}

- (CGFloat)qc_y {
    return self.frame.origin.y;
}

- (void)setQc_width:(CGFloat)qc_width {
    CGRect rect = self.frame;
    rect.size.width = qc_width;
    self.frame = rect;
}

- (CGFloat)qc_width {
    return self.frame.size.width;
}

- (void)setQc_height:(CGFloat)qc_height {
    CGRect rect = self.frame;
    rect.size.height = qc_height;
    self.frame = rect;
}

- (CGFloat)qc_height {
    return self.frame.size.height;
}

- (void)setQc_origin:(CGPoint)qc_origin {
    CGRect rect = self.frame;
    rect.origin = qc_origin;
    self.frame = rect;
}

- (CGPoint)qc_origin {
    return self.frame.origin;
}

- (void)setQc_size:(CGSize)qc_size {
    CGRect rect = self.frame;
    rect.size = qc_size;
    self.frame = rect;
}

- (CGSize)qc_size {
    return self.frame.size;
}

@end
