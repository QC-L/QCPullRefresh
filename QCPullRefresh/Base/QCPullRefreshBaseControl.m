//
//  QCPullRefreshControl.m
//  QCPullRefresh
//
//  Created by QC.L on 16/6/24.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "QCPullRefreshBaseControl.h"

@interface QCPullRefreshBaseControl ()
@property (nonatomic, strong) UIPanGestureRecognizer *scrollViewPan;
@end

@implementation QCPullRefreshBaseControl

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepare];
        
        self.state = QCRefreshStateNormal;
        self.isHaveAnimationEndRefresh = YES;
    }
    return self;
}

- (void)prepare {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.backgroundColor = [UIColor clearColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self placeSubviews];
}

- (void)placeSubviews {}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]]) return;
    [self removeObservers];
    if (newSuperview) {
        self.qc_width = newSuperview.qc_width;
        self.qc_x = 0;
        
        _scrollView = (UIScrollView *)newSuperview;
        // 垂直弹簧效果
        _scrollView.alwaysBounceVertical = YES;
        // 记录初始的ContentInset
        _scrollViewOriginalInset = _scrollView.contentInset;
        
        [self addObservers];
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (self.state == QCRefreshStateWillRefresh) {
        self.state = QCRefreshStateRefreshing;
    }
}

- (void)addObservers {
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:QCRefreshKeyPathContentOffset options:options context:nil];
    [self.scrollView addObserver:self forKeyPath:QCRefreshKeyPathContentSize options:options context:nil];
    self.scrollViewPan = self.scrollView.panGestureRecognizer;
    [self.scrollViewPan addObserver:self forKeyPath:QCRefreshKeyPathPanState options:options context:nil];
    
}

- (void)removeObservers {
    [self.superview removeObserver:self forKeyPath:QCRefreshKeyPathContentSize];
    [self.superview removeObserver:self forKeyPath:QCRefreshKeyPathContentOffset];
    [self.scrollViewPan removeObserver:self forKeyPath:QCRefreshKeyPathPanState];
    self.scrollViewPan = nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    // 如果关闭了交互就直接返回
    if (!self.userInteractionEnabled) return;
    
    if ([keyPath isEqualToString:QCRefreshKeyPathContentSize]) {
        [self scrollViewContentSizeDidChange:change];
    }
    
    if (self.hidden) return;
    
    if ([keyPath isEqualToString:QCRefreshKeyPathContentOffset]) {
        [self scrollViewContentOffsetDidChange:change];
    } else if ([keyPath isEqualToString:QCRefreshKeyPathPanState]) {
        [self scrollViewPanStateDidChange:change];
    }
}

- (void)scrollViewPanStateDidChange:(NSDictionary *)change {}
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {}
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {}

- (void)setRefreshingTarget:(id)refreshingTarget refreshingAction:(SEL)refreshingAction {
    self.refreshingTarget = refreshingTarget;
    self.refreshingAction = refreshingAction;
}

- (void)setState:(QCRefreshState)state {
    _state = state;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setNeedsLayout];
    });
}

- (void)beginRefreshing {
    [UIView animateWithDuration:QCRefreshFastAnimationDuration animations:^{
        self.alpha = 1.0;
    }];
    self.pullingPercent = 1.0;
    if (self.window) {
        self.state = QCRefreshStateRefreshing;
    } else {
        // 预防当前正在刷新时 调用本方法使得header insert回置失败
        if (self.state != QCRefreshStateRefreshing) {
            self.state = QCRefreshStateWillRefresh;
            [self setNeedsDisplay];
        }
    }
}

- (void)endRefreshing {
    self.state = QCRefreshStateNormal;
}

- (void)endRefreshingAnimation:(BOOL)isAnimation {
    [self endRefreshingAnimation:isAnimation completion:nil];
}
- (void)endRefreshingAnimation:(BOOL)isAnimation
                    completion:(QCRefreshBaseControlEndRefreshingCompletionBlock)completion {
    self.isHaveAnimationEndRefresh = isAnimation;
    self.endRefreshingCompletionBlock = completion;
    [self endRefreshing];
    
}

- (BOOL)isRefreshing {
    return self.state == QCRefreshStateRefreshing || self.state == QCRefreshStateWillRefresh;
}

- (void)setAutomaticallyChangeAlpha:(BOOL)automaticallyChangeAlpha
{
    _automaticallyChangeAlpha = automaticallyChangeAlpha;
    
    if (self.isRefreshing) return;
    
    if (automaticallyChangeAlpha) {
        self.alpha = self.pullingPercent;
    } else {
        self.alpha = 1.0;
    }
}

#pragma mark 根据拖拽进度设置透明度
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    _pullingPercent = pullingPercent;
    
    if (self.isRefreshing) return;
    
    if (self.isAutomaticallyChangeAlpha) {
        self.alpha = pullingPercent;
    }
}

- (void)executeRefreshingCallback {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.refreshingBlock) {
            self.refreshingBlock();
        }
        if ([self.refreshingTarget respondsToSelector:self.refreshingAction]) {
            QCRefreshMsgSend(QCRefreshMsgTarget(self.refreshingTarget), self.refreshingAction, self);
        }
        
        if (self.beginRefreshingCompletionBlock) {
            self.beginRefreshingCompletionBlock();
        }
    });
}

@end

@implementation UILabel (QCPullRefresh)

+ (instancetype)qc_label {
    UILabel *label = [[self alloc] init];
    label.font = QCRefreshLabelFont;
    label.textColor = QCRefreshLabelTextColor;
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    return label;
}

- (CGFloat)qc_textWidth {
    CGFloat stringWidth = 0;
    CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
    if (self.text.length > 0) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        stringWidth = [self.text boundingRectWithSize:size
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{NSFontAttributeName:self.font}
                                              context:nil].size.width;
#else
        stringWidth = [self.text sizeWithFont:self.font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping].width;
#endif
    }
    return stringWidth;
}

@end
