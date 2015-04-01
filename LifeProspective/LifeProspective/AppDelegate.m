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


@interface AppDelegate ()

@property (nonatomic, strong) MenuViewController *menuVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
     
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    BOOL hasLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"hasLogin"];
    if (!hasLogin) {
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
        // 是否显示阴影, 否
        [self.drawerController setShowsShadow:NO];
        
       
        // 设置左视图宽度
        [self.drawerController setMaximumLeftDrawerWidth:SCREENWIDTH / 4 + 5];
        // 设置打开抽屉的状态为全部
        [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
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
        
        self.window.rootViewController = self.drawerController;
        UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH + 10, 20)];
        
        statusBarView.backgroundColor=[UIColor lifeBlueColor];
        statusBarView.layer.shadowOffset = CGSizeMake(-5, 3);
        statusBarView.layer.shadowOpacity = 0.1;
        statusBarView.layer.shadowColor = [UIColor blackColor].CGColor;
        [self.window addSubview:statusBarView];
        
    } else {
        
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:loginVC];
        
    }
    
   
   
    
    
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
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
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
