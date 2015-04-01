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
#import "AppDelegate.h"



@interface LifeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *lifeTable;
@property (nonatomic, strong) NSMutableArray *articleArr;


@property (nonatomic, strong)NSIndexPath *indexPath;

@end

@implementation LifeViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.articleArr = [NSMutableArray array];
        self.articleQuery = [BmobQuery queryWithClassName:@"Article"];
        [self.articleQuery orderByDescending:@"createdAt"];
        self.articleQuery.cachePolicy = kBmobCachePolicyNetworkElseCache;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"neusoft";
    BOOL hasLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"hasLogin"];
    if (!hasLogin) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:loginVC] animated:YES completion:^{
            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
            [delegate.statusBarView removeFromSuperview];
        }];
        
    }
        
        [self setupRefreshWith:self.lifeTable];
        
        TabView *tabView = [[TabView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, [UIScreen mainScreen].bounds.size.width, 44)];
        [self.view addSubview:tabView];
}

- (void)getData
{
    self.articleQuery.limit = self.limit;
    self.articleQuery.skip = self.skip;
    [self.articleQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (nil != array) {
            if (self.getDataType == refreshData) {
                [self.articleArr removeAllObjects];
            }
            for (BmobObject *object in array) {
                Article *article = [[Article alloc] initWithBmobObject:object];
               
                [self.articleArr addObject:article];
            }
        }
        NSLog(@"array:%@", self.articleArr);
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.articleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseModel *article = self.articleArr[indexPath.section];
    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([article class])];
    
    if (!cell) {
        cell = [CellFactory cellForModel:article];
    }

    cell.dataModel = article;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
