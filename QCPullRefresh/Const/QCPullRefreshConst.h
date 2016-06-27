//
//  QCPullRefreshConst.h
//  QCPullRefresh
//
//  Created by QC.L on 16/6/26.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/message.h>
#import <CoreText/CoreText.h>

#define QCWeakSelf __weak typeof(self) weakSelf = self;

#ifdef DEBUG
#define QCRefreshLog(...) NSLog(__VA_ARGS__)
#else
#define QCRefreshLog(...)
#endif

#define QCRefreshMsgSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)
#define QCRefreshMsgTarget(target) (__bridge void *)(target)

#define QCRrefreshColor(r, g, b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1.0]
#define QCRefreshLabelTextColor [UIColor redColor];

#define QCRefreshFont CTFontCreateWithName(CFSTR("HelveticaNeue-UltraLight"), 24.0f, NULL)
#define QCRefreshLabelFont (__bridge id)QCRefreshFont


UIKIT_EXTERN const CGFloat QCRefreshFastAnimationDuration;
UIKIT_EXTERN const CGFloat QCRefreshSlowAnimationDuration;
UIKIT_EXTERN const CGFloat QCRefreshHeaderHeight;

UIKIT_EXTERN NSString * const QCRefreshKeyPathPanState;
UIKIT_EXTERN NSString * const QCRefreshKeyPathContentOffset;
UIKIT_EXTERN NSString * const QCRefreshKeyPathContentSize;
UIKIT_EXTERN NSString * const QCRefreshKeyPathContentInset;


#define QCRefreshCheckState \
QCRefreshState oldState = self.state; \
if (state == oldState) return; \
[super setState:state];
