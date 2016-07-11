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
@property (nonatomic, strong) UILabel *refreshingLabel;
@property (nonatomic, copy) NSString *pullingTitle;
@property (nonatomic, copy) NSString *refreshingTitle;
@property (nonatomic, strong) NSMutableDictionary *stateTitles;
@property (nonatomic, strong) CALayer *pathLayer;
@property (strong, nonatomic) QCHalfCandyShadowAnimation *shadowAnimation;
@property (nonatomic, assign) CGFloat headerAnimationHeight;
@end

@implementation QCPullRefreshAnimationHeader

+ (instancetype)headerPullingTitle:(NSString *)pullingTitle refreshingTitle:(NSString *)refreshingTitle headerWithRefreshingBlock:(QCRefreshBaseControlRefreshingBlock)refreshingBlock {
    QCPullRefreshAnimationHeader *header = [super headerWithRefreshingBlock:refreshingBlock];
    if (pullingTitle.length > 0) {
        header.pullingTitle = pullingTitle;
    }
    if (refreshingTitle.length > 0) {
        header.refreshingTitle = refreshingTitle;
    }
    return header;
    
}

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
    self.shadowAnimation.shadowWidth = 30.;
    self.shadowAnimation.duration = 1.2f;
    
    
    self.pullingTitle = @"   C'est La Vie   ";
    self.refreshingTitle = @"La Vie est belle";
    [self setTitle:@"" forState:QCRefreshStateNormal];
    [self setTitle:@"" forState:QCRefreshStatePulling];
    
}

- (void)setRefreshingTitle:(NSString *)refreshingTitle {
    if ([_refreshingTitle isEqualToString:refreshingTitle]) {
        return;
    }
    _refreshingTitle = [refreshingTitle copy];
    [self setTitle:refreshingTitle forState:QCRefreshStateRefreshing];
}

- (void)setPullingTitle:(NSString *)pullingTitle {
    if ([_pullingTitle isEqualToString:pullingTitle]) {
        return;
    }
    _pullingTitle = [pullingTitle copy];
    QCHalfCandyAnimationRefresh *animation = [QCHalfCandyAnimationRefresh defaultAnimationRefresh];
    self.pathLayer = [animation qcHalfCandyAnimationRefreshWithTitle:pullingTitle];
    [self.refreshingLabel.layer addSublayer:_pathLayer];
    [animation addRefreshingAnimation];
}

- (void)placeSubviews {
    [super placeSubviews];
    if (self.refreshingLabel.hidden) {
        return;
    }
    BOOL noConstrainsOnRefreshingLabel = self.refreshingLabel.constraints.count == 0;
    if (noConstrainsOnRefreshingLabel) {
        self.refreshingLabel.qc_x = 0;
        self.refreshingLabel.qc_y = 20;
        self.refreshingLabel.qc_width = self.qc_width;
        self.refreshingLabel.qc_height = self.qc_height - 20;
        _pathLayer.position = self.refreshingLabel.center;
        CGPoint point = _pathLayer.position;
        point.y = self.refreshingLabel.qc_height - 20;
        _pathLayer.position = point;
    }
    NSInteger headerHeight = self.scrollView.qc_offsetY;
    if (headerHeight == -64) {
        self.headerAnimationHeight = 64;
    } else {
        self.headerAnimationHeight = 20;
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
    
    if (-point.y < QCRefreshHeaderHeight && self.scrollView.isDragging) {
        [self.refreshingLabel.layer addSublayer:_pathLayer];
    }
    
    QCHalfCandyAnimationRefresh *animation = [QCHalfCandyAnimationRefresh defaultAnimationRefresh];
    if (-point.y - _headerAnimationHeight > 0 && self.scrollView.isDragging) {
        [animation animationTimeOffset:(-point.y - _headerAnimationHeight) / QCRefreshHeaderHeight * 10];
    }

}

@end
