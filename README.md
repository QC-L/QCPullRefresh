# QCPullRefresh

[![CI Status](http://img.shields.io/travis/QCL/QCPullRefresh.svg?style=flat)](https://travis-ci.org/QCL/QCPullRefresh)
[![Version](https://img.shields.io/cocoapods/v/QCPullRefresh.svg?style=flat)](http://cocoapods.org/pods/QCPullRefresh)
[![License](https://img.shields.io/cocoapods/l/QCPullRefresh.svg?style=flat)](http://cocoapods.org/pods/QCPullRefresh)
[![Platform](https://img.shields.io/cocoapods/p/QCPullRefresh.svg?style=flat)](http://cocoapods.org/pods/QCPullRefresh)

## QCPullRefreshDemo

To run the QCPullRefreshDemo project. 

![PullRefresh](pullRefresh.gif)

### If you use default, you can use

```
self.tableView.qc_header = [QCPullRefreshAnimationHeader headerWithRefreshingBlock:^{
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [self.tableView reloadData];
         [self.tableView.qc_header endRefreshing];
     });
}];
```

### If you change refresh title, you can use 

```
self.tableView.qc_header = [QCPullRefreshAnimationHeader headerPullingTitle:@"Use Your Self Title" refreshingTitle:@"Your Self Title Refreshing" headerWithRefreshingBlock:^{
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          [self.tableView reloadData];
          [self.tableView.qc_header endRefreshing];
      });
}];
```
### Notice, If you have navgationController, you can use:

```
self.edgesForExtendedLayout = UIRectEdgeNone;
```

## Installation

QCPullRefresh is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
pod 'QCPullRefresh'
```

## Author

QC.L, liqichang4869@gmail.com

## License

QCPullRefresh is available under the MIT license. See the LICENSE file for more info.

