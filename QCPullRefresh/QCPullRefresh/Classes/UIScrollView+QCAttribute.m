//
//  UIScrollView+QCAttribute.m
//  QCPullRefresh
//
//  Created by QC.L on 16/6/25.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "UIScrollView+QCAttribute.h"

@implementation UIScrollView (QCAttribute)

- (void)setQc_offsetX:(CGFloat)qc_offsetX {
    CGPoint offset = self.contentOffset;
    offset.x = qc_offsetX;
    self.contentOffset = offset;
}

- (CGFloat)qc_offsetX {
    return self.contentOffset.x;
}

- (void)setQc_offsetY:(CGFloat)qc_offsetY {
    CGPoint offset = self.contentOffset;
    offset.y = qc_offsetY;
    self.contentOffset = offset;
}

- (CGFloat)qc_offsetY {
    return self.contentOffset.y;
}

- (void)setQc_insetTop:(CGFloat)qc_insetTop {
    UIEdgeInsets insets = self.contentInset;
    insets.top = qc_insetTop;
    self.contentInset = insets;
}

- (CGFloat)qc_insetTop {
    return self.contentInset.top;
}

- (void)setQc_insetLeft:(CGFloat)qc_insetLeft {
    UIEdgeInsets insets = self.contentInset;
    insets.left = qc_insetLeft;
    self.contentInset = insets;
}

- (CGFloat)qc_insetLeft {
    return self.contentInset.left;
}

- (void)setQc_insetRight:(CGFloat)qc_insetRight {
    UIEdgeInsets insets = self.contentInset;
    insets.right = qc_insetRight;
    self.contentInset = insets;
}

- (CGFloat)qc_insetRight {
    return self.contentInset.right;
}

- (void)setQc_insetBottom:(CGFloat)qc_insetBottom {
    UIEdgeInsets insets = self.contentInset;
    insets.bottom = qc_insetBottom;
    self.contentInset = insets;
}

- (CGFloat)qc_insetBottom {
    return self.contentInset.bottom;
}

- (void)setQc_contentWidth:(CGFloat)qc_contentWidth {
    CGSize contentSize = self.contentSize;
    contentSize.width = qc_contentWidth;
    self.contentSize = contentSize;
}

- (CGFloat)qc_contentWidth {
    return self.contentSize.width;
}

- (void)setQc_contentHeight:(CGFloat)qc_contentHeight {
    CGSize contentSize = self.contentSize;
    contentSize.height = qc_contentHeight;
    self.contentSize = contentSize;
}

- (CGFloat)qc_contentHeight {
    return self.contentSize.height;
}

@end
