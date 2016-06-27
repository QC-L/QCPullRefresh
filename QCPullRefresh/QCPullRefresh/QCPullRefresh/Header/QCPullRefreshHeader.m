//
//  QCRefreshHeader.m
//  QCPullRefresh
//
//  Created by QC.L on 16/6/26.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "QCPullRefreshHeader.h"

@interface QCPullRefreshHeader ()
@property (nonatomic, assign) CGFloat insetTopDelta;
@end

@implementation QCPullRefreshHeader

+ (instancetype)headerWithRefreshingBlock:(QCRefreshBaseControlRefreshingBlock)refreshingBlock {
    QCPullRefreshHeader *header = [[self alloc] init];
    header.refreshingBlock = refreshingBlock;
    return header;
}

+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action {
    QCPullRefreshHeader *header = [[self alloc] init];
    [header setRefreshingTarget:target refreshingAction:action];
    return header;
}

- (void)prepare {
    [super prepare];
    
    self.qc_height = QCRefreshHeaderHeight;
}

- (void)placeSubviews {
    [super placeSubviews];
    
    // 高度改变重新调整Y
    self.qc_y = - self.qc_height - self.ignoredScrollViewContentInsetTop;
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    if (self.state == QCRefreshStateRefreshing) {
        if (self.window == nil) {
            return;
        }
        
        CGFloat insetTop = -self.scrollView.qc_offsetY > _scrollviewOriginalInset.top ? -self.scrollView.qc_offsetY : _scrollviewOriginalInset.top;
        insetTop = insetTop > self.qc_height + _scrollviewOriginalInset.top ? self.qc_height + _scrollviewOriginalInset.top : insetTop;
        self.scrollView.qc_insetTop = insetTop;
        self.insetTopDelta = _scrollviewOriginalInset.top - insetTop;
        return;
    }
    _scrollviewOriginalInset = self.scrollView.contentInset;
    // 当前contentOffset
    CGFloat offsetY = self.scrollView.qc_offsetY;
    CGFloat happenOffsetY = -self.scrollViewOriginalInset.top;
    
    if (offsetY > happenOffsetY) {
        return;
    }
    
    CGFloat normalpullingOffsetY = happenOffsetY - self.qc_height;
    CGFloat pullingPercent = (happenOffsetY - offsetY) / self.qc_height;
    if (self.scrollView.isDragging) {
        self.pullingPercent = pullingPercent;
        if (self.state == QCRefreshStateNormal && offsetY < normalpullingOffsetY) {
            self.state = QCRefreshStatePulling;
        } else if (self.state == QCRefreshStatePulling && offsetY >= normalpullingOffsetY) {
            self.state = QCRefreshStateNormal;
        }
    } else if (self.state == QCRefreshStatePulling) {
        [self beginRefreshing];
    } else if (pullingPercent < 1) {
        self.pullingPercent = pullingPercent;
    }
}

- (void)setState:(QCRefreshState)state {
    QCRefreshCheckState
    if (state == QCRefreshStateNormal) {
        if (oldState != QCRefreshStateRefreshing) {
            return;
        }
        [UIView animateWithDuration:QCRefreshSlowAnimationDuration animations:^{
            self.scrollView.qc_insetTop += self.insetTopDelta;
            if (self.isAutomaticallyChangeAlpha) self.alpha = 0.0;
        } completion:^(BOOL finished) {
            self.pullingPercent = 0.0;
            if (self.endRefreshingCompletionBlock) {
                self.endRefreshingCompletionBlock();
            }
        }];
        
    } else if (state == QCRefreshStateRefreshing) {
        dispatch_async(dispatch_get_main_queue(), ^{
           [UIView animateWithDuration:QCRefreshFastAnimationDuration animations:^{
               CGFloat top = self.scrollViewOriginalInset.top + self.qc_height;
               self.scrollView.qc_insetTop = top;
               [self.scrollView setContentOffset:CGPointMake(0, -top)];
           } completion:^(BOOL finished) {
               [self executeRefreshingCallback];
           }];
        });
    }
}

- (void)endRefreshing {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.state = QCRefreshStateNormal;
    });
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
