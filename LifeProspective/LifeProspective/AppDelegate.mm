//
//  AppDelegate.m
//  LifeProspective
//
//  Created by Eiwodetianna on 15/3/4.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import "AppDelegate.h"
#import "UIColor+AddColor.h"
#import "LoginViewController.h"
#import "MenuViewController.h"
#import "LifeViewController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "UserService.h"
#import "MBProgressHUD.h"
//#import <BmobIM/BmobChat.h>
#import <BmobIM/BmobDB.h>
//#import <BmobIM/BmobChatManager.h>
#import <BmobIM/BmobIM.h>
//#import "RecentViewController.h"
//#import "ContactsViewController.h"
//#import "SettingViewController.h"
//#import "RootViewController.h"
//#import <BmobSDK/BmobGPSSwitch.h>
#import "BMapKit.h"
//#import "CommonUtil.h"
#import "AudioPalyerManager.h"


@interface AppDelegate ()
//{
//    
//    BMKMapManager *_mapManager;
//}

@property (nonatomic, strong) MenuViewController *menuVC;
@property (strong, nonatomic) BMKMapManager *mapManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    // 是否显示阴影, 否
    [self.drawerController setShowsShadow:NO];
  
    // 设置左视图宽度
    [self.drawerController setMaximumLeftDrawerWidth:120];
    // 设置打开抽屉的状态为全部
//    [self.drawerController setOpenDrawerGestureModeMask:MMCloseDrawerGestureModeCustom];
    // 设置关闭抽屉的状态效果为全部
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    // 设置抽屉的视觉状态的block
    [self.drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[MMExampleDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    
    [self mapManager];
    if (IS_iOS8) {
        //iOS8推送
        UIMutableUserNotificationCategory*categorys = [[UIMutableUserNotificationCategory alloc]init];
        categorys.identifier=@"BmobIMDemo";
        UIUserNotificationSettings*userNotifiSetting = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound)
                                                                                         categories:[NSSet setWithObjects:categorys,nil]];
        [[UIApplication sharedApplication]registerUserNotificationSettings:userNotifiSetting];
        [[UIApplication sharedApplication]registerForRemoteNotifications];
    }else{
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
    }
    
//    [[NSUserDefaults standardUserDefaults ] setObject:[NSNumber numberWithBool:NO] forKey:@"isLogin"];
//
//    NSLog(@"save url:%@", [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
    
//    if (IS_iOS7) {
        [UIApplication sharedApplication].statusBarHidden = NO;
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    }
    
//    [BmobGPSSwitch gpsSwitch:NO];
//    
//    RecentViewController *rvc            = [[RecentViewController alloc] init];
//    UINavigationController *rnc          = [[UINavigationController alloc] initWithRootViewController:rvc];
//    ContactsViewController *cvc          = [[ContactsViewController alloc] init];
//    UINavigationController *cnc          = [[UINavigationController alloc] initWithRootViewController:cvc];
//    SettingViewController *svc           = [[SettingViewController alloc] init];
//    UINavigationController *snc          = [[UINavigationController alloc] initWithRootViewController:svc];
//    
//    RootViewController *tabBarController = [[RootViewController alloc] init];
//    
//    if (IS_iOS7) {
//        [rnc.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_bar"] forBarMetrics:UIBarMetricsDefault];
//        [cnc.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_bar"] forBarMetrics:UIBarMetricsDefault];
//        [snc.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_bar"] forBarMetrics:UIBarMetricsDefault];
//    }else{
//        [rnc.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_bar1"] forBarMetrics:UIBarMetricsDefault];
//        [cnc.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_bar1"] forBarMetrics:UIBarMetricsDefault];
//        [snc.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_bar1"] forBarMetrics:UIBarMetricsDefault];
//    }
//    [tabBarController setViewControllers:@[rnc,cnc,snc]];
//    //百度地图
//    _mapManager = [[BMKMapManager alloc] init];
//    BOOL ret = [_mapManager start:@"6xlUDIyKNzThyF84lV9zfsTp" generalDelegate:nil];
//    if (!ret) {
//        //        NSLog(@"manager start failed!");
//    }
//    [self.drawerController.centerViewController view];
    BOOL hasLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"hasLogin"];
    if (hasLogin) {
        self.window.rootViewController = self.drawerController;
        [self loginDefaultUser];
        
        
        
    } else {
//        [self setupRefreshWith:self.lifeTable];
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:loginVC];
    }
    
    
