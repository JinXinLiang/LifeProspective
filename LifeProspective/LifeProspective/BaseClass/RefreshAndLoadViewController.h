//
//  RefreshAndLoadViewController.h
//  LifeProspective
//
//  Created by Eiwodetianna on 15/3/31.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import "BaseViewController.h"
#import <BmobSDK/Bmob.h>

typedef enum : NSUInteger {
    refreshData = 0,
    loadData = 1,
} GetDataType;

@interface RefreshAndLoadViewController : BaseViewController
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, assign)GetDataType getDataType;
@property (nonatomic, assign)NSInteger limit;
@property (nonatomic, assign)NSInteger skip;
@property (nonatomic, strong)BmobQuery *articleQuery;
- (void)getData;

- (void)setupRefreshWith:(UIScrollView *)scrollView;

@end
