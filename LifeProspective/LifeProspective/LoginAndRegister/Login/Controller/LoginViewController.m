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

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;



@end

@implementation LoginViewController

- (IBAction)registerButtonAction:(id)sender {
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.userName.borderStyle = UITextBorderStyleRoundedRect;

    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.textFieldHandler instanceLoginUserTextField:self.userName WithType:userNameType];
   
    [self.userName becomeFirstResponder];
    [self.textFieldHandler instanceLoginUserTextField:self.password WithType:passwordType];
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
