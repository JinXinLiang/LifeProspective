//
//  LifeViewController.m
//  LifeProspective
//
//  Created by Eiwodetianna on 15/3/19.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import "LifeViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "BaseCell.h"
#import "BaseModel.h"
#import "CellFactory.h"
#import "Article.h"
#import "CellForArticle.h"
#import "TabView.h"
#import "LoginViewController.h"
#import "DetailViewController.h"


@interface LifeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *lifeTable;
@property (nonatomic, strong) NSMutableArray *articleArr;


@property (nonatomic, strong)NSIndexPath *indexPath;

@property (nonatomic, strong) UIImageView *seperater;

@end

@implementation LifeViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //用户存在就创建数据库
//        BmobUser *user = [BmobUser getCurrentUser];
//        if (user) {
//            BmobDB *db = [BmobDB currentDatabase];
//            [db createDataBase];
//        }else{
//            
//        }
        self.dataArr = [NSMutableArray array];
        self.articleArr = self.dataArr;
        self.query = [BmobQuery queryWithClassName:@"Article"];
        [self.query orderByDescending:@"createdAt"];
        self.query.cachePolicy = kBmobCachePolicyCacheThenNetwork;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"准资讯";
//    BOOL hasLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"hasLogin"];
//    if (!hasLogin) {
//        LoginViewController *loginVC = [[LoginViewController alloc] init];
//        
//        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:loginVC] animated:NO completion:^{
//            [self setupRefreshWith:self.lifeTable];
//        }];
//        
//    } else {
    self.lifeTable.backgroundColor = [UIColor clearColor];
        [self setupRefreshWith:self.lifeTable];
//    }
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    
    
//    TabView *tabView = [[TabView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, [UIScreen mainScreen].bounds.size.width, 44)];
//    [self.view addSubview:tabView];
//    
//    NSLayoutConstraint *bottomContstraint = [NSLayoutConstraint constraintWithItem:tabView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
//    NSLayoutConstraint *leadingContstraint = [NSLayoutConstraint constraintWithItem:tabView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
//    NSLayoutConstraint *trailingContstraint = [NSLayoutConstraint constraintWithItem:tabView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
//    NSLayoutConstraint *heightContstraint = [NSLayoutConstraint constraintWithItem:tabView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:44];
//    tabView.translatesAutoresizingMaskIntoConstraints = NO;
//    [tabView addConstraint:heightContstraint];
//    [self.view addConstraints:@[leadingContstraint, trailingContstraint, bottomContstraint]];
    self.lifeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}



- (void)getData
{
    self.query.limit = self.limit;
    self.query.skip = self.skip;
    __block NSInteger count = 1;
    [self.query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (nil != array) {
            if (1 == count) {
                
                if (self.getDataType == refreshData) {
                    [self.articleArr removeAllObjects];
                }
                for (BmobObject *object in array) {
                    Article *article = [[Article alloc] initWithBmobObject:object];
                    
                    [self.articleArr addObject:article];
                }
                
            }
            
        }
        NSLog(@"array:%@", self.articleArr);
        [self endRefreshing];
    }];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 10;
//}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return self.articleArr.count;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 40;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    return [[UIView alloc]  initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240;
}
#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.articleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseModel *article = self.articleArr[indexPath.row];
    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([article class])];
    
    if (!cell) {
        cell = [CellFactory cellForModel:article];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    if (self.articleArr.count != 0) {
        
        cell.dataModel = article;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    Article *article = self.articleArr[indexPath.row];
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.articleModel = article;
    [self.navigationController pushViewController:detailVC animated:YES];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)menuButtonClicked:(int)index
{
    
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