//    [self creatStatusBarView];

    
   
   
    
    
    return YES;
}

- (void)loginDefaultUser {

    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userDefault objectForKey:@"userName"];
    NSString *password = [userDefault objectForKey:@"password"];
    
    //登陆
    [UserService logInWithUsernameInBackground:userName password:password block:^(BmobUser *user, NSError *error) {
        if (error) {

            
        }else{

                [UserService saveFriendsList];
//                AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//                if ([delegate.window.rootViewController isEqual:self.navigationController]) {
//                    
//                    
//                    delegate.window.rootViewController = delegate.drawerController;
//                    
//                } else {
//                    LifeViewController *lifeVC = [[LifeViewController alloc] init];
//                    // 将主页面加到视图控制器中
//                    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:lifeVC];
//                    delegate.drawerController.centerViewController = navigationController;
//                }
//            });
            
        }
    }];
}

- (BMKMapManager *)mapManager
{
    if (_mapManager != nil) {
        return _mapManager;
    }
    self.mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [_mapManager start:@"cwjdQm35ctY8A1asKvPMYE62" generalDelegate:nil];
    if (!ret) {
                NSLog(@"manager start failed!");
    }
    return _mapManager;
}

- (MMDrawerController *)drawerController
{
    if (nil != _drawerController) {
        return _drawerController;
    }
    // 左抽屉
    self.menuVC = [[MenuViewController alloc] init];
    
    //// 暂时用的主界面
    
    LifeViewController *lifeVC = [[LifeViewController alloc] init];
    // 将主页面加到视图控制器中
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:lifeVC];
    
    // 创建并初始化抽屉视图控制器给他一个主视图, 和左视图
    self.drawerController = [[MMDrawerController alloc]
                             initWithCenterViewController:navigationController
                             leftDrawerViewController:self.menuVC
                             rightDrawerViewController:nil];
    
    return _drawerController;
}

- (void)creatStatusBarView {
    self.statusBarView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH + 10, 20)];
    self.statusBarView.backgroundColor=[UIColor lifeGreenColor];
//    self.statusBarView.layer.shadowOffset = CGSizeMake(-5, 3);
//    self.statusBarView.layer.shadowOpacity = 0.1;
//    self.statusBarView.layer.shadowColor = [UIColor blackColor].CGColor;
    [self.window addSubview:self.statusBarView];
}

#pragma mark remote notification

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"deviceToken %@",deviceToken);
    
    [BmobChat regisetDeviceWithDeviceToken:deviceToken];
    [[NSUserDefaults standardUserDefaults] setObject:deviceToken forKey:@"selfDeviceToken"];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    NSLog(@"userInfo is :%@",[userInfo description]);
    
    if ([userInfo objectForKey:@"tag"]) {
        if ([[[userInfo objectForKey:@"tag"] description] isEqualToString:@"add"]) {
            [self saveInviteMessageWithAddTag:userInfo];
            [BmobPush handlePush:userInfo];
        } else if ([[[userInfo objectForKey:@"tag"] description] isEqualToString:@"agree"]) {
            [self saveInviteMessageWithAgreeTag:userInfo];
        } else if ([[[userInfo objectForKey:@"tag"] description] isEqualToString:@""]) {
            [self saveMessageWith:userInfo];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DidRecieveUserMessage" object:userInfo];
        }
    }
    
}

#pragma mark save
-(void)saveInviteMessageWithAddTag:(NSDictionary *)userInfo{
    BmobInvitation *invitation = [[BmobInvitation alloc] init];
    invitation.avatar          = [[userInfo objectForKey:PUSH_ADD_FROM_AVATAR] description];
    invitation.fromId          = [[userInfo objectForKey:PUSH_ADD_FROM_ID] description];
    invitation.fromname        = [[userInfo objectForKey:PUSH_ADD_FROM_NAME] description];
    invitation.nick            = [[userInfo objectForKey:PUSH_ADD_FROM_NICK] description];
    invitation.time            = [[userInfo objectForKey:PUSH_ADD_FROM_TIME] integerValue];
    invitation.statue          = STATUS_ADD_NO_VALIDATION;
    [[BmobDB currentDatabase] saveInviteMessage:invitation];
}

