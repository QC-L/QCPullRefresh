//
//  QCHalfCandyShaowAnimation.m
//  QCPullRefresh
//
//  Created by QC.L on 16/6/27.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "QCHalfCandyShadowAnimation.h"

@interface QCHalfCandyShadowAnimation ()

@property (nonatomic, strong) CABasicAnimation *currentAnimation;

@end

@implementation QCHalfCandyShadowAnimation

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createInit];
    }
    return self;
}

- (void)createInit {
    _shadowBackgroundColor = [UIColor colorWithWhite:1. alpha:0.3f];
    _shadowForegroundColor = [UIColor whiteColor];
    _shadowWidth = 20.;
    _repeatCount = HUGE_VALF;
    _duration = 3.0f;
}

- (void)start {
    if(!self.animatedView){
        NSAssert(@"[%@ %@] animatedView is nil", NSStringFromClass([self class]), __func__);
        return;
    }
    [self stop];
    
    CAGradientLayer *gradientMask = [CAGradientLayer layer];
    gradientMask.frame = self.animatedView.bounds;
    CGFloat gradientSize = self.shadowWidth / self.animatedView.frame.size.width;
    
    NSArray *startLocations = @[
                                @0,
                                [NSNumber numberWithFloat:(gradientSize / 2.)],
                                [NSNumber numberWithFloat:gradientSize]
                                ];
    NSArray *endLocations = @[
                              [NSNumber numberWithFloat:(1. - gradientSize)],
                              [NSNumber numberWithFloat:(1. - (gradientSize / 2.))],
                              @1
                              ];
    
    
    gradientMask.colors = @[
                            (id)self.shadowBackgroundColor.CGColor,
                            (id)self.shadowForegroundColor.CGColor,
                            (id)self.shadowBackgroundColor.CGColor
                            ];
    gradientMask.locations = startLocations;
    gradientMask.startPoint = CGPointMake(0 - (gradientSize * 2), .5);
    gradientMask.endPoint = CGPointMake(1 + gradientSize, .5);
    
    self.animatedView.layer.mask = gradientMask;
    
    _currentAnimation = [CABasicAnimation animationWithKeyPath:@"locations"];
    _currentAnimation.fromValue = startLocations;
    _currentAnimation.toValue = endLocations;
    _currentAnimation.repeatCount = self.repeatCount;
    _currentAnimation.duration  = self.duration;
    _currentAnimation.delegate = self;
    [gradientMask addAnimation:_currentAnimation forKey:@"QCHalfCandyShadowAnimation"];
}

- (void)stop {
    if(self.animatedView && self.animatedView.layer.mask){
        [self.animatedView.layer.mask removeAnimationForKey:@"QCHalfCandyShadowAnimation"];
        self.animatedView.layer.mask = nil;
        _currentAnimation = nil;
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)finished
{
    if(anim == _currentAnimation){
        [self stop];
    }
}

@end
