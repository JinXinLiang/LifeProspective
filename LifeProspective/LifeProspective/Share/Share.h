//
//  Share.h
//  LifeProspective
//
//  Created by Eiwodetianna on 15/4/11.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import "BaseModel.h"

@interface Share : BaseModel

// 图片地址
@property (nonatomic, copy) NSString *pic;
// 内容
@property (nonatomic, copy) NSString *content;
// 用户
@property (nonatomic, strong) BmobUser *user;

@end