-(void)saveInviteMessageWithAgreeTag:(NSDictionary *)userInfo{
    BmobInvitation *invitation = [[BmobInvitation alloc] init];
    invitation.avatar          = [[userInfo objectForKey:PUSH_ADD_FROM_AVATAR] description];
    invitation.fromId          = [[userInfo objectForKey:PUSH_ADD_FROM_ID] description];
    invitation.fromname        = [[userInfo objectForKey:PUSH_ADD_FROM_NAME] description];
    invitation.nick            = [[userInfo objectForKey:PUSH_ADD_FROM_NICK] description];
    invitation.time            = [[userInfo objectForKey:PUSH_ADD_FROM_TIME] integerValue];
    invitation.statue          = STATUS_ADD_AGREE;
    
    [[BmobDB currentDatabase] saveInviteMessage:invitation];
    [[BmobDB currentDatabase] saveContactWithMessage: invitation];
    
    //添加到用户的好友关系中
    BmobUser *user = [BmobUser getCurrentUser];
    if (user) {
        BmobUser *friendUser   = [BmobUser objectWithoutDatatWithClassName:@"User" objectId:invitation.fromId];
        BmobRelation *relation = [BmobRelation relation];
        [relation addObject:friendUser];
        [user addRelation:relation forKey:@"contacts"];
        [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if (error) {
                NSLog(@"\n error is :%@",[error description]);
            }
        }];
    }
    
}

-(void)saveMessageWith:(NSDictionary *)userInfo{
    
    BmobChatUser *user = [[BmobDB currentDatabase] queryUserWithUid:[[userInfo objectForKey:PUSH_KEY_TARGETID] description]];
    
    NSString *content = [userInfo objectForKey:PUSH_KEY_CONTENT];
    NSString *toid    = [[userInfo objectForKey:PUSH_KEY_TOID] description];
    int type          = MessageTypeText;
    if ([userInfo objectForKey:PUSH_KEY_MSGTYPE]) {
        type = [[userInfo objectForKey:PUSH_KEY_MSGTYPE] intValue];
    }
    
    
    BmobMsg *msg      = [BmobMsg createReceiveWithUser:user
                                               content:content
                                                  toId:toid
                                                  time:[[userInfo objectForKey:PUSH_KEY_MSGTIME] description]
                                                  type:type status:STATUS_RECEIVER_SUCCESS];
    
    [[BmobDB currentDatabase] saveMessage:msg];
    
    //更新最新的消息
    BmobRecent *recent = [BmobRecent recentObejectWithAvatarString:user.avatar
                                                           message:msg.content
                                                              nick:user.nick
                                                          targetId:msg.belongId
                                                              time:[msg.msgTime integerValue]
                                                              type:msg.msgType
                                                        targetName:user.username];
    
    [[BmobDB currentDatabase] performSelector:@selector(saveRecent:) withObject:recent afterDelay:0.3f];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [BMKMapView willBackGround];
    //让app支持接受远程控制事件
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
}

- (void) remoteControlReceivedWithEvent: (UIEvent *) receivedEvent {
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        
        switch (receivedEvent.subtype) {
                
//            case UIEventSubtypeRemoteControlTogglePlayPause:{
//            
//                [[AudioPalyerManager defaultPlayer].player resume];
//            }
//                break;
//                
//            case UIEventSubtypeRemoteControlPreviousTrack:
//            {
//                
//                [[AudioPalyerManager defaultPlayer].player resume];
//            }
//                break;
//                
//            case UIEventSubtypeRemoteControlNextTrack:
//                [self playNextSong:self.nextButton];
//                break;
                
            case UIEventSubtypeRemoteControlPlay:
            {
                
                [[AudioPalyerManager defaultPlayer].player resume];
            };
                break;
                
            case UIEventSubtypeRemoteControlPause:
            {
                
                [[AudioPalyerManager defaultPlayer].player pause];
            };
                break;
                
            default:
                break;
        }
    }
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [BMKMapView didForeGround];
    //让app支持接受远程控制事件
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//- (void)onGetNetworkState:(int)iError
//{
//    if (0 == iError) {
//        NSLog(@"联网成功");
//    }
//    else{
//        NSLog(@"onGetNetworkState %d",iError);
//    }
//    
//}
//
//- (void)onGetPermissionState:(int)iError
//{
//    if (0 == iError) {
//        NSLog(@"授权成功");
//    }
//    else {
//        NSLog(@"onGetPermissionState %d",iError);
//    }
//}

@end
