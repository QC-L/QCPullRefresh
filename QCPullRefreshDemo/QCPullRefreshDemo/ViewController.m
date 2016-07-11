//
//  ViewController.m
//  QCPullRefreshDemo
//
//  Created by QC.L on 16/6/27.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "ViewController.h"
#import "QCPullRefresh.h"
#import "BaseViewController.h"


static NSString * const kTableViewCellReuse = @"reuse";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *refreshDemoTableView;
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *tableViewArray = [NSArray arrayWithObjects:@"UseDefaultTtileTableView", @"UseYourSelfTitleTableView", nil];
    NSArray *collectionViewArray = [NSArray arrayWithObjects:@"UseDefaultTtileCollectionView", @"UseYourSelfTitleCollectionView", nil];
    self.array = [NSMutableArray arrayWithObjects:tableViewArray, collectionViewArray, nil];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 200)];
    view.backgroundColor = [UIColor greenColor];
    _refreshDemoTableView.tableHeaderView = view;
    

    _refreshDemoTableView.qc_header = [QCPullRefreshAnimationHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_refreshDemoTableView.qc_header endRefreshing];
        });
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.array[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"tableView";
    } else {
        return @"collectionView";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellReuse];
    cell.textLabel.text = self.array[indexPath.section][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *classPrefix = self.array[indexPath.section][indexPath.row];
    NSString *className = [classPrefix stringByAppendingString:@"ViewController"];
    Class cls = NSClassFromString(className);
    if (cls) {
        BaseViewController *clsVC = [[cls alloc] init];
        clsVC.classPrefix = classPrefix;
        [self.navigationController pushViewController:clsVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
