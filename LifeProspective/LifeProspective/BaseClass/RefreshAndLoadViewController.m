//
//  RefreshAndLoadViewController.m
//  LifeProspective
//
//  Created by Eiwodetianna on 15/3/31.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import "RefreshAndLoadViewController.h"
#import "MJRefresh.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"



@interface RefreshAndLoadViewController ()<UIScrollViewDelegate>




@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) CGFloat offsetY;

@property (nonatomic, strong) UILabel *header;

@end

@implementation RefreshAndLoadViewController



- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.getDataType = refreshData;
        self.limit = 10;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationController.navigationBar.translucent = NO;
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backgroundView.image = [UIImage imageNamed:@"background"];
        [self.view addSubview:backgroundView];
    [self.view sendSubviewToBack:backgroundView];
//    UITapGestureRecognizer * doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
//    [doubleTap setNumberOfTapsRequired:2];
//    [self.view addGestureRecognizer:doubleTap];
//    UITapGestureRecognizer * twoFingerDoubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingerDoubleTap:)];
//    [twoFingerDoubleTap setNumberOfTapsRequired:2];
//    [twoFingerDoubleTap setNumberOfTouchesRequired:2];
//    [self.view addGestureRecognizer:twoFingerDoubleTap];
    
  
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupLeftMenuButton];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.menuBtn removeFromSuperview];
}

- (void)setupRefreshWith:(UIScrollView *)scrollView
{
//    NSLog(@"进入了setupRefresh");
// 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    self.scrollView = scrollView;
    [self beginRefreshing];
//    [self.scrollView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing:)];
//#warning 自动刷新(一进入程序就下拉刷新)
//    [self.scrollView.header beginRefreshing];
//    
//    
//// 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
//    [self.scrollView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRereshing:)];
    
}

- (void)getData
{
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.offsetY = scrollView.contentOffset.y;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.contentOffset.y + 100 < 0) {
        [self beginRefreshing];
    } else if (scrollView.contentOffset.y > scrollView.contentSize.height - SCREENHEIGHT && scrollView.contentSize.height > SCREENHEIGHT) {
        [self beginLoading];
    }
}

- (void)beginRefreshing {
    [self addRefreshHeader];
    [UIView animateWithDuration:0.2f animations:^{
        
        self.scrollView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
        
        
    }];
    self.skip = 0;
    self.getDataType = refreshData;
    // 创建队列   在刷新方法里    如果创建在viewdidload里   会出现卡顿现象
    [self getData];
    
    
    [self endRefreshing];
}

- (void)addRefreshHeader{
    self.header = [[UILabel alloc] initWithFrame:CGRectMake(0, 67, SCREENWIDTH, 30)];
    self.header.text = @"loading";
    self.header.backgroundColor = [UIColor blackColor];
    self.header.textColor = [UIColor whiteColor];
    self.header.alpha = 0.2f;
    self.header.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.header];
    self.scrollView.scrollEnabled = NO;
//    NSLayoutConstraint *bottomContstraint = [NSLayoutConstraint constraintWithItem:self.header attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
//    NSLayoutConstraint *leadingContstraint = [NSLayoutConstraint constraintWithItem:self.header attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:-10];
//    NSLayoutConstraint *trailingContstraint = [NSLayoutConstraint constraintWithItem:self.header attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-10];
//    NSLayoutConstraint *heightContstraint = [NSLayoutConstraint constraintWithItem:self.header attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40];
//    self.header.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.header addConstraint:heightContstraint];
//    [self.scrollView addConstraints:@[leadingContstraint, trailingContstraint, bottomContstraint]];
    
}

- (void)removeRefreshHeader{
    self.scrollView.scrollEnabled = YES;
    [self.header removeFromSuperview];
}

- (void)beginLoading {
    self.getDataType = loadData;
    self.skip += 10;
    if (self.dataArr.count + 10 > self.skip) {
        
        [self getData];
    }
    
    
    
    // 2.2秒后刷新表格UI
    [self endRefreshing];
    
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing:(UIScrollView *)scrollView
{
    
    
}

- (void)footerRereshing:(UIScrollView *)scrollView
{
    
// 1.添加假数据
    
// 在加载方法里创建子线程    会造成刷新不成功
    

}

- (void)endRefreshing
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:0.2f animations:^{
            
            self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            [self removeRefreshHeader];
        }];
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

// 设置navigation的左按钮为抽屉开关
-(void)setupLeftMenuButton{
    
    self.menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.menuBtn.frame = CGRectMake(15, 5, 30, 33);
    [self.menuBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [self.menuBtn addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:self.menuBtn];
}
// 触发的方法
#pragma mark - Button Handlers
-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}




-(void)twoFingerDoubleTap:(UITapGestureRecognizer*)gesture{
    [self.mm_drawerController bouncePreviewForDrawerSide:MMDrawerSideRight completion:nil];
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
