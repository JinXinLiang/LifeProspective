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


@interface RegisterViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, FSMediaPickerDelegate>
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UIButton *userPhoto;

@property (nonatomic, assign)BOOL hasUserPhoto;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.hasUserPhoto = NO;
    
    self.userPhoto.layer.cornerRadius = 50;
    
    self.userPhoto.clipsToBounds = YES;
   
    UIBarButtonItem *backItem=[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonAction:)];
    self.navigationItem.leftBarButtonItem = backItem;
    

    
    [self.textFieldHandler instanceLoginUserTextField:self.userName WithType:userNameType];
    [self.textFieldHandler instanceLoginUserTextField:self.password WithType:passwordType];
    [self.textFieldHandler instanceLoginUserTextField:self.email WithType:emailType];
 
}
- (IBAction)registerButtonAction:(id)sender {
    NSLog(@"button:%@", [self.userPhoto backgroundImageForState:UIControlStateNormal]);
    
    NSLog(@"user:%@", [self.userName.text dataUsingEncoding:NSUTF8StringEncoding]);
    BmobUser *user = [[BmobUser alloc] init];
    [user setUserName:self.userName.text];
    [user setPassword:self.password.text];
    [user setEmail:self.email.text];
    if (self.hasUserPhoto) {
        
        BmobFile *userPhoto = [[BmobFile alloc] initWithFileName:[NSString stringWithFormat:@"%@.png", self.userName.text] withFileData:UIImagePNGRepresentation([self.userPhoto backgroundImageForState:UIControlStateNormal])];
        [userPhoto saveInBackground:^(BOOL isSuccessful, NSError *error) {
            //如果文件保存成功，则把文件添加到filetype列
            if (isSuccessful) {
                [user setObject:userPhoto.url  forKey:@"userPhoto"];
                //打印file文件的url地址
                NSLog(@"file1 url %@",userPhoto.url);
                [user signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
                    
                    if (isSuccessful) {
                        
                        [self saveUserInfo];
                        [self.navigationController popViewControllerAnimated:YES];
                    } else {
                        NSLog(@"signUp error:%@", error.description);
                    }
                    
                }];
                
            }else{
                //进行处理
                NSLog(@"error:%@", error.description);
            }
        }];
    } else {
        [user signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                
                [self saveUserInfo];
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                NSLog(@"signUp error:%@", error.description);
            }
        }];
    }
    
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
