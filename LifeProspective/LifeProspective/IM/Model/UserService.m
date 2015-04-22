//
//  UserService.m
//  BmobIMDemo
//
//  Created by Bmob on 14-7-11.
//  Copyright (c) 2014年 bmob. All rights reserved.
//

#import "UserService.h"
#import "Location.h"
#import <BmobIM/BmobUserManager.h>
#import "BMapKit.h"
//#import "MBProgressHUD.h"
//#import <BmobIM/BmobDB.h>

@implementation UserService

+(void)saveFriendsList{
    BmobDB *db = [BmobDB currentDatabase];
    [db createDataBase];
    [[BmobUserManager currentUserManager] queryCurrentContactArray:^(NSArray *array, NSError *error) {
        NSMutableArray *chatUserArray = [NSMutableArray array];
        for (BmobUser * user in array) {
            BmobChatUser *chatUser = [[BmobChatUser alloc] init];
            chatUser.username      = [user objectForKey:@"username"];
            chatUser.avatar        = [user objectForKey:@"avatar"];
            chatUser.nick          = [user objectForKey:@"nick"];
            chatUser.objectId      = user.objectId;
            [chatUserArray addObject:chatUser];
        }
        [db saveOrCheckContactList:chatUserArray];
    }];
}

+(void)logInWithUsernameInBackground:(NSString *)username password:(NSString *)password block:(BmobUserResultBlock)block{
    [BmobUser loginWithUsernameInBackground:username password:password block:^(BmobUser *user, NSError *error) {
        if (!error) {

            //启动定位

            
            CLLocationDegrees longitude     = [[Location shareInstance] currentLocation].longitude;
            CLLocationDegrees latitude      = [[Location shareInstance] currentLocation].latitude;
            CLLocationCoordinate2D gpsCoor  = CLLocationCoordinate2DMake(latitude, longitude);
            //百度坐标
            CLLocationCoordinate2D bmapCoor = BMKCoorDictionaryDecode(BMKConvertBaiduCoorFrom(gpsCoor,BMK_COORDTYPE_GPS));
            BmobGeoPoint *location          = [[BmobGeoPoint alloc] initWithLongitude:bmapCoor.longitude WithLatitude:bmapCoor.latitude];
            [user setObject:location forKey:@"location"];
            
            [user setObject:location forKey:@"location"];
            //结束定位
            [[Location shareInstance] stopUpateLoaction];
            //更新定位
            [user updateInBackground];
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"selfDeviceToken"]) {
                NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"selfDeviceToken"];
                [[BmobUserManager currentUserManager] checkAndBindDeviceToken:data];
            }
//            //用户存在就创建数据库
//            BmobUser *user = [BmobUser getCurrentUser];
//            if (user) {
//                BmobDB *db = [BmobDB currentDatabase];
//                [db createDataBase];
//            }else{
//                
//            }
        }
        if (block) {
            block(user,error);
        }
    }];

}
+ (void)registerWithUser:(BmobUser *)user block:(BmobBooleanResultBlock)block
{
    [user signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        if (block) {
            block(isSuccessful,error);
        }
    }];
}

+(void)registerWithUsernameInBackground:(NSString *)username
                               password:(NSString *)password userPhoto:(UIImage *)userPhoto email:(NSString *)email
                        locateSucessful:(BOOL)successful
                                  block:(BmobBooleanResultBlock)block{
    
    
    
    BmobUser *user = [[BmobUser alloc] init];
    [user setUserName:username];
    [user setPassword:password];
    [user setEmail:email];
    [user setObject:@"ios" forKey:@"deviceType"];
    if (successful) {
        
        CLLocationDegrees longitude = [[Location shareInstance] currentLocation].longitude;
        CLLocationDegrees latitude  = [[Location shareInstance] currentLocation].latitude;
        CLLocationCoordinate2D gpsCoor = CLLocationCoordinate2DMake(latitude, longitude);
        CLLocationCoordinate2D bmapCoor = BMKCoorDictionaryDecode(BMKConvertBaiduCoorFrom(gpsCoor,BMK_COORDTYPE_GPS));
        BmobGeoPoint *location      = [[BmobGeoPoint alloc] initWithLongitude:bmapCoor.longitude WithLatitude:bmapCoor.latitude];
        [user setObject:location forKey:@"location"];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"selfDeviceToken"]) {
        NSData *data         = [[NSUserDefaults standardUserDefaults] objectForKey:@"selfDeviceToken"];
        NSString *dataString = [NSString stringWithFormat:@"%@",data];
        dataString           = [dataString stringByReplacingOccurrencesOfString:@"<" withString:@""];
        dataString           = [dataString stringByReplacingOccurrencesOfString:@">" withString:@""];
        dataString           = [dataString stringByReplacingOccurrencesOfString:@" " withString:@""];
        [user setObject:dataString forKey:@"installId"];
        [[BmobUserManager currentUserManager] bindDeviceToken:data];
    }
    
    if (userPhoto) {
        
        
        BmobFile *userPhotoFile = [[BmobFile alloc] initWithFileName:[NSString stringWithFormat:@"%@.png", username] withFileData:UIImagePNGRepresentation(userPhoto)];
        [userPhotoFile saveInBackground:^(BOOL isSuccessful, NSError *error) {
            //如果文件保存成功，则把文件添加到filetype列
            if (isSuccessful) {
                [user setObject:userPhotoFile.url  forKey:@"userPhoto"];
                //打印file文件的url地址
                NSLog(@"file1 url %@",userPhotoFile.url);
                [self registerWithUser:user block:block];
                
            }else{
                //进行处理
                NSLog(@"error:%@", error.description);
            }
        }];
        
        
    }else {
        [self registerWithUser:user block:block];
        
    }
    
}



@end
