//
//  QCHalfCandyAnimationRefresh.m
//  QCPullRefresh
//
//  Created by QC.L on 16/6/26.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "QCHalfCandyAnimationRefresh.h"

@interface QCHalfCandyAnimationRefresh ()
@property (nonatomic, strong) CALayer *pathLayer;
@property (nonatomic, copy) NSString *pathTitle;
@end

@implementation QCHalfCandyAnimationRefresh
+ (QCHalfCandyAnimationRefresh *)defaultAnimationRefresh {
    static QCHalfCandyAnimationRefresh *animationRefresh = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        animationRefresh = [[QCHalfCandyAnimationRefresh alloc] init];
    });
    return animationRefresh;
}

- (NSAttributedString *)handleStringWithTitle:(NSString *)title {
    CTFontRef font = CTFontCreateWithName(CFSTR("HelveticaNeue-UltraLight"), 24.0f, NULL);
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)font, kCTFontAttributeName, nil];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:title attributes:attrs];
    CFRelease(font);
    return attrString;
    
}

- (UIBezierPath *)getPathWithAttributedString:(NSAttributedString *)attributedString {
    CGMutablePathRef letters = CGPathCreateMutable();
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attributedString);
    CFArrayRef runArray = CTLineGetGlyphRuns(line);
    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++) {
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++) {
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);
            CTRunGetPositions(run, thisGlyphRange, &position);
            
            CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
            CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
            CGPathAddPath(letters, &t, letter);
            CGPathRelease(letter);
        }
    }
    CFRelease(line);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path appendPath:[UIBezierPath bezierPathWithCGPath:letters]];
    
    CGPathRelease(letters);
    return path;
}

- (CALayer *)qcHalfCandyAnimationRefreshWithTitle:(NSString *)title {
    if ([_pathTitle isEqualToString:title] && _pathLayer) {
        _pathLayer.timeOffset = 0.0f;
        return _pathLayer;
    }
    NSAttributedString *attrString = [self handleStringWithTitle:title];
    UIBezierPath *path = [self getPathWithAttributedString:attrString];
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.bounds = CGPathGetBoundingBox(path.CGPath);
    pathLayer.geometryFlipped = YES;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = [UIColor colorWithRed:234.0/255 green:84.0/255 blue:87.0/255 alpha:1].CGColor;
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 0.5f;
    pathLayer.lineJoin = kCALineJoinBevel;
    pathLayer.speed = 0;
    pathLayer.timeOffset = 0;
    
    self.pathLayer = pathLayer;
    self.pathTitle = title;
    return pathLayer;
}

- (void)addRefreshingAnimation {
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 10.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.removedOnCompletion = NO;
    [self.pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
}

- (void)animationTimeOffset:(CGFloat)offset {
    if (!self.pathLayer) {
        return;
    }
    self.pathLayer.timeOffset = offset;
}

@end
