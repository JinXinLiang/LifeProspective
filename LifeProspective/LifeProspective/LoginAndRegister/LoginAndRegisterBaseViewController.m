//
//  LoginAndRegisterBaseViewController.m
//  LifeProspective
//
//  Created by Eiwodetianna on 15/3/19.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import "LoginAndRegisterBaseViewController.h"
#import "UIColor+AddColor.h"
#import "AppDelegate.h"



@interface LoginAndRegisterBaseViewController ()


@end

@implementation LoginAndRegisterBaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate creatStatusBarView];
    self.textFieldHandler = [[LoginAndRegisterTextFieldHandler alloc] init];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lifeBackgroundColor];

}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate.statusBarView removeFromSuperview];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
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
