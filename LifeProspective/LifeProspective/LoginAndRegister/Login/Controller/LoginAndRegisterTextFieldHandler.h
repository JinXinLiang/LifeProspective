//
//  LoginAndRegisterTextFieldHandler.h
//  LifeProspective
//
//  Created by Eiwodetianna on 15/3/17.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    userNameType,
    passwordType,
    emailType,
} TextFieldType;

@interface LoginAndRegisterTextFieldHandler : NSObject


///  初始化textField的设置 圆角，颜色等
//   参数一：需要初始化设置的textField
//   参数二：textField的类型;
- (void)instanceLoginUserTextField:(UITextField *)textField WithType:(TextFieldType)textFieldType;


@end
