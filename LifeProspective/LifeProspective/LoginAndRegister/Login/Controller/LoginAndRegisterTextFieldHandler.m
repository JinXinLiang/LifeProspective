//
//  LoginAndRegisterTextFieldHandler.m
//  LifeProspective
//
//  Created by Eiwodetianna on 15/3/17.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import "LoginAndRegisterTextFieldHandler.h"
#import "UIColor+AddColor.h"

@interface LoginAndRegisterTextFieldHandler ()<UITextFieldDelegate>

@property (nonatomic, strong)NSDictionary *imageDic;


@property (nonatomic, assign) TextFieldType textFieldType;
@end


@implementation LoginAndRegisterTextFieldHandler

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imageDic = @{
                          @"normal" : @[@"user_normal", @"password_normal", @"email_normal"],
                          @"selected" : @[@"user_selected", @"password_selected", @"email_selected"]};
    }
    return self;
}

- (void)instanceLoginUserTextField:(UITextField *)textField WithType:(TextFieldType)textFieldType
{
    switch (textFieldType) {
        case userNameType:
            [self instanceTextField:textField withType:userNameType];
            break;
        case passwordType:
            [self instanceTextField:textField withType:passwordType];
            break;
        case emailType:
            [self instanceTextField:textField withType:emailType];
            break;
        default:
            break;
    }
}

///  初始化textField的设置 圆角，颜色等
//   参数一：需要初始化设置的textField
//   参数二：需要通过imageName来设置的rightView;
- (void)instanceTextField:(UITextField *)textField withType:(TextFieldType)textFieldType
{
    textField.layer.borderWidth = 1;
    textField.layer.cornerRadius = 4;
    textField.layer.borderColor = [UIColor whiteColor].CGColor;
    textField.delegate = self;
    textField.layer.borderWidth = 1;
    textField.layer.cornerRadius = 4;
    textField.layer.borderColor = [UIColor whiteColor].CGColor;
    textField.rightViewMode = UITextFieldViewModeAlways;
    [self setTextField:textField withState:@"normal" AndType:textFieldType];
}

- (void)setTextField:(UITextField *)textField withState:(NSString *)state AndType:(TextFieldType)textFieldType{
    
    NSArray *imageNameArr = self.imageDic[state];
    NSString *imageName = nil;
    switch (textFieldType) {
        case userNameType:
            imageName = imageNameArr[userNameType];
            textField.tag = 10000 + 0;
            break;
        case passwordType:
            imageName = imageNameArr[passwordType];
            textField.tag = 10000 + 1;
            break;
        case emailType:
            imageName = imageNameArr[emailType];
            textField.tag = 10000 + 2;
            break;
        default:
            break;
    }
    
    UIImage *rightImage = [UIImage imageNamed:imageName];
    UIImageView *rightView = nil;
    if ([textField.rightView isKindOfClass:[UIImageView class]]) {
        
       rightView = (UIImageView *)textField.rightView;
    } else {
        rightView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, rightImage.size.width / 3, rightImage.size.height / 3)];
        textField.rightView = rightView;
    }
    rightView.image = rightImage;
}

#pragma TextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 10000:
            self.textFieldType = userNameType;
            break;
        case 10001:
            self.textFieldType = passwordType;
            break;
        case 10002:
            self.textFieldType = emailType;
            break;
        default:
            break;
    }
    textField.layer.borderColor = [UIColor lifeGreenColor].CGColor;
    [self setTextField:textField withState:@"selected" AndType:self.textFieldType];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.layer.borderColor = [UIColor whiteColor].CGColor;
    [self setTextField:textField withState:@"normal" AndType:self.textFieldType];
}

@end
