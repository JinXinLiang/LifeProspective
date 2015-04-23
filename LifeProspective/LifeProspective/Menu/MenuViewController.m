//
//  MenuViewController.m
//  LifeProspective
//
//  Created by Eiwodetianna on 15/3/19.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import "MenuViewController.h"
#import "UIColor+AddColor.h"
#import <BmobSDK/BmobUser.h>
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "LifeViewController.h"

//#import <BmobIM/BmobChat.h>
#import <BmobIM/BmobDB.h>
#import <BmobIM/BmobChatManager.h>
#import <BmobIM/BmobIM.h>
#import "RecentViewController.h"
#import "ContactsViewController.h"
#import "SettingViewController.h"
#import "RootViewController.h"
#import <BmobSDK/BmobGPSSwitch.h>
//#import "BMapKit.h"
#import "CommonUtil.h"
#import "CellForMenu.h"
#import "AudioListViewController.h"

NSInteger flag = 0;

typedef enum : NSUInteger {
    ArticleType = 10000,
    ChatType,
    AudioType,
    SettingType,
} SelectedMenuType;

@interface MenuViewController ()<UITableViewDataSource, UITableViewDelegate>
//{
//    
//    BMKMapManager *_mapManager;
//}


@property (strong, nonatomic) IBOutlet UITableView *menuTableView;
@property (strong, nonatomic) NSDictionary *menuImage;
@property (strong, nonatomic) NSIndexPath *indexPath;

@property (nonatomic, assign) SelectedMenuType selectedMenuType;

@end

@implementation MenuViewController


