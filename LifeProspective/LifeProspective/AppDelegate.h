//
//  AppDelegate.h
//  LifeProspective
//
//  Created by Eiwodetianna on 15/3/4.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMDrawerController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) MMDrawerController * drawerController;
@property (nonatomic, strong) UIView *statusBarView;


- (void)creatStatusBarView;
@end

