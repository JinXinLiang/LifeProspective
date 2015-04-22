//
//  main.m
//  LifeProspective
//
//  Created by Eiwodetianna on 15/3/4.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <BmobSDK/Bmob.h>
#import <BmobIM/BmobIM.h>

int main(int argc, char * argv[]) {
    @autoreleasepool {
        [BmobChat registerAppWithAppKey:@"025ca3b25612fdf0230bb6f4ba96ac95"];
        [Bmob registerWithAppKey:@"025ca3b25612fdf0230bb6f4ba96ac95"];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
