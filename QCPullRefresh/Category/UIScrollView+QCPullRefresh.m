//
//  UIScrollView+QCPullRefresh.m
//  QCPullRefresh
//
//  Created by QC.L on 16/6/26.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "UIScrollView+QCPullRefresh.h"
#import "QCPullRefreshHeader.h"
#import <objc/runtime.h>


@implementation NSObject (MJRefresh)

+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2 {
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}

+ (void)exchangeClassMethod1:(SEL)method1 method2:(SEL)method2 {
    method_exchangeImplementations(class_getClassMethod(self, method1), class_getClassMethod(self, method2));
}

@end

@implementation UIScrollView (QCPullRefresh)
static const char QCPullRefreshHeaderKey = '\0';
- (void)setQc_header:(QCPullRefreshHeader *)qc_header {
    [self.qc_header removeFromSuperview];
    [self insertSubview:qc_header atIndex:0];
    [self willChangeValueForKey:@"qc_header"];
    objc_setAssociatedObject(self, &QCPullRefreshHeaderKey, qc_header, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"qc_header"];
}

- (QCPullRefreshHeader *)qc_header {
    return objc_getAssociatedObject(self, &QCPullRefreshHeaderKey);
}

- (NSInteger)qc_totalDataCount {
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        for (NSInteger section = 0; section < tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collection = (UICollectionView *)self;
        for (NSInteger section = 0; section < collection.numberOfSections; section++) {
            totalCount += [collection numberOfItemsInSection:section];
        }
    }
    return totalCount;
}

static const char QCRefreshReloadDataBlockKey = '\0';
- (void)setQc_reloadDataBlock:(void (^)(NSInteger))qc_reloadDataBlock {
    [self willChangeValueForKey:@"qc_reloadDataBlock"];
    objc_setAssociatedObject(self, &QCRefreshReloadDataBlockKey, qc_reloadDataBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"qc_reloadDataBlock"];
}

- (void (^)(NSInteger))qc_reloadDataBlock {
    return objc_getAssociatedObject(self, &QCRefreshReloadDataBlockKey);
}

- (void)executeReloadDataBlock {
    !self.qc_reloadDataBlock ? :self.qc_reloadDataBlock(self.qc_totalDataCount);
}

@end

@implementation UITableView (QCPullRefresh)

+ (void)load {
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(qc_reloadData)];
}

- (void)qc_reloadData {
    [self qc_reloadData];
    [self executeReloadDataBlock];
}
@end

@implementation UICollectionView (MJRefresh)

+ (void)load {
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(qc_reloadData)];
}

- (void)qc_reloadData {
    [self qc_reloadData];
    [self executeReloadDataBlock];
}
@end
