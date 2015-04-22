//
//  UserService.h
//  BmobIMDemo
//
//  Created by Bmob on 14-7-11.
//  Copyright (c) 2014年 bmob. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <BmobSDK/Bmob.h>

@interface UserService : NSObject

/**
 *  登陆
 *
 *  @param username 用户名
 *  @param password 密码
 *  @param block    登陆结果
 */
+(void)logInWithUsernameInBackground:(NSString *)username
                            password:(NSString *)password
                               block:(BmobUserResultBlock)block;



/**
 *  注册
 *
 *  @param username  用户名
 *  @param password  密码
 *  @param imageUrl  用户头像
 *  @param userPhoto  用户邮箱
 *  @param sucessful 定位是否成功
 *  @param block     注册结果
 */
+(void)registerWithUsernameInBackground:(NSString *)username
                               password:(NSString *)password userPhoto:(UIImage *)userPhoto email:(NSString *)email
                        locateSucessful:(BOOL)successful
                                  block:(BmobBooleanResultBlock)block;


+(void)saveFriendsList;

@end
