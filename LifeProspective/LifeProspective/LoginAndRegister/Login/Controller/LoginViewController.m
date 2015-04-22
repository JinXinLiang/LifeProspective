//
//  LoginViewController.m
//  LifeProspective
//
//  Created by Eiwodetianna on 15/3/6.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "LoginAndRegisterTextFieldHandler.h"
#import "LifeViewController.h"
#import <BmobSDK/Bmob.h>
#import "AppDelegate.h"
#import "CommonUtil.h"
#import "MBProgressHUD.h"
#import <BmobIM/BmobUserManager.h>
#import "Location.h"
#import "UserService.h"
#import "MenuViewController.h"

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;



@end

@implementation LoginViewController

- (IBAction)loginButtonAction:(id)sender {
    MBProgressHUD *hud = (MBProgressHUD *)[self.view viewWithTag:kMBProgressTag];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"登陆中...";
    [hud show:YES];
    [hud hide:YES afterDelay:10.0f];
    
    //登陆
    [UserService logInWithUsernameInBackground:self.userName.text password:self.password.text block:^(BmobUser *user, NSError *error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                hud.labelText = [[error userInfo] objectForKey:@"error"];
                hud.mode = MBProgressHUDModeText;
                [hud show:YES];
                [hud hide:YES afterDelay:0.7f];
            });
        
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hide:YES];
                [self dismissViewControllerAnimated:YES completion:nil];
                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                [userDefault setBool:YES forKey:@"hasLogin"];
                [userDefault setObject:self.userName.text forKey:@"userName"];
                [userDefault setObject:self.password.text forKey:@"password"];
                [userDefault synchronize];
                [UserService saveFriendsList];
                AppDelegate *delegate = [UIApplication sharedApplication].delegate;
                if ([delegate.window.rootViewController isEqual:self.navigationController]) {
                    
                    
                    delegate.window.rootViewController = delegate.drawerController;
                    
                } else {
                    LifeViewController *lifeVC = [[LifeViewController alloc] init];
                    // 将主页面加到视图控制器中
                    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:lifeVC];
                    delegate.drawerController.centerViewController = navigationController;
                    delegate.drawerController.leftDrawerViewController = [[MenuViewController alloc] init];
                }
            });
        
        }
    }];
    
//    [BmobUser loginWithUsernameInBackground:self.userName.text password:self.password.text block:^(BmobUser *user, NSError *error) {
//        
//        if (!error) {
//            NSLog(@"成功");
//            [self dismissViewControllerAnimated:YES completion:^{
////                AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
////                [appDelegate creatStatusBarView];
//                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//                [userDefault setBool:YES forKey:@"hasLogin"];
//                [userDefault setObject:self.userName.text forKey:@"userName"];
//                [userDefault setObject:self.password.text forKey:@"password"];
//                [userDefault synchronize];
//                
//            }];
////            appDelegate.window.rootViewController = appDelegate.drawerController;
////            LifeViewController *lifeVC = [[LifeViewController alloc] init];
////            UINavigationController *lifeNaviVC = [[UINavigationController alloc] initWithRootViewController:lifeVC];
////            [self presentViewController:lifeNaviVC animated:YES completion:^{
////                
////                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasLogin"];
////            }];
//            
//        } else {
//            NSLog(@"%@", error.description);
//        
//        }
//    }];
}

- (IBAction)registerButtonAction:(id)sender {
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    self.userName.text = [userDefault objectForKey:@"userName"];
    self.password.text = [userDefault objectForKey:@"password"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.userName.borderStyle = UITextBorderStyleRoundedRect;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.textFieldHandler instanceLoginUserTextField:self.userName WithType:userNameType];
   
    [self.userName becomeFirstResponder];
    [self.textFieldHandler instanceLoginUserTextField:self.password WithType:passwordType];
    self.loginBtn.backgroundColor = [UIColor lifeGreenColor];
    self.loginBtn.layer.cornerRadius = 4;
    
    self.loginBtn.clipsToBounds = YES;


//    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.tag = kMBProgressTag;
    [self.view addSubview:hud];
    // Do any additional setup after loading the view from its nib.
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
