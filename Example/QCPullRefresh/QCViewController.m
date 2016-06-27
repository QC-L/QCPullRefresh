//
//  QCViewController.m
//  QCPullRefresh
//
//  Created by QCL on 06/27/2016.
//  Copyright (c) 2016 QCL. All rights reserved.
//

#import "QCViewController.h"
#import <QCPullRefresh/QCPullRefresh.h>

@interface QCViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation QCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.myTableView.qc_header = [QCPullRefreshAnimationHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.myTableView reloadData];
            [_myTableView.qc_header endRefreshing];
        });
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    cell.textLabel.text = @"嘿嘿";
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