- (IBAction)buttonAction:(UIButton *)sender {
    
    flag = sender.tag - 10000;
    for (int i = 10000; i < 10004; i++) {
        
        UIButton *button = (UIButton *)[self.view viewWithTag:i];
        NSString *state = i == sender.tag ? @"selected" : @"normal";
        [button setBackgroundImage:self.menuImage[state][i - 10000] forState:UIControlStateNormal];
    }
    if (self.selectedMenuType != sender.tag) {
        self.selectedMenuType = sender.tag;

        UIViewController *centerVC = nil;
        switch (self.selectedMenuType) {
            case ArticleType: {
                LifeViewController *lifeVC = [[LifeViewController alloc] init];
                // 将主页面加到视图控制器中
                UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:lifeVC];
                centerVC = (UIViewController *)navigationController;
            }
                break;
            case ChatType: {
                [BmobGPSSwitch gpsSwitch:NO];
                
                RecentViewController *rvc            = [[RecentViewController alloc] init];
                UINavigationController *rnc          = [[UINavigationController alloc] initWithRootViewController:rvc];
                ContactsViewController *cvc          = [[ContactsViewController alloc] init];
                UINavigationController *cnc          = [[UINavigationController alloc] initWithRootViewController:cvc];
                
                
                RootViewController *tabBarController = [[RootViewController alloc] init];
                
                [rnc.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_bar"] forBarMetrics:UIBarMetricsDefault];
                [cnc.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_bar"] forBarMetrics:UIBarMetricsDefault];
                //                [snc.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_bar"] forBarMetrics:UIBarMetricsDefault];
                
                [tabBarController setViewControllers:@[rnc,cnc]];
                centerVC = (UIViewController *)tabBarController;
            }
                break;
            case AudioType: {
                AudioListViewController *audioVC = [[AudioListViewController alloc] init];
                // 将主页面加到视图控制器中
                UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:audioVC];
                centerVC = (UIViewController *)navigationController;
            }
                break;
            case SettingType: {
                SettingViewController *settingVC           = [[SettingViewController alloc] init];
                UINavigationController *navigationController          = [[UINavigationController alloc] initWithRootViewController:settingVC];
                centerVC = (UIViewController *)navigationController;

            }
                break;
                
            default:
                break;
        }
//        if (self.selectedMenuType == ChatType) {
//            
//            [BmobGPSSwitch gpsSwitch:NO];
//            
//            RecentViewController *rvc            = [[RecentViewController alloc] init];
//            UINavigationController *rnc          = [[UINavigationController alloc] initWithRootViewController:rvc];
//            ContactsViewController *cvc          = [[ContactsViewController alloc] init];
//            UINavigationController *cnc          = [[UINavigationController alloc] initWithRootViewController:cvc];
//            
//            
//            RootViewController *tabBarController = [[RootViewController alloc] init];
//
//                [rnc.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_bar"] forBarMetrics:UIBarMetricsDefault];
//                [cnc.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_bar"] forBarMetrics:UIBarMetricsDefault];
////                [snc.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_bar"] forBarMetrics:UIBarMetricsDefault];
//
//            [tabBarController setViewControllers:@[rnc,cnc]];
//            centerVC = (UIViewController *)tabBarController;
//        }else if (self.selectedMenuType == SettingType) {
//            SettingViewController *svc           = [[SettingViewController alloc] init];
//            UINavigationController *snc          = [[UINavigationController alloc] initWithRootViewController:svc];
//            centerVC = (UIViewController *)snc;
//        } else {
//            LifeViewController *lifeVC = [[LifeViewController alloc] init];
//            // 将主页面加到视图控制器中
//            UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:lifeVC];
//            centerVC = (UIViewController *)navigationController;
//        }
        
        //    self.window.rootViewController = tabBarController;
        //    [BmobUser logout];
        //    LoginViewController *loginVC = [[LoginViewController alloc] init];
        //    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:loginVC] animated:YES completion:^{
        //        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        //        [appDelegate.statusBarView removeFromSuperview];
        //    }];
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        appDelegate.drawerController.centerViewController = centerVC;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    self.selectedMenuType = ArticleType;
    self.menuImage = @{@"normal": @[[UIImage imageNamed:@"article_normal"], [UIImage imageNamed:@"chat_normal"], [UIImage imageNamed:@"voice_normal"], [UIImage imageNamed:@"setting_normal"]],@"selected":@[[UIImage imageNamed:@"article_selected"], [UIImage imageNamed:@"chat_selected"], [UIImage imageNamed:@"voice_selected"], [UIImage imageNamed:@"setting_selected"]]};
    self.menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.menuTableView.rowHeight = 120.f;
//    self.menuTableView.backgroundColor = [UIColor colorFromHexCode:@"#1c1c1c"];
//    self.view.backgroundColor = [UIColor colorFromHexCode:@"#1c1c1c"];
//    self.menuTableView.rowHeight = SCREENHEIGHT / 5 + 15;
//    [self.menuTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
//    if ([self.menuTableView respondsToSelector:@selector(setSeparatorInset:)]) {
//        
//        [self.menuTableView setSeparatorInset:UIEdgeInsetsZero];
//        
//    }
//    
//    if ([self.menuTableView respondsToSelector:@selector(setLayoutMargins:)]) {
//        
//        [self.menuTableView setLayoutMargins:UIEdgeInsetsZero];
//        
//    }
   
   
}


//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//
//{
//    
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//        
//    }
//    
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//        
//    }
//    
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 0.1;
//}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *resuse = @"cell";
    CellForMenu *cell = [tableView dequeueReusableCellWithIdentifier:resuse];
    if (!cell) {
        cell = [[CellForMenu alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:resuse];
        cell.contentView.backgroundColor = [UIColor colorFromHexCode:@"#1c1c1c"];
    }
    if (!self.indexPath) {
        
        
        cell.menuItem.image = (indexPath.row == 0) ? self.menuImage[@"selected"][indexPath.row] : self.menuImage[@"normal"][indexPath.row];
        
    } else {
        cell.menuItem.image = (self.indexPath.section == indexPath.section && self.indexPath.row == indexPath.row) ? self.menuImage[@"selected"][indexPath.row] : self.menuImage[@"normal"][indexPath.row];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.indexPath.section != indexPath.section && self.indexPath.row != indexPath.row) {
        
        self.indexPath = indexPath;
        [tableView reloadData];
        UIViewController *centerVC = nil;
        if (indexPath.row == 1) {
            
            [BmobGPSSwitch gpsSwitch:NO];
            
            RecentViewController *rvc            = [[RecentViewController alloc] init];
            UINavigationController *rnc          = [[UINavigationController alloc] initWithRootViewController:rvc];
            ContactsViewController *cvc          = [[ContactsViewController alloc] init];
            UINavigationController *cnc          = [[UINavigationController alloc] initWithRootViewController:cvc];
            SettingViewController *svc           = [[SettingViewController alloc] init];
            UINavigationController *snc          = [[UINavigationController alloc] initWithRootViewController:svc];
            
            RootViewController *tabBarController = [[RootViewController alloc] init];
            
            if (IS_iOS7) {
                [rnc.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_bar"] forBarMetrics:UIBarMetricsDefault];
                [cnc.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_bar"] forBarMetrics:UIBarMetricsDefault];
                [snc.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_bar"] forBarMetrics:UIBarMetricsDefault];
            }else{
                [rnc.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_bar1"] forBarMetrics:UIBarMetricsDefault];
                [cnc.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_bar1"] forBarMetrics:UIBarMetricsDefault];
                [snc.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_bar1"] forBarMetrics:UIBarMetricsDefault];
            }
            [tabBarController setViewControllers:@[rnc,cnc,snc]];
            
            centerVC = (UIViewController *)tabBarController;
        } else {
            LifeViewController *lifeVC = [[LifeViewController alloc] init];
            // 将主页面加到视图控制器中
            UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:lifeVC];
            centerVC = (UIViewController *)navigationController;
        }
        
        //    self.window.rootViewController = tabBarController;
        //    [BmobUser logout];
        //    LoginViewController *loginVC = [[LoginViewController alloc] init];
        //    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:loginVC] animated:YES completion:^{
        //        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        //        [appDelegate.statusBarView removeFromSuperview];
        //    }];
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        appDelegate.drawerController.centerViewController = centerVC;
    }
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
