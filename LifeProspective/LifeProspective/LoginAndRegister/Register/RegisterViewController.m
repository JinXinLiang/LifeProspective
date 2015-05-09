//
//  RegisterViewController.m
//  LifeProspective
//
//  Created by Eiwodetianna on 15/3/10.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import "RegisterViewController.h"

#import "FSMediaPicker.h"
#import <BmobSDK/Bmob.h>
#import "CommonUtil.h"
#import "MBProgressHUD.h"
#import <BmobIM/BmobUserManager.h>
#import <BmobSDK/BmobGPSSwitch.h>
#import "UserService.h"
#import "Location.h"
#import <CoreGraphics/CoreGraphics.h>
#import "UIColor+AddColor.h"


@interface RegisterViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, FSMediaPickerDelegate, LocationDelegate>
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UIButton *userPhoto;

@property (nonatomic, assign)BOOL hasUserPhoto;
@property (strong, nonatomic) IBOutlet UIButton *registerBtn;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.hasUserPhoto = NO;
    self.registerBtn.backgroundColor = [UIColor lifeGreenColor];
    self.registerBtn.layer.cornerRadius = 4;
    
    self.registerBtn.clipsToBounds = YES;
//    UIImage *backImage = [self scaleImage:[UIImage imageNamed:@"back"]];
//    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonAction:)];
//    self.navigationItem.leftBarButtonItem = backItem;
    
    self.navigationController.navigationBar.tintColor = [UIColor lifeGreenColor];
    
    [self.textFieldHandler instanceLoginUserTextField:self.userName WithType:userNameType];
    [self.textFieldHandler instanceLoginUserTextField:self.password WithType:passwordType];
    [self.textFieldHandler instanceLoginUserTextField:self.email WithType:emailType];
    
    MBProgressHUD *hud             = [[MBProgressHUD alloc] initWithView:self.view];
    hud.tag                        = kMBProgressTag;
    [self.view addSubview:hud];
 
}
- (IBAction)registerButtonAction:(id)sender {
    NSLog(@"button:%@", [self.userPhoto backgroundImageForState:UIControlStateNormal]);
    //    if (![pwsTextField.text isEqualToString:pwsTextField1.text]) {
    //        hud.mode = MBProgressHUDModeText;
    //        hud.labelText = @"两次输入的密码不一样!";
    //        [hud show:YES];
    //        [hud hide:YES afterDelay:0.7f];
    //        return;
    //    }
    
    NSLog(@"user:%@", [self.userName.text dataUsingEncoding:NSUTF8StringEncoding]);
    MBProgressHUD *hud = (MBProgressHUD*)[self.view viewWithTag:kMBProgressTag];

    UIImage *userPhoto = nil;
    if (self.hasUserPhoto) {
        userPhoto = [self.userPhoto backgroundImageForState:UIControlStateNormal];
    }
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"注册中...";
    [hud show:YES];
    [hud hide:YES afterDelay:10.0f];
    [UserService registerWithUsernameInBackground:self.userName.text password:self.password.text userPhoto:userPhoto email:self.email.text locateSucessful:NO block:^(BOOL isSuccessful, NSError *error) {
        
        [[Location shareInstance] stopUpateLoaction];
        if (isSuccessful) {
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"注册成功";
            [hud hide:YES afterDelay:0.7f];
            [self saveUserInfo];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            hud.mode = MBProgressHUDModeText;
            hud.labelText =[[error userInfo] objectForKey:@"error"];
            [hud hide:YES afterDelay:0.7f];
        }
    }];
    
//    BmobUser *user = [[BmobUser alloc] init];
//    [user setUserName:self.userName.text];
//    [user setPassword:self.password.text];
//    [user setEmail:self.email.text];
//    if (self.hasUserPhoto) {
//        
//        BmobFile *userPhoto = [[BmobFile alloc] initWithFileName:[NSString stringWithFormat:@"%@.png", self.userName.text] withFileData:UIImagePNGRepresentation([self.userPhoto backgroundImageForState:UIControlStateNormal])];
//        [userPhoto saveInBackground:^(BOOL isSuccessful, NSError *error) {
//            //如果文件保存成功，则把文件添加到filetype列
//            if (isSuccessful) {
//                [user setObject:userPhoto.url  forKey:@"userPhoto"];
//                //打印file文件的url地址
//                NSLog(@"file1 url %@",userPhoto.url);
//                [user signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
//                    
//                    if (isSuccessful) {
//                        
//                        [self saveUserInfo];
//                        [self.navigationController popViewControllerAnimated:YES];
//                    } else {
//                        NSLog(@"signUp error:%@", error.description);
//                    }
//                    
//                }];
//                
//            }else{
//                //进行处理
//                NSLog(@"error:%@", error.description);
//            }
//        }];
//    } else {
//        [user signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
//            if (isSuccessful) {
//                
//                [self saveUserInfo];
//                [self.navigationController popViewControllerAnimated:YES];
//            } else {
//                NSLog(@"signUp error:%@", error.description);
//            }
//        }];
//    }
//    
}

- (UIImage *)scaleImage:(UIImage *)image {
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width / 2, image.size.height / 2));
    CGRect rect = CGRectMake(0, 0, image.size.width / 2, image.size.height / 2);
    [image drawInRect:rect];
    UIImage *scaleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaleImage;
    
}

- (void)saveUserInfo
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:NO forKey:@"hasLogin"];
    [userDefault setObject:self.userName.text forKey:@"userName"];
    [userDefault setObject:self.password.text forKey:@"password"];
    [userDefault synchronize];
}

- (void)backBarButtonAction:(UIBarButtonItem *)button{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)addUserPhotoAction:(id)sender {
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
//    picker.view.backgroundColor = [UIColor whiteColor];
//    picker.delegate = self;
//    //    picker.allowsEditing = YES;//设置可编辑
//    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    [self presentViewController:picker animated:YES completion:nil];
    FSMediaPicker *mediaPicker = [[FSMediaPicker alloc] init];
    mediaPicker.mediaType = FSMediaTypePhoto;
    mediaPicker.editMode = FSEditModeStandard;
    mediaPicker.delegate = self;
    [mediaPicker showFromView:sender];

}

- (void)mediaPicker:(FSMediaPicker *)mediaPicker didFinishWithMediaInfo:(NSDictionary *)mediaInfo
{
    
    self.userPhoto.layer.borderColor = [UIColor whiteColor].CGColor;
    self.userPhoto.layer.borderWidth = 2;
    
    [self.userPhoto setTitle:nil forState:UIControlStateNormal];
    self.hasUserPhoto = YES;
    [self.userPhoto setBackgroundImage:mediaPicker.editMode == FSEditModeCircular? mediaInfo.circularEditedImage:mediaInfo.editedImage forState:UIControlStateNormal];
}

- (void)mediaPickerDidCancel:(FSMediaPicker *)mediaPicker
{
    NSLog(@"%s",__FUNCTION__);
}

#pragma locationDelegate
-(void)didUpdateLocation:(Location *)loc{
    [self registerAfterStartLocation:YES];
}

-(void)didFailWithError:(NSError *)error location:(Location *)loc{
    [self registerAfterStartLocation:NO];
}
-(void)registerAfterStartLocation:(BOOL)successful{
    
}

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    self.userPhoto.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.userPhoto.layer.borderWidth = 3;
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    
//    // 上传图片
//    
//    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//    
//    // 给imageView赋值
//    
//    [self.userPhoto setBackgroundImage:image forState:UIControlStateNormal];
//    
//}

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
