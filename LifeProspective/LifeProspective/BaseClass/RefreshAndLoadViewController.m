//
//  RefreshAndLoadViewController.m
//  LifeProspective
//
//  Created by Eiwodetianna on 15/3/31.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import "RefreshAndLoadViewController.h"
#import "MJRefresh.h"



@interface RefreshAndLoadViewController ()




@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation RefreshAndLoadViewController



- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.getDataType = refreshData;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupRefreshWith:(UIScrollView *)scrollView
{
//    NSLog(@"进入了setupRefresh");
// 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    self.scrollView = scrollView;
    [self.scrollView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing:)];
//#warning 自动刷新(一进入程序就下拉刷新)
    [self.scrollView.header beginRefreshing];
    
    
// 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.scrollView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRereshing:)];
    
}

- (void)getData
{
    
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing:(UIScrollView *)scrollView
{
    
    self.skip = 0;
    self.getDataType = refreshData;
// 创建队列   在刷新方法里    如果创建在viewdidload里   会出现卡顿现象
    [self getData];
    
    
    [self endRefreshing];
    
}

- (void)footerRereshing:(UIScrollView *)scrollView
{
    
// 1.添加假数据
    
// 在加载方法里创建子线程    会造成刷新不成功
    
    if (self.dataArr.count + 10 > self.skip) {
        
        self.skip += 10;
        [self getData];
    }
    self.getDataType = loadData;
    
    
// 2.2秒后刷新表格UI
    [self endRefreshing];
}

- (void)endRefreshing
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.scrollView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
        if (self.getDataType == refreshData) {
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [self.scrollView.header endRefreshing];
        } else {
            [self.scrollView.footer endRefreshing];
        }
        
        
        
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
