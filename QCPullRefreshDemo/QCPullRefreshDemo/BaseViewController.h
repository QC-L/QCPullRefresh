//
//  BaseViewController.h
//  QCPullRefreshDemo
//
//  Created by QC.L on 16/6/29.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCPullRefresh.h"

@interface BaseViewController : UIViewController
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *classPrefix;
@end
