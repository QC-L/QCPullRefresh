//
//  QCPullRefreshAnimationHeader.m
//  QCPullRefresh
//
//  Created by QC.L on 16/6/26.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "QCPullRefreshAnimationHeader.h"
#import "QCHalfCandyAnimationRefresh.h"
#import "QCHalfCandyShadowAnimation.h"

@interface QCPullRefreshAnimationHeader ()
@property (nonatomic, strong) NSMutableDictionary *stateTitles;
@property (nonatomic, strong) CALayer *pathLayer;
@property (strong, nonatomic) QCHalfCandyShadowAnimation *shadowAnimation;
@end

@implementation QCPullRefreshAnimationHeader

- (NSMutableDictionary *)stateTitles {
    if (!_stateTitles) {
        self.stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}

- (UILabel *)refreshingLabel {
    if (!_refreshingLabel) {
        _refreshingLabel = [UILabel qc_label];
        [self addSubview:_refreshingLabel];
    }
    return _refreshingLabel;
}

- (void)setTitle:(NSString *)title forState:(QCRefreshState)state {
    if (title == nil) {
        return;
    }
    self.stateTitles[@(state)] = title;
    self.refreshingLabel.text = self.stateTitles[@(self.state)];
}

- (void)prepare {
    [super prepare];
    self.shadowAnimation = [QCHalfCandyShadowAnimation new];
    self.shadowAnimation.animatedView = self.refreshingLabel;
    self.shadowAnimation.shadowWidth = 40.;
    self.shadowAnimation.duration = 1.2f;
    
    QCHalfCandyAnimationRefresh *animation = [QCHalfCandyAnimationRefresh defaultAnimationRefresh];
    self.pathLayer = [animation qcHalfCandyAnimationRefreshWithTitle:@"   C'est La Vie   "];
    [self.refreshingLabel.layer addSublayer:_pathLayer];
    [animation addRefreshingAnimation];
    
    [self setTitle:@"" forState:QCRefreshStateNormal];
    [self setTitle:@"" forState:QCRefreshStatePulling];
    [self setTitle:@"La Vie est belle" forState:QCRefreshStateRefreshing];
}

- (void)placeSubviews {
    [super placeSubviews];
    if (self.refreshingLabel.hidden) {
        return;
    }
    BOOL noConstrainsOnRefreshingLabel = self.refreshingLabel.constraints.count == 0;
    if (noConstrainsOnRefreshingLabel) {
        self.refreshingLabel.qc_x = 0;
        self.refreshingLabel.qc_y = 0;
        self.refreshingLabel.qc_width = self.qc_width;
        self.refreshingLabel.qc_height = self.qc_height;
        _pathLayer.position = self.refreshingLabel.center;
    }
}

- (void)setState:(QCRefreshState)state {
    QCRefreshCheckState
    
    self.refreshingLabel.text = self.stateTitles[@(state)];

    if (state == QCRefreshStatePulling || state == QCRefreshStateNormal) {
        [self.refreshingLabel.layer addSublayer:_pathLayer];
        [self.shadowAnimation stop];
    }
    if (state == QCRefreshStateRefreshing) {
        self.pathLayer.beginTime = 0.0f;
        self.pathLayer.timeOffset = 0.0f;
        [self.pathLayer removeFromSuperlayer];
        [self.shadowAnimation start];
    }
    
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    
    NSValue *value = change[@"new"];
    CGPoint point = [value CGPointValue];
    
    
    QCHalfCandyAnimationRefresh *animation = [QCHalfCandyAnimationRefresh defaultAnimationRefresh];
    
    if (-point.y - 20 > 0 && self.scrollView.isDragging) {
        [animation animationTimeOffset:(-point.y - 20) / 54.0 * 10];
    }

}

@end
