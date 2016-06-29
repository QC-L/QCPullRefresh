//
//  ViewController.m
//  QCPullRefreshDemo
//
//  Created by QC.L on 16/6/27.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "ViewController.h"
#import "BaseViewController.h"
#import "QCPullRefresh.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *refreshDemoTableView;
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.array = [NSMutableArray arrayWithObjects:@"UseDefaultTtile", @"UseYourSelfTitle", nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    cell.textLabel.text = self.array[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *classPrefix = self.array[indexPath.row];
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
