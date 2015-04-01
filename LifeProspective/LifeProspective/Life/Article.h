//
//  Article.h
//  LifeProspective
//
//  Created by Eiwodetianna on 15/3/30.
//  Copyright (c) 2015年 jinxinliang. All rights reserved.
//

#import "BaseModel.h"


@interface Article : BaseModel

@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *pic;
@property (nonatomic, strong)NSDate *createdAt;

@end
